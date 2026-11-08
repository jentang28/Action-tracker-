-- Meeting Action Tracker: table and access rules (already applied to the project)
create table public.actions (
  id uuid primary key default gen_random_uuid(),
  title text not null check (length(trim(title)) > 0),
  owner text not null check (length(trim(owner)) > 0),
  due date not null,
  done boolean not null default false,
  is_example boolean not null default false,
  created_at timestamptz not null default now()
);

create index actions_owner_idx on public.actions (lower(owner));

alter table public.actions enable row level security;

-- The app has no sign-in, so anyone with the app (publishable key) can read and change actions
create policy "Anyone can read actions" on public.actions for select to anon, authenticated using (true);
create policy "Anyone can add actions" on public.actions for insert to anon, authenticated with check (true);
create policy "Anyone can update actions" on public.actions for update to anon, authenticated using (true) with check (true);
create policy "Anyone can delete actions" on public.actions for delete to anon, authenticated using (true);

grant select, insert, update, delete on public.actions to anon, authenticated;
