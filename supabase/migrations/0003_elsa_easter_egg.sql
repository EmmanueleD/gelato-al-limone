alter table confessioni
  drop constraint if exists confessioni_testo_check;

alter table confessioni
  add constraint confessioni_testo_check check (char_length(testo) between 1 and 50000);

drop policy if exists "insert own confessioni" on confessioni;

create policy "insert own confessioni" on confessioni
  for insert
  with check (char_length(testo) between 1 and 50000);
