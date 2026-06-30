# Twitch Clips Player for OBS

Three static HTML files, zero dependencies, zero build step. Plays Twitch clips as an OBS Browser Source with chat control, transitions, and custom styling.

- **`clips.html`** — the player itself. Drop into OBS as a Browser Source.
- **`sourcebuilder.html`** — form-based URL builder. Fill in the fields, copy the URL into OBS.
- **`cssbuilder.html`** — visual overlay designer with a live 16:9 preview. Drag/resize/style, then paste the generated CSS into OBS Browser Source → Custom CSS.

## Setup

1. Register an app at [dev.twitch.tv/console](https://dev.twitch.tv/console/apps/create).
   - **OAuth Redirect URL:** `http://localhost`
   - **Category:** Application Integration
   - **Type:** Public
   - Copy the **Client ID**.
2. Get a user OAuth token — paste this URL in your browser (replace `CLIENT_ID`):
   ```
   https://id.twitch.tv/oauth2/authorize?client_id=CLIENT_ID&redirect_uri=http://localhost&response_type=token&scope=chat:read
   ```
   Twitch redirects to `http://localhost/#access_token=XXXX` (page fails to load — fine, the token is in the address bar). Copy the `access_token` value.
3. Open `sourcebuilder.html` in your browser, fill in channel + Client ID + token + any options, copy the resulting URL.
4. In OBS: add a **Browser Source** → point it at the local `clips.html` (or paste the full URL) → set size to 1920×1080 → check "Shutdown source when not visible".

Your Client ID and token live only in the OBS source URL — they're never stored in these files.

## Features

- Multiple channels, sort by recent/top, date range, game filter, view/duration filters, include/exclude title words, no-repeat memory
- Volume, gap, video fit, overlay position/templates with `{channel} {title} {game} {views}` etc.
- Transitions: fade, slide, zoom, or a custom video file between clips
- Chat control: `!clipsreel` start, `!clipskip` / `!clippause` / `!clipplay` / `!clipreload` (mods-only by default)
- Debug overlay (`debug=true`) for live troubleshooting

Full parameter reference is in the comment at the top of `clips.html`.

## License

MIT
