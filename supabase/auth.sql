-- Sign-in setup (already applied to the project)

-- 1. Profiles: one row per login, linked to Supabase's built-in auth.users
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique check (username ~ '^[a-z0-9_.-]{2,32}$'),
  display_name text not null,
  created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
create policy "Signed-in users can see team profiles" on public.profiles for select to authenticated using (true);
create policy "Users can update their own profile" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);
grant select, update (display_name) on public.profiles to authenticated;

-- 2. Create a profile automatically when a user is added to auth.users
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  insert into public.profiles (id, username, display_name)
  values (new.id,
          lower(coalesce(new.raw_user_meta_data->>'username', split_part(new.email, '@', 1))),
          coalesce(new.raw_user_meta_data->>'display_name', initcap(split_part(new.email, '@', 1))));
  return new;
end; $$;
revoke execute on function public.handle_new_user() from public, anon, authenticated;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();

-- 3. Record who added each action; signed-in users only
alter table public.actions add column created_by uuid references public.profiles(id) on delete set null default auth.uid();
drop policy "Anyone can read actions" on public.actions;
drop policy "Anyone can add actions" on public.actions;
drop policy "Anyone can update actions" on public.actions;
drop policy "Anyone can delete actions" on public.actions;
revoke all on public.actions from anon;
create policy "Signed-in users can read actions" on public.actions for select to authenticated using (true);
create policy "Signed-in users can add actions" on public.actions for insert to authenticated with check (created_by is null or created_by = (select auth.uid()));
create policy "Signed-in users can update actions" on public.actions for update to authenticated using (true) with check (true);
create policy "Signed-in users can delete actions" on public.actions for delete to authenticated using (true);
grant select, insert, update, delete on public.actions to authenticated;
