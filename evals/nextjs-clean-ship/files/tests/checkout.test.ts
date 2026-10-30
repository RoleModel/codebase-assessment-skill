import { describe, it, expect, vi, beforeEach } from 'vitest'
vi.mock('@/lib/auth', () => ({ auth: vi.fn() }))
vi.mock('@/lib/db', () => ({ db: { order: { findMany: vi.fn(), create: vi.fn() }, product: { findUniqueOrThrow: vi.fn() } } }))
vi.mock('@/lib/stripe', () => ({ stripe: { checkout: { sessions: { create: vi.fn() } } } }))
import { auth } from '@/lib/auth'
import { db } from '@/lib/db'
import { stripe } from '@/lib/stripe'
import { checkout, listOrders } from '@/app/actions/orders'

beforeEach(() => vi.clearAllMocks())

describe('checkout', () => {
  it('refuses when signed out', async () => {
    vi.mocked(auth).mockResolvedValue(null as never)
    await expect(checkout('prod_1')).rejects.toThrow('Not signed in')
  })

  it('charges the price from the database', async () => {
    vi.mocked(auth).mockResolvedValue({ user: { id: 'u1' } } as never)
    vi.mocked(db.product.findUniqueOrThrow).mockResolvedValue({ id: 'prod_1', name: 'Widget', priceCents: 2500 } as never)
    vi.mocked(db.order.create).mockResolvedValue({ id: 'o1' } as never)
    vi.mocked(stripe.checkout.sessions.create).mockResolvedValue({ url: 'https://checkout.example.com' } as never)
    await checkout('prod_1')
    const args = vi.mocked(stripe.checkout.sessions.create).mock.calls[0][0] as any
    expect(args.line_items[0].price_data.unit_amount).toBe(2500)
  })
})

describe('listOrders', () => {
  it('only asks for the signed-in user\'s orders', async () => {
    vi.mocked(auth).mockResolvedValue({ user: { id: 'u1' } } as never)
    await listOrders()
    expect(db.order.findMany).toHaveBeenCalledWith({ where: { userId: 'u1' } })
  })
})
