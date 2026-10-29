import { notFound, redirect } from 'next/navigation'
import { auth } from '@/lib/auth'
import { db } from '@/lib/db'

export default async function OrderPage({ params }: { params: Promise<{ id: string }> }) {
  const session = await auth()
  if (!session?.user?.id) redirect('/api/auth/signin')
  const { id } = await params
  const order = await db.order.findFirst({ where: { id, userId: session.user.id } })
  if (!order) notFound()
  return <p>Order {order.id}: {order.status}</p>
}
