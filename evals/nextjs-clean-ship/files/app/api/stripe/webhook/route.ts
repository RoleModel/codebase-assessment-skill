import { stripe } from '@/lib/stripe'
import { db } from '@/lib/db'

export async function POST(req: Request) {
  const body = await req.text()
  const signature = req.headers.get('stripe-signature')!
  let event
  try {
    event = stripe.webhooks.constructEvent(body, signature, process.env.STRIPE_WEBHOOK_SECRET!)
  } catch {
    return new Response('Bad signature', { status: 400 })
  }
  if (event.type === 'checkout.session.completed' && event.data.object.payment_status === 'paid') {
    await db.order.update({ where: { id: event.data.object.metadata!.orderId }, data: { status: 'paid' } })
  }
  return new Response('ok')
}
