import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

Deno.serve(async (req) => {
  const event = await req.json()
  if (event.type === 'checkout.session.completed') {
    const supabase = createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!)
    await supabase.from('bookings').update({ paid: true }).eq('id', event.data.object.metadata.bookingId)
  }
  return new Response('ok')
})
