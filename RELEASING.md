# Releasing

Versioning is **SemVer** on the user-visible URL params + overlay behavior:

- **MAJOR** — break an existing URL param, remove a feature, rename a CSS hook (`.ch`/`.ti`/`.me`/`#info`/`#bar`).
- **MINOR** — add a param, add a transition, add a builder field. Existing URLs still work.
- **PATCH** — bug fix, perf, tightened defaults that don't change documented behavior.

## How to release

Clean working tree, then:

```bash
./release.sh v1.2.3 "Short release notes"   # explicit version
./release.sh patch "Short release notes"    # or auto-bump: patch | minor | major
```

That script:
1. Validates the version (literal `vX.Y.Z` or auto-bumps `patch|minor|major` off the current `VERSION` in `clips.html`).
2. Checks the tree is clean.
3. Bumps `const VERSION = '...'` in every `*.html` at the repo root.
4. Commits `Release vX.Y.Z`, tags it, pushes branch + tag, creates the GitHub release.

The update banner in all three pages compares its baked-in `VERSION` to the GitHub `releases/latest` tag. Until you `gh release create` (the script does this), the API returns 404 and no banner shows — even if a tag exists.

## When you add a new HTML file

Just bake `const VERSION = 'vX.Y.Z'` (current tag) into it. `release.sh` picks up every `*.html` at the root automatically.

## Rolling back

`gh release delete vX.Y.Z --cleanup-tag` then revert the bump commit. The previous release becomes "latest" again.
