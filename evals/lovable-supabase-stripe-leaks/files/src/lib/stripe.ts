import Stripe from 'stripe'

export const stripe = new Stripe(import.meta.env.VITE_STRIPE_SECRET_KEY)

export async function createCheckout(bookingId: string, amountCents: number) {
  return stripe.checkout.sessions.create({
    mode: 'payment',
    line_items: [{
      price_data: { currency: 'usd', unit_amount: amountCents, product_data: { name: 'Widget repair' } },
      quantity: 1
    }],
    metadata: { bookingId },
    success_url: `${window.location.origin}/success?booking=${bookingId}`,
    cancel_url: `${window.location.origin}/book`
  })
}
