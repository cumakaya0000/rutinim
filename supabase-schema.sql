-- Run this once in Supabase Dashboard → SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.habits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 48),
  description text not null default '',
  category text not null default 'Kişisel',
  target_amount integer check (target_amount is null or target_amount > 0),
  target_unit text not null default 'dk',
  weekdays smallint[] not null default array[0,1,2,3,4,5,6]::smallint[],
  color text not null default 'green' check (color in ('green','blue','orange','rose','purple')),
  reminder_time time,
  created_at timestamptz not null default now()
);

-- Apply these additions to an existing project without deleting user data.
alter table public.habits add column if not exists description text not null default '';
alter table public.habits add column if not exists category text not null default 'Kişisel';
alter table public.habits add column if not exists target_amount integer;
alter table public.habits add column if not exists target_unit text not null default 'dk';
alter table public.habits add column if not exists weekdays smallint[] not null default array[0,1,2,3,4,5,6]::smallint[];
alter table public.habits add column if not exists color text not null default 'green';

create table if not exists public.completions (
  user_id uuid not null references auth.users(id) on delete cascade,
  habit_id uuid not null references public.habits(id) on delete cascade,
  completed_on date not null,
  primary key (user_id, habit_id, completed_on)
);

alter table public.habits enable row level security;
alter table public.completions enable row level security;

create policy "Users manage their own habits" on public.habits
  for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users manage their own completions" on public.completions
  for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
