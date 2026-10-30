import { useEffect } from 'react'
import dayjs from 'dayjs'
import { supabase } from '../lib/supabase'

export default function Success() {
  useEffect(() => {
    const id = new URLSearchParams(window.location.search).get('booking')
    supabase.from('bookings').update({ paid: true, paid_at: dayjs().toISOString() }).eq('id', id)
  }, [])
  return <p>Thanks! Your booking is confirmed.</p>
}
