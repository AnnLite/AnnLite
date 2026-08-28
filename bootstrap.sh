#!/usr/bin/env bash
#
# Ann Lite — Meta-Repo Bootstrap
#
# Adds every Ann Lite repository as a git submodule of THIS repo, but does
# so one at a time and skips (with a warning) any repo whose remote isn't
# reachable yet — so you can run this before every repo has been pushed
# to GitHub and re-run it later to pick up the rest.
#
# Usage:
#   ./scripts/bootstrap.sh [org-name]
#
# Defaults to "AnnLite" as the org name if not given.

set -uo pipefail

ORG="${1:-AnnLite}"
BASE_URL="https://github.com/${ORG}"

# repo-name:local-path pairs. Local path differs from repo name only for
# "Ann Lite" (GitHub repo names can't contain spaces, so it's pushed as
# "Ann-Lite" but we still want a readable local folder name).
REPOS=(
  ".github:.github"
  "annlite-design-system:annlite-design-system"
  "annlite-database:annlite-database"
  "annlite-backend:annlite-backend"
  "annlite-payments:annlite-payments"
  "annlite-celoht:annlite-celoht"
  "annlite-content:annlite-content"
  "annlite-web:annlite-web"
  "annlite-admin:annlite-admin"
  "annlite-docs:annlite-docs"
  "annlite-security:annlite-security"
  "annlite-infrastructure:annlite-infrastructure"
  "annlite-mobile:annlite-mobile"
  "annlite-invest-book:annlite-invest-book"
  "Ann-Lite:Ann Lite"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

added=0
skipped=0

for entry in "${REPOS[@]}"; do
  repo_name="${entry%%:*}"
  local_path="${entry##*:}"
  remote_url="${BASE_URL}/${repo_name}.git"

  if [ -d "$local_path/.git" ]; then
    echo "✓ ${local_path} already present — skipping"
    continue
  fi

  echo "Checking ${remote_url} ..."
  if git ls-remote "$remote_url" >/dev/null 2>&1; then
    git submodule add "$remote_url" "$local_path"
    added=$((added + 1))
  else
    echo "⚠️  ${repo_name} not reachable yet at ${remote_url} — skipping (re-run this script once it's pushed)"
    skipped=$((skipped + 1))
  fi
done

echo ""
echo "Done. Added: ${added}, skipped (not yet available): ${skipped}"
if [ "$skipped" -gt 0 ]; then
  echo "Re-run ./scripts/bootstrap.sh once the remaining repositories exist on GitHub."
fi
