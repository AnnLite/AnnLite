#!/usr/bin/env bash
#
# Ann Lite — Update all submodules to the latest commit on their default
# branch. Plain `git submodule update` alone pins to whatever commit was
# recorded when each submodule was added — this script explicitly pulls
# each one forward, which is usually what you want for a meta-repo like
# this one (tracking "latest," not a frozen snapshot).
#
# Usage: ./scripts/update-all.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

git submodule sync --recursive
git submodule update --init --recursive --remote

echo ""
echo "All submodules updated to latest. Review changes with:"
echo "  git status"
echo "then commit the updated submodule pointers if you want to record this snapshot:"
echo "  git add . && git commit -m 'Update submodules to latest'"
