#!/usr/bin/env bash
# Usage: ./release.sh v1.2.3 ["release notes"]
# Bumps VERSION in all html files, commits, tags, pushes, creates GitHub release.
# Requires: gh CLI authenticated. Run from repo root. Working tree must be clean.
set -euo pipefail

NEW="${1:?usage: ./release.sh vX.Y.Z [notes]}"
NOTES="${2:-Release $NEW}"

[[ "$NEW" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "version must look like v1.2.3"; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "working tree not clean"; exit 1; }

OLD=$(grep -oP "const VERSION = '\Kv[0-9]+\.[0-9]+\.[0-9]+" clips.html | head -1)
[[ "$NEW" != "$OLD" ]] || { echo "already at $NEW"; exit 1; }

# ponytail: sed across the three known files; if a new html file is added, add it here
for f in clips.html cssbuilder.html sourcebuilder.html; do
  sed -i "s/const VERSION = '$OLD'/const VERSION = '$NEW'/" "$f"
done

git add clips.html cssbuilder.html sourcebuilder.html
git commit -m "Release $NEW"
git tag -a "$NEW" -m "$NOTES"
git push origin HEAD "$NEW"
gh release create "$NEW" --title "$NEW" --notes "$NOTES"

echo "Released $NEW ($OLD → $NEW). Update banner now lights up for older copies."
