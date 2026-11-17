# Vista Store Audit

Mobile, bilingual (EN/ES) short-form Quality & Food Safety audit. Static site for GitHub Pages; submissions and photos are stored in Supabase.

## Setup (about 10 minutes)

1. **Supabase:** create a project (a new one just for Vista is cleanest). Open **SQL Editor**, paste `supabase-setup.sql` and click **Run**.
2. In Supabase, go to **Project Settings → API** and copy the **Project URL** and the **anon public** key.
3. Open `index.html`, find the `CONFIG` block near the top of the script, and paste both values.
4. **GitHub:** create a repo named `vista-store-audit`, upload `index.html`, then go to **Settings → Pages → Deploy from branch → main / root**.
5. The form will be live at `https://miguelpinatx.github.io/vista-store-audit/`. On a phone, use **Add to Home Screen**.

## Notes
- Anyone with the link can submit and view audits. Don't put anything confidential in observations.
- To fix or delete a submitted audit, edit the `store_audits` table in the Supabase dashboard.
