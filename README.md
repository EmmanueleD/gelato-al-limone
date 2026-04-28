# Il Gelato al Limone — Supabase Playground

## Setup Supabase

1. Crea un progetto su [supabase.com](https://supabase.com) → **New project**
2. Vai su **SQL Editor** nel dashboard e incolla il contenuto di `supabase/migrations/0001_init.sql`, poi esegui
3. Vai su **Settings → API** e copia:
   - **Project URL** → `PUBLIC_SUPABASE_URL`
   - **anon public** key → `PUBLIC_SUPABASE_ANON_KEY`
4. Crea un file `.env.local` nella root del progetto:
   ```
   PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
   PUBLIC_SUPABASE_ANON_KEY=eyJ...
   ```
5. Verifica che **Realtime** sia abilitato: **Database → Replication** → le tabelle `votes` e `confessioni` devono essere nella pubblicazione `supabase_realtime` (il migration SQL lo fa automaticamente, ma controlla che il toggle Realtime sia ON nel progetto)

> **Nota**: la `anon key` è pubblica per design (Supabase pattern). Le tabelle sono protette da Row Level Security — solo SELECT e INSERT anonimi sono permessi, niente UPDATE o DELETE.

---

# Astro Starter Kit: Minimal

```sh
npm create astro@latest -- --template minimal
```

> 🧑‍🚀 **Seasoned astronaut?** Delete this file. Have fun!

## 🚀 Project Structure

Inside of your Astro project, you'll see the following folders and files:

```text
/
├── public/
├── src/
│   └── pages/
│       └── index.astro
└── package.json
```

Astro looks for `.astro` or `.md` files in the `src/pages/` directory. Each page is exposed as a route based on its file name.

There's nothing special about `src/components/`, but that's where we like to put any Astro/React/Vue/Svelte/Preact components.

Any static assets, like images, can be placed in the `public/` directory.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

## 👀 Want to learn more?

Feel free to check [our documentation](https://docs.astro.build) or jump into our [Discord server](https://astro.build/chat).
