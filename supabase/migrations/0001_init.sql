-- votes: one row per anonymous vote
create table public.votes (
  id         bigint generated always as identity primary key,
  created_at timestamptz not null default now()
);

alter table public.votes enable row level security;

create policy "votes_select_public"
  on public.votes for select
  to anon, authenticated
  using (true);

create policy "votes_insert_public"
  on public.votes for insert
  to anon, authenticated
  with check (true);

-- confessioni: anonymous confessions, max 280 chars
create table public.confessioni (
  id         bigint generated always as identity primary key,
  testo      text not null check (char_length(testo) between 1 and 280),
  created_at timestamptz not null default now()
);

alter table public.confessioni enable row level security;

create policy "confessioni_select_public"
  on public.confessioni for select
  to anon, authenticated
  using (true);

create policy "confessioni_insert_public"
  on public.confessioni for insert
  to anon, authenticated
  with check (char_length(testo) between 1 and 280);

create index confessioni_created_at_desc on public.confessioni (created_at desc);

-- enable realtime on both tables
alter publication supabase_realtime add table public.votes;
alter publication supabase_realtime add table public.confessioni;
