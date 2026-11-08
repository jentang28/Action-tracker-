-- Add a team member. Run in the Supabase SQL Editor.
-- Replace the three values below. The user signs in with the username.
-- Usernames map to <username>@actiontracker.local behind the scenes.
-- Alternatively: Supabase dashboard > Authentication > Users > Add user,
-- using the email <username>@actiontracker.local and ticking "Auto Confirm User".
with v as (
  select 'newuser'::text as username, 'New User'::text as display_name, 'TEMPORARY-PASSWORD'::text as pw
), u as (
  insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
    confirmation_token, recovery_token, email_change_token_new, email_change,
    email_change_token_current, reauthentication_token, phone_change, phone_change_token)
  select '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    v.username || '@actiontracker.local', extensions.crypt(v.pw, extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    jsonb_build_object('username', v.username, 'display_name', v.display_name),
    now(), now(), '', '', '', '', '', '', '', ''
  from v returning id, email
)
insert into auth.identities (id, user_id, provider_id, identity_data, provider, created_at, updated_at)
select gen_random_uuid(), u.id, u.id::text,
  jsonb_build_object('sub', u.id::text, 'email', u.email, 'email_verified', true, 'phone_verified', false),
  'email', now(), now()
from u;

-- Reset a user's password:
-- update auth.users set encrypted_password = extensions.crypt('NEW-PASSWORD', extensions.gen_salt('bf'))
-- where email = 'username@actiontracker.local';
