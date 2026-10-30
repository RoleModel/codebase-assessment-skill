create table profiles (
  id uuid primary key references auth.users,
  full_name text,
  phone text,
  home_address text
);

create table services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price integer not null
);

create table bookings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  service_id uuid references services not null,
  slot timestamptz not null,
  amount_cents integer not null,
  paid boolean default false,
  paid_at timestamptz
);

alter table bookings enable row level security;
create policy "own bookings" on bookings for all using (auth.uid() = user_id);
