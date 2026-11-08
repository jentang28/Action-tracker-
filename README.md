# Meeting Action Tracker

A single-page app for keeping track of actions agreed in meetings.

- Add an action with an owner and a due date
- Actions are grouped by owner, with a tick box to mark each one done
- Open, done and overdue counts at the top; overdue actions are shown in red
- Data is saved in the browser's local storage

## Run locally

Open `index.html` in any modern browser. No build step or dependencies.

## Deploy to Vercel

1. In Vercel, choose **Add New → Project** and import this GitHub repository.
2. Framework preset: **Other**. Leave the build command and output directory empty.
3. Select **Deploy**.

`vercel.json` adds clean URLs and a couple of basic security headers.

## Important: data is per browser

Actions are stored in each visitor's own browser (`localStorage`). Teammates
will not see each other's actions, and clearing browser data removes them.
A shared team list would need a backend or database.
