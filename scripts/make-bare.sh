#!/usr/bin/env bash
# scripts/make-bare.sh <dest> - write Kettle WITHOUT any Scry hook, to try the Scry skill on.
#
# The copy has no ScryLaunch.swift, ScryScreens.swift, capture scripts, registry test, Scry workflow
# or README text, and KettleApp.swift is not wired to ScryLaunchRoot. It is generated, never committed,
# so it cannot drift from the app. Check it with:
#   xcodebuild -project <dest>/Kettle.xcodeproj -scheme Kettle -sdk iphonesimulator build
set -euo pipefail
cd "$(dirname "$0")/.."

dest="${1:?usage: scripts/make-bare.sh <dest>}"
if [ -e "$dest" ] && [ -n "$(ls -A "$dest" 2>/dev/null)" ]; then
  echo "make-bare: $dest exists and is not empty" >&2
  exit 1
fi
mkdir -p "$dest"

# Copy tracked and new (untracked, not ignored) files; works in a git checkout or an rsynced copy.
if git rev-parse --git-dir >/dev/null 2>&1; then
  git ls-files -co --exclude-standard -z | rsync -a --from0 --files-from=- ./ "$dest/"
else
  rsync -a --exclude .git --exclude-from=.gitignore ./ "$dest/"
fi

# Remove everything Scry-specific.
rm -f "$dest/Kettle/ScryLaunch.swift" "$dest/Kettle/ScryScreens.swift" \
      "$dest/KettleTests/ScryRegistryTests.swift" \
      "$dest/.github/workflows/scry-capture.yml"
rm -rf "$dest/scripts" "$dest/docs"

# Unwrap the entry point: drop the two lines marked `scry-hook`.
grep -v 'scry-hook' "$dest/Kettle/KettleApp.swift" >"$dest/Kettle/KettleApp.swift.tmp"
mv "$dest/Kettle/KettleApp.swift.tmp" "$dest/Kettle/KettleApp.swift"

# The CI workflow keeps only the build-and-test step; the Release check and the workflow rules are Scry's.
sed -i.bak '/- name: Release build has no capture code/,$d' "$dest/.github/workflows/ci.yml"
# The skill adds `.scry/` to .gitignore itself; the bundle id is the first thing a user changes.
grep -v '^\.scry/' "$dest/.gitignore" | grep -v 'Scry capture output' >"$dest/.gitignore.tmp" && mv "$dest/.gitignore.tmp" "$dest/.gitignore"
sed -i.bak 's/com\.scryorg\.kettle/com.example.kettle/g' "$dest/Kettle.xcodeproj/project.pbxproj"
find "$dest" -name '*.bak' -delete

cat >"$dest/README.md" <<'README'
# Kettle (bare)

A small SwiftUI coffee-order app with no Scry capture hook. Open `Kettle.xcodeproj` and run the
`Kettle` scheme. Use it to try the `scry-native-capture-setup` skill.
README

echo "make-bare: wrote $dest ($(find "$dest" -type f | wc -l | tr -d ' ') files)"
