import { useState } from 'react'
import moment from 'moment'
import { supabase } from '../lib/supabase'
import { createCheckout } from '../lib/stripe'

export default function Book({ service }: { service: { id: string; price: number } }) {
  const [slot, setSlot] = useState('')

  async function book() {
    const { data: { user } } = await supabase.auth.getUser()
    const { data: booking } = await supabase
      .from('bookings')
      .insert({ user_id: user!.id, service_id: service.id, slot: moment(slot).toISOString(), amount_cents: service.price })
      .select()
      .single()
    const session = await createCheckout(booking.id, service.price)
    window.location.href = session.url!
  }

  return <button onClick={book}>Book and pay</button>
}
