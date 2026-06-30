# Project rules

## Releasing

Never bump version constants by hand and never tag/push releases manually. Use `./release.sh vX.Y.Z "notes"` — it bumps `const VERSION` in all HTML files, commits, tags, pushes, and runs `gh release create` in one shot. The GitHub release step is what makes the in-page update banner light up for older copies; a bare `git push --tags` is silently useless here.

SemVer scope is the **user-visible URL params + overlay behavior**:
- MAJOR — break a param, remove a feature, rename a CSS hook (`.ch`/`.ti`/`.me`/`#info`/`#bar`)
- MINOR — add a param, transition, or builder field; existing URLs still work
- PATCH — bug fix, perf, defaults tightened without changing documented behavior

When adding a new HTML file that the update banner should cover, add it to the `for f in ...` loop in `release.sh` AND bake `const VERSION = 'vX.Y.Z'` matching the current tag into it.

See RELEASING.md for the full procedure and rollback steps.
