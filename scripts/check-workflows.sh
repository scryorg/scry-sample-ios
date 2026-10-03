#!/usr/bin/env bash
# scripts/check-workflows.sh - fail if the CI split is broken (guarantee G5):
#   ci.yml          hosted runner only, no secrets, runs on pull_request
#   scry-capture.yml only on push to the default branch, hosted runner, never pull_request(_target)
#   no workflow uses pull_request_target or a self-hosted runner
set -euo pipefail
cd "$(dirname "$0")/.."
wf=.github/workflows
fail=0
bad() { echo "check-workflows: $*" >&2; fail=1; }

for f in "$wf"/*.yml; do
  grep -vE '^\s*#' "$f" >/tmp/.wf.$$ || true
  grep -q 'pull_request_target' /tmp/.wf.$$ && bad "$f uses pull_request_target"
  grep -qiE 'self-hosted' /tmp/.wf.$$ && bad "$f uses a self-hosted runner"
  grep -qE 'runs-on:' /tmp/.wf.$$ || bad "$f has no runs-on"
  grep -E 'runs-on:' /tmp/.wf.$$ | grep -vE 'runs-on: *(macos-15|macos-14|ubuntu-latest)\s*$' >/dev/null && bad "$f runs on an unexpected runner"
  rm -f /tmp/.wf.$$
done

# ci.yml: no secrets, runs on pull_request.
grep -vE '^\s*#' "$wf/ci.yml" | grep -qE '\bsecrets\.' && bad "ci.yml references secrets"
grep -vE '^\s*#' "$wf/ci.yml" | grep -qE '^\s*pull_request:' || bad "ci.yml does not run on pull_request"

# scry-capture.yml: push to main only.
c="$(grep -vE '^\s*#' "$wf/scry-capture.yml")"
echo "$c" | grep -qE '^\s*pull_request' && bad "scry-capture.yml runs on pull_request"
echo "$c" | grep -qE '^\s*push:' || bad "scry-capture.yml has no push trigger"
echo "$c" | grep -qE 'branches: *\[main\]' || bad "scry-capture.yml push is not limited to main"
echo "$c" | grep -qE 'secrets\.SCRY_API_KEY' || bad "scry-capture.yml does not use secrets.SCRY_API_KEY"

# Only scry-capture.yml may mention the key at all.
for f in "$wf"/*.yml; do
  [ "$(basename "$f")" = scry-capture.yml ] && continue
  grep -vE '^\s*#' "$f" | grep -qE 'SCRY_API_KEY' && bad "$f mentions SCRY_API_KEY"
done

[ "$fail" -eq 0 ] && echo "check-workflows: ok"
exit "$fail"
