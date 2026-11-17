-- Vista Store Audit — one-time Supabase setup
-- Paste this whole file into Supabase → SQL Editor → New query → Run.

-- 1) Table that holds each submitted audit
create table if not exists public.store_audits (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  store       text not null,
  audit_date  date,
  auditor     text,
  final_grade numeric,
  data        jsonb not null            -- every grade, note, photo path, section score, action plan
);

alter table public.store_audits enable row level security;

-- Anyone with the form link can submit and read audits.
-- No update or delete from the form: edit or remove rows in the Supabase dashboard.
drop policy if exists "audit form can insert" on public.store_audits;
create policy "audit form can insert" on public.store_audits
  for insert to anon, authenticated with check (true);

drop policy if exists "audit form can read" on public.store_audits;
create policy "audit form can read" on public.store_audits
  for select to anon, authenticated using (true);

-- 2) Photo storage bucket (public read so photos display in History)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('audit-photos', 'audit-photos', true, 10485760, array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do nothing;

drop policy if exists "audit form can upload photos" on storage.objects;
create policy "audit form can upload photos" on storage.objects
  for insert to anon, authenticated with check (bucket_id = 'audit-photos');

drop policy if exists "audit photos are readable" on storage.objects;
create policy "audit photos are readable" on storage.objects
  for select to anon, authenticated using (bucket_id = 'audit-photos');
