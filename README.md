# Meeting Action Tracker

A single-page app for keeping track of actions agreed in meetings.

- Add an action with an owner and a due date
- Actions are grouped by owner, with a tick box to mark each one done
- Open, done and overdue counts at the top; overdue actions are shown in red
- Data is saved in a Supabase database, shared by the whole team
- Team members sign in with a username and password, can change their password, and sign out

## Run locally

Open `index.html` in any modern browser. No build step or dependencies.

## Deploy to Vercel

1. In Vercel, choose **Add New → Project** and import this GitHub repository.
2. Framework preset: **Other**. Leave the build command and output directory empty.
3. Select **Deploy**.

`vercel.json` adds clean URLs and a couple of basic security headers.

## Data

Actions are stored in Supabase (`public.actions`), so the whole team sees the
same list. The app refreshes every 30 seconds and whenever the tab is reopened.

- `supabase/schema.sql`: the table and access rules
- `supabase/seed.sql`: the example actions

The Supabase URL and publishable key are in `index.html`. The publishable key
is designed to be used in the browser.

## Sign-in

Logins use Supabase's built-in authentication (`auth.users`). Each user also
has a row in `public.profiles` (username and display name), created
automatically. Only signed-in users can see or change actions.

- `supabase/auth.sql`: profiles table, trigger and access rules
- `supabase/add_user.sql`: how to add a team member or reset a password

Usernames map to `<username>@actiontracker.local` behind the scenes, because
Supabase logins need an email format. These addresses can't receive email, so
password resets are done by an admin (see `add_user.sql`).

## Security note

New users should change their initial password after first sign-in using
**Change password**. Any signed-in team member can edit or delete any action.
