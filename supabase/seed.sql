-- Example actions (marked is_example; the app's "Remove examples" button deletes them)
insert into public.actions (title, owner, due, done, is_example) values
('Share revised Q1 budget with finance', 'Priya', '2026-11-05', false, true),
('Book room for the planning workshop', 'Priya', '2026-11-12', false, true),
('Circulate meeting notes to the team', 'Priya', '2026-11-03', true, true),
('Draft onboarding checklist for new hires', 'Marcus', '2026-11-08', false, true),
('Confirm vendor quote for laptops', 'Marcus', '2026-11-07', false, true),
('Update the project timeline slide', 'Wei Ling', '2026-11-15', false, true),
('Follow up on client feedback', 'Wei Ling', '2026-11-06', true, true);
