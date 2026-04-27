# Deploy Guide — gelato-al-limone

## Environments

| Environment | Branch | URL | Supabase DB |
|-------------|--------|-----|-------------|
| Production | `main` | gelato-al-limone.vercel.app | `gelato-production` (`gywqgfhxcwfwqkecilhi`) |
| Staging | `staging` | gelato-al-limone-git-staging-emmanueleds-projects.vercel.app | `gelato-staging` (`xnfbyuftyvdajkkrqjtu`) |

---

## Daily Workflow

### Lavorare su una feature o fix

```bash
# Assicurati di essere su staging
git checkout staging

# Fai le modifiche, poi committa
git add <files>
git commit -m "feat: descrizione"
git push origin staging
```

→ Vercel deploya automaticamente su staging. Verifica su [staging URL].

### Portare in production

1. Apri una Pull Request su GitHub: `staging` → `main`
2. Verifica il deploy di staging una volta di più
3. Mergia la PR
4. Vercel deploya automaticamente su production

> Il branch `staging` non viene cancellato dopo il merge — continui a lavorarci.

---

## Setup da Zero (replicare su un nuovo progetto)

### Prerequisiti

- Account GitHub
- Account Vercel (free tier)
- Account Supabase (free tier — max 2 progetti attivi)
- Supabase CLI installato: `brew install supabase/tap/supabase`

### Step 1 — GitHub

```bash
# Nella cartella del progetto
git init
git add .
git commit -m "feat: initial commit"
git remote add origin https://github.com/<utente>/<repo>.git
git push -u origin main

# Crea branch staging
git checkout -b staging
git push -u origin staging
```

### Step 2 — Supabase Staging

1. Crea progetto su [supabase.com](https://supabase.com) → nome: `<progetto>-staging`
2. Copia il **Project Ref** da Settings → General
3. Copia **URL** e **anon key** da Settings → API

```bash
supabase login           # solo la prima volta
supabase link --project-ref <staging-ref> --password '<db-password>'
supabase db push
```

> Metti la password tra singoli apici se contiene caratteri speciali (`!`, `$`, `^`, ecc.)

### Step 3 — Supabase Production

Stesso procedimento con il progetto `<progetto>-production`:

```bash
supabase link --project-ref <production-ref> --password '<db-password>'
supabase db push
```

### Step 4 — Vercel

1. [vercel.com](https://vercel.com) → **Add New Project** → **Import Git Repository**
2. Seleziona il repo GitHub (autorizza l'accesso se necessario)
3. Framework preset: rilevato automaticamente (Astro, Next.js, ecc.)
4. **Prima di deployare**, aggiungi le Environment Variables:

| Variable | Value | Scope |
|----------|-------|-------|
| `PUBLIC_SUPABASE_URL` | URL di `<progetto>-production` | **Production** |
| `PUBLIC_SUPABASE_ANON_KEY` | anon key di `<progetto>-production` | **Production** |
| `PUBLIC_SUPABASE_URL` | URL di `<progetto>-staging` | **Preview** |
| `PUBLIC_SUPABASE_ANON_KEY` | anon key di `<progetto>-staging` | **Preview** |

5. Deploy.

> Per API Node.js su Vercel: stesso procedimento, nessuna differenza nel setup di branch/env vars.

### Step 5 — Verifica

```bash
# Committa qualcosa su staging e pusha
git checkout staging
git push origin staging
```

- Verifica che Vercel deploya su staging con le credenziali di staging
- Inserisci un dato → controlla che appaia solo nel DB di staging
- Apri PR `staging` → `main`, mergia
- Verifica che Vercel deploya su production con le credenziali di production

---

## Variabili d'ambiente locali

Copia `.env.example` in `.env.local` e usa le credenziali di staging per lo sviluppo locale:

```bash
cp .env.example .env.local
```

`.env.local` è in `.gitignore` — non viene mai committato.

---

## Aggiungere una migration

```bash
# Crea il file di migration
supabase migration new <nome-migration>

# Applica su staging
supabase link --project-ref <staging-ref> --password '<password>'
supabase db push

# Dopo verifica, applica su production
supabase link --project-ref <production-ref> --password '<password>'
supabase db push
```
