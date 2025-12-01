-- ================================
-- TABLE: users
-- ================================
create table users (
  id uuid primary key default gen_random_uuid(),
  username text,
  avatar_url text,
  created_at timestamp with time zone default now()
);

-- Contoh data awal (opsional)
insert into users (id, username, avatar_url)
values
  (gen_random_uuid(), 'admin', 'https://source.unsplash.com/300x300/?avatar');

-- Aktifkan Row Level Security
alter table users enable row level security;

-- Policy: authenticated user boleh lihat data dirinya
create policy "Users can view their own data"
on users
for select
to authenticated
using (auth.uid() = id);

-- Policy: authenticated user boleh update data dirinya
create policy "Users can update their own data"
on users
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);



-- ================================
-- TABLE: products
-- ================================
create table products (
  id bigint primary key generated always as identity,
  title text not null,
  description text,
  price numeric not null,
  category text,
  image_url text,
  created_at timestamp with time zone default now()
);

-- Contoh data awal
insert into products (title, description, price, category)
values
  ('Vape X12', 'Vape premium rasa stroberi', 120000, 'strawberry'),
  ('Vape Mint Pro', 'Sensasi mint dingin maksimal', 150000, 'mint'),
  ('Cloud Master 3000', 'Asap tebal dan rasa kuat', 200000, 'classic');

-- Aktifkan RLS
alter table products enable row level security;

-- Semua user (bahkan anon) boleh read
create policy "Public can read products"
on products
for select
to public
using (true);

-- Admin-mode: authenticated boleh insert/update/delete
create policy "Authenticated can insert products"
on products
for insert
to authenticated
with check (true);

create policy "Authenticated can update products"
on products
for update
to authenticated
using (true)
with check (true);

create policy "Authenticated can delete products"
on products
for delete
to authenticated
using (true);



-- ================================
-- TABLE: favorites
-- ================================
create table favorites (
  id bigint primary key generated always as identity,
  user_id uuid not null references users(id) on delete cascade,
  product_id bigint not null references products(id) on delete cascade,
  title text not null,
  price numeric not null,
  image_url text not null,
  created_at timestamp with time zone default now()
);

-- Contoh data awal
insert into favorites (user_id, product_id, title, price, image_url)
select id, 1, 'Vape X12', 120000, 'https://source.unsplash.com/800x600/?vape' from users limit 1;

insert into favorites (user_id, product_id, title, price, image_url)
select id, 2, 'Vape Mint Pro', 150000, 'https://source.unsplash.com/800x600/?mint' from users limit 1;

-- Aktifkan RLS
alter table favorites enable row level security;

-- Hanya pemilik bisa melihat favoritnya
create policy "Users can read own favorites"
on favorites
for select
to authenticated
using (auth.uid() = user_id);

-- Hanya pemilik dapat insert
create policy "Users can insert own favorites"
on favorites
for insert
to authenticated
with check (auth.uid() = user_id);

-- Hanya pemilik dapat update
create policy "Users can update own favorites"
on favorites
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Hanya pemilik dapat delete
create policy "Users can delete own favorites"
on favorites
for delete
to authenticated
using (auth.uid() = user_id);



-- ================================
-- STORAGE BUCKET (untuk avatar / produk)
-- ================================
insert into storage.buckets (id, name, public)
values ('images', 'images', true)
on conflict (id) do update set public = true;

-- Izinkan user manage gambar miliknya
create policy "Authenticated users manage own images"
on storage.objects
for all
to authenticated
using (bucket_id = 'images' and auth.uid() = owner)
with check (bucket_id = 'images' and auth.uid() = owner);

-- Siapa pun boleh melihat gambar
create policy "Anyone can view images"
on storage.objects
for select
to public
using (bucket_id = 'images');


create table locations (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id) on delete cascade,
  latitude double precision not null,
  longitude double precision not null,
  accuracy double precision,
  provider text not null,   -- GPS atau NETWORK
  created_at timestamp default now()
);

