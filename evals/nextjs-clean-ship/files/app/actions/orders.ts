'use server'
import { auth } from '@/lib/auth'
import { db } from '@/lib/db'
import { stripe } from '@/lib/stripe'

export async function listOrders() {
  const session = await auth()
  if (!session?.user?.id) throw new Error('Not signed in')
  return db.order.findMany({ where: { userId: session.user.id } })
}

export async function checkout(productId: string) {
  const session = await auth()
  if (!session?.user?.id) throw new Error('Not signed in')
  const product = await db.product.findUniqueOrThrow({ where: { id: productId } })
  const order = await db.order.create({ data: { userId: session.user.id, productId } })
  const checkoutSession = await stripe.checkout.sessions.create({
    mode: 'payment',
    line_items: [{ price_data: { currency: 'usd', unit_amount: product.priceCents, product_data: { name: product.name } }, quantity: 1 }],
    metadata: { orderId: order.id },
    success_url: `${process.env.APP_URL}/orders/${order.id}`,
    cancel_url: `${process.env.APP_URL}/products`
  })
  return checkoutSession.url
}
