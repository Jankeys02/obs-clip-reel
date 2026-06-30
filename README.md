# Twitch Clips Player for OBS

Three static HTML files, zero dependencies, zero build step. Plays Twitch clips as an OBS Browser Source with chat control, transitions, and custom styling.

## Quick Start

Nothing to install. Five minutes from zero to clips on stream.

**1. Get a Twitch Client ID.** Register an app at [dev.twitch.tv/console](https://dev.twitch.tv/console/apps/create) — OAuth Redirect `http://localhost`, Category *Application Integration*, Type *Public*. Copy the **Client ID**.

**2. Get a Twitch token.** Paste this in your browser (swap `CLIENT_ID`):
```
https://id.twitch.tv/oauth2/authorize?client_id=CLIENT_ID&redirect_uri=http://localhost&response_type=token&scope=chat:read
```
Twitch bounces you to `http://localhost/#access_token=XXXX`. The page fails to load — that's fine. Copy the `access_token` value from the address bar.

**3. Build your URL.** Open **[sourcebuilder.html](https://jankeys02.github.io/obs-clip-reel/sourcebuilder.html)**, fill in channel + Client ID + token + any options, hit *Copy URL*.

**4. Add to OBS.** New **Browser Source** → paste the URL → size **1920×1080** → check *Shutdown source when not visible*. Done.

**Optional — style the overlay.** Open **[cssbuilder.html](https://jankeys02.github.io/obs-clip-reel/cssbuilder.html)**, drag/resize/style, paste the generated CSS into the same Browser Source's *Custom CSS* field.

## The files

- **[`clips.html`](https://jankeys02.github.io/obs-clip-reel/clips.html)** — the player. Already hosted; you only need a local copy if you want to run offline.
- **[`sourcebuilder.html`](https://jankeys02.github.io/obs-clip-reel/sourcebuilder.html)** — URL builder.
- **[`cssbuilder.html`](https://jankeys02.github.io/obs-clip-reel/cssbuilder.html)** — overlay designer with live 16:9 preview.

Want a local copy? [Download the zip](https://github.com/Jankeys02/obs-clip-reel/releases/latest) or `git clone https://github.com/Jankeys02/obs-clip-reel.git`. The player shows a banner when a new release is tagged — hosted users get it automatically.

**Where your token lives.** At runtime, only in the OBS source URL. In the builders, Client ID + token are held in `sessionStorage` (this tab only, wiped when the tab closes); non-secret form fields stay in `localStorage` so your settings persist. Clear either with the builder's *Clear* button.

## Features

- Multiple channels, sort by recent/top, date range, game filter, view/duration filters, include/exclude title words, no-repeat memory
- Volume, gap, video fit, overlay position/templates with `{channel} {title} {game} {views}` etc.
- Transitions: fade, slide, zoom, or a custom video file between clips
- Chat control: `!clipsreel` start, `!clipskip` / `!clippause` / `!clipplay` / `!clipreload` (mods-only by default)
- Debug overlay (`debug=true`) for live troubleshooting

Full parameter reference is in the comment at the top of `clips.html`.

## License

MIT
