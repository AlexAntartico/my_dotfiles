#!/usr/bin/env bash
#
# migrate.sh
# Reorganizes my_dotfiles into a clearer structure.
# Run from the root of the my_dotfiles repo.
#
# Before:                    After:
#   my_dotfiles/               my_dotfiles/
#   ├── CachyOs/               ├── current/
#   ├── .vimrc                 ├── shared/
#   ├── aliases.sh             ├── scripts/
#   ├── kitty.conf             └── legacy/
#   ├── color.ini                  ├── fedora/
#   ├── update_debian.sh           └── mint/
#   ├── ssformater.sh
#   └── dotfiles_to_repo.sh
#
# Usage: ./migrate.sh
# Safe to re-run: each mv is guarded by a test.

set -e

# Guard: make sure we're in the right place
if [[ ! -d "CachyOs" || ! -f ".vimrc" ]]; then
  echo "error: run this from the root of the my_dotfiles repo" >&2
  echo "       (expected to find CachyOs/ and .vimrc here)" >&2
  exit 1
fi

echo "==> Creating new directory structure"
mkdir -p shared scripts legacy/fedora legacy/mint

echo "==> Renaming CachyOs -> current"
[[ -d "CachyOs" && ! -d "current" ]] && git mv CachyOs current 2>/dev/null || mv CachyOs current

echo "==> Moving .vimrc into shared/ (cross-distro config)"
[[ -f ".vimrc" ]] && mv .vimrc shared/.vimrc

echo "==> Moving Fedora-era configs into legacy/fedora/"
[[ -f "aliases.sh" ]] && mv aliases.sh legacy/fedora/aliases.sh

echo "==> Moving Mint-era kitty configs into legacy/mint/"
[[ -f "kitty.conf" ]] && mv kitty.conf legacy/mint/kitty.conf
[[ -f "color.ini" ]] && mv color.ini legacy/mint/color.ini

echo "==> Moving utility scripts into scripts/"
[[ -f "update_debian.sh" ]]    && mv update_debian.sh    scripts/update_debian.sh
[[ -f "ssformater.sh" ]]       && mv ssformater.sh       scripts/ssformater.sh
[[ -f "dotfiles_to_repo.sh" ]] && mv dotfiles_to_repo.sh scripts/dotfiles_to_repo.sh

echo
echo "Done. New layout:"
echo
find . -maxdepth 2 -not -path '*/\.git*' -not -path '.' | sort

cat <<'EOF'

Next steps:
  1. Review the changes:    git status
  2. Update install.zsh if it references old paths (it shouldn't — it uses $REPO_ROOT)
  3. The new top-level README.md describes this layout. Replace the old one.
  4. Commit:                git add -A && git commit -m "Reorganize repo: current/shared/scripts/legacy"
EOF
