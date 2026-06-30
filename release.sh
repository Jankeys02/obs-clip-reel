#!/usr/bin/env bash
# Usage: ./release.sh <vX.Y.Z | patch | minor | major> ["release notes"]
# Bumps VERSION in every *.html, commits, tags, pushes, creates GitHub release.
# Requires: gh CLI authenticated. Run from repo root. Working tree must be clean.
set -euo pipefail

ARG="${1:?usage: ./release.sh <vX.Y.Z|patch|minor|major> [notes]}"
NOTES="${2:-}"

[[ -z "$(git status --porcelain)" ]] || { echo "working tree not clean"; exit 1; }

OLD=$(grep -oP "const VERSION = '\Kv[0-9]+\.[0-9]+\.[0-9]+" clips.html | head -1)
[[ -n "$OLD" ]] || { echo "couldn't read current VERSION from clips.html"; exit 1; }

# ponytail: accept literal vX.Y.Z, or patch/minor/major to auto-bump from $OLD
case "$ARG" in
  v[0-9]*.[0-9]*.[0-9]*) NEW="$ARG" ;;
  patch|minor|major)
    IFS=. read -r MA MI PA <<<"${OLD#v}"
    case "$ARG" in
      patch) PA=$((PA+1)) ;;
      minor) MI=$((MI+1)); PA=0 ;;
      major) MA=$((MA+1)); MI=0; PA=0 ;;
    esac
    NEW="v${MA}.${MI}.${PA}"
    ;;
  *) echo "version must look like v1.2.3 or be patch|minor|major"; exit 1 ;;
esac

[[ "$NEW" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "computed bad version: $NEW"; exit 1; }
[[ "$NEW" != "$OLD" ]] || { echo "already at $NEW"; exit 1; }

NOTES="${NOTES:-Release $NEW}"

# ponytail: glob every html so new files are covered without editing this script
for f in *.html; do
  sed -i "s/const VERSION = '$OLD'/const VERSION = '$NEW'/" "$f"
done

git add -- *.html
git commit -m "Release $NEW"
git tag -a "$NEW" -m "$NOTES"
git push origin HEAD "$NEW"
gh release create "$NEW" --title "$NEW" --notes "$NOTES"

echo "Released $NEW ($OLD → $NEW). Update banner now lights up for older copies."
