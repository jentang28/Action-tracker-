# Meeting Action Tracker

A single-page app for keeping track of actions agreed in meetings.

- Add an action with an owner and a due date
- Actions are grouped by owner, with a tick box to mark each one done
- Open, done and overdue counts at the top; overdue actions are shown in red
- Data is saved in a Supabase database, shared by everyone who opens the app

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

## Security note

The app has no sign-in. Anyone who can open the app can add, edit and delete
actions. Keep the link within your team, or add Supabase Auth and tighten the
row level security policies before sharing it more widely.
