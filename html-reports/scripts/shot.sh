#!/usr/bin/env bash
# Screenshot an HTML page with headless Chrome so the page can be checked by eye.
# Usage: shot.sh <page.html> <out.png> [width] [height]
# Headless --screenshot exits by itself; a throwaway profile keeps it away from
# the user's real Chrome profile and running browser.
set -euo pipefail

page="${1:?usage: shot.sh <page.html> <out.png> [width] [height]}"
out="${2:?usage: shot.sh <page.html> <out.png> [width] [height]}"
width="${3:-1000}"
height="${4:-3000}"

chrome=""
for candidate in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)" \
  "$(command -v chromium-browser 2>/dev/null || true)"; do
  if [ -n "$candidate" ] && [ -x "$candidate" ]; then chrome="$candidate"; break; fi
done
if [ -z "$chrome" ]; then echo "no Chrome or Chromium found" >&2; exit 1; fi

profile="$(mktemp -d)"
trap 'command rm -rf "$profile"' EXIT

abs="$(cd "$(dirname "$page")" && pwd)/$(basename "$page")"
"$chrome" --headless=new --disable-gpu --hide-scrollbars \
  --user-data-dir="$profile" --window-size="$width,$height" \
  --screenshot="$out" "file://$abs" >/dev/null 2>&1
echo "$out"
