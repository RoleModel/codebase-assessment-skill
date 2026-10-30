import { describe, it, expect, vi } from 'vitest'
vi.mock('@/lib/db', () => ({ db: { order: { update: vi.fn() } } }))
vi.mock('@/lib/stripe', () => ({ stripe: { webhooks: { constructEvent: vi.fn() } } }))
import { db } from '@/lib/db'
import { stripe } from '@/lib/stripe'
import { POST } from '@/app/api/stripe/webhook/route'

const req = () => new Request('http://localhost/api/stripe/webhook', { method: 'POST', body: '{}', headers: { 'stripe-signature': 'sig' } })

describe('stripe webhook', () => {
  it('rejects a bad signature', async () => {
    vi.mocked(stripe.webhooks.constructEvent).mockImplementation(() => { throw new Error('bad') })
    expect((await POST(req())).status).toBe(400)
  })

  it('marks the order paid when Stripe says it is paid', async () => {
    vi.mocked(stripe.webhooks.constructEvent).mockReturnValue({
      type: 'checkout.session.completed', data: { object: { payment_status: 'paid', metadata: { orderId: 'o1' } } }
    } as never)
    expect((await POST(req())).status).toBe(200)
    expect(db.order.update).toHaveBeenCalledWith({ where: { id: 'o1' }, data: { status: 'paid' } })
  })
})
