#!/usr/bin/env zsh
#
# install.zsh
# Symlinks dotfiles from this repo into $HOME.
#
# Layout this script expects (relative to itself):
#   current/   files mirroring ~ (e.g. current/.zshrc -> ~/.zshrc)
#   shared/    cross-distro configs (e.g. shared/.vimrc -> ~/.vimrc)
#
# Anything outside current/ and shared/ is ignored.
# Existing files at the destination get backed up to <file>.bak.

# ── Configuration ─────────────────────────────────────────────────────────────
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME"
SOURCE_DIRS=("current" "shared")

# ── Helpers ───────────────────────────────────────────────────────────────────
info()    { print -P "%F{cyan}info%f: $1" }
warn()    { print -P "%F{yellow}warn%f: $1" }
success() { print -P "%F{green}success%f: $1" }
error()   { print -P "%F{red}error%f: $1"; exit 1 }

link_file() {
  # Symlink a single file from the repo into $HOME.
  # $1 = absolute source path (inside the repo)
  # $2 = path relative to whichever source dir it came from
  #      (this becomes the path relative to $HOME)
  local src_full_path="$1"
  local rel_path="$2"
  local dst_path="$TARGET_DIR/$rel_path"

  # Ensure destination parent directory exists
  mkdir -p "$(dirname "$dst_path")"

  # Handle existing file at destination
  if [[ -e "$dst_path" || -L "$dst_path" ]]; then
    if [[ -L "$dst_path" && "$(readlink "$dst_path")" == "$src_full_path" ]]; then
      info "already linked: $rel_path"
      return 0
    fi
    warn "existing file at $dst_path — backing up to ${dst_path}.bak"
    mv "$dst_path" "${dst_path}.bak" || error "failed to back up $dst_path"
  fi

  # Create the symlink
  if ln -s "$src_full_path" "$dst_path"; then
    success "linked: $rel_path -> $src_full_path"
  else
    warn "failed to link: $rel_path"
  fi
}

process_source_dir() {
  # Walk one source dir and link every regular file inside it.
  # $1 = source dir name (e.g. "current" or "shared"), relative to REPO_ROOT
  local source_dir="$1"
  local source_root="$REPO_ROOT/$source_dir"

  if [[ ! -d "$source_root" ]]; then
    info "skipping $source_dir (not present)"
    return 0
  fi

  info "processing $source_dir/"

  # (N) = no-error if no match
  # (D) = include hidden files
  # (.) = regular files only
  local file_list=("$source_root"/**/*(ND.))
  if (( ${#file_list} == 0 )); then
    warn "no files found in $source_dir/"
    return 0
  fi

  local src_full_path rel_path
  for src_full_path in $file_list; do
    # Strip "$source_root/" prefix to get the path relative to $HOME
    rel_path="${src_full_path#$source_root/}"
    link_file "$src_full_path" "$rel_path"
  done
}

# ── Main ──────────────────────────────────────────────────────────────────────
info "starting dotfile linking from $REPO_ROOT"

for dir in "${SOURCE_DIRS[@]}"; do
  process_source_dir "$dir"
done

success "dotfile installation complete!"
