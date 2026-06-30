# Releasing

Versioning is **SemVer** on the user-visible URL params + overlay behavior:

- **MAJOR** — break an existing URL param, remove a feature, rename a CSS hook (`.ch`/`.ti`/`.me`/`#info`/`#bar`).
- **MINOR** — add a param, add a transition, add a builder field. Existing URLs still work.
- **PATCH** — bug fix, perf, tightened defaults that don't change documented behavior.

## How to release

Clean working tree, then:

```bash
./release.sh v1.2.3 "Short release notes"
```

That script:
1. Validates the version string and that the tree is clean.
2. Bumps `const VERSION = '...'` in `clips.html`, `cssbuilder.html`, `sourcebuilder.html`.
3. Commits `Release vX.Y.Z`, tags it, pushes branch + tag, creates the GitHub release.

The update banner in all three pages compares its baked-in `VERSION` to the GitHub `releases/latest` tag. Until you `gh release create` (the script does this), the API returns 404 and no banner shows — even if a tag exists.

## When you add a new HTML file

Add the filename to the `for f in ...` loop in `release.sh` and bake `const VERSION = 'vX.Y.Z'` matching the current tag.

## Rolling back

`gh release delete vX.Y.Z --cleanup-tag` then revert the bump commit. The previous release becomes "latest" again.
