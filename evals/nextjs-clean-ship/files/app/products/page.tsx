import { redirect } from 'next/navigation'
import { db } from '@/lib/db'
import { checkout } from '@/app/actions/orders'

export default async function Products() {
  const products = await db.product.findMany()
  return (
    <ul>
      {products.map((p) => (
        <li key={p.id}>
          {p.name}
          <form action={async () => { 'use server'; redirect((await checkout(p.id))!) }}><button>Buy</button></form>
        </li>
      ))}
    </ul>
  )
}
