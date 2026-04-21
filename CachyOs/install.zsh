#!/usr/bin/env zsh

# ── Configuration ─────────────────────────────────────────────────────────────
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME"
SKIP_FILES=("install.zsh" "README.md" "LICENSE")
SKIP_DIRS=(".git")

# ── Helpers ───────────────────────────────────────────────────────────────────
info()  { print -P "%F{cyan}info%f: $1" }
warn()  { print -P "%F{yellow}warn%f: $1" }
success() { print -P "%F{green}success%f: $1" }
error() { print -P "%F{red}error%f: $1"; exit 1 }

is_skipped() {
  local item="$1"
  for skip in "${SKIP_FILES[@]}" "${SKIP_DIRS[@]}"; do
    [[ "$item" == "$skip" ]] && return 0
  done
  return 1
}

# ── Main ──────────────────────────────────────────────────────────────────────
info "Starting dotfile linking from $REPO_ROOT"

# Use glob qualifiers to find all files recursively, excluding the script itself
# (D) include hidden files
# (**) recursive
# (.) regular files
cd "$REPO_ROOT" || error "Could not enter repo root"

for src_path in **/*(D.); do
  # Skip specific files/dirs
  should_skip=false
  for skip in "${SKIP_FILES[@]}"; do
    [[ "$src_path" == *"$skip"* ]] && should_skip=true && break
  done
  [[ "$should_skip" == true ]] && continue
  
  # Also skip if it's inside a skipped dir
  for skip in "${SKIP_DIRS[@]}"; do
    [[ "$src_path" == "$skip"/* ]] && should_skip=true && break
  done
  [[ "$should_skip" == true ]] && continue

  local rel_path="$src_path"
  local dst_path="$TARGET_DIR/$rel_path"
  local src_full_path="$REPO_ROOT/$rel_path"

  # Ensure destination parent directory exists
  mkdir -p "$(dirname "$dst_path")"

  # Handle existing files
  if [[ -e "$dst_path" || -L "$dst_path" ]]; then
    if [[ -L "$dst_path" && "$(readlink "$dst_path")" == "$src_full_path" ]]; then
      info "Already linked: $rel_path"
      continue
    fi

    warn "Existing file found at $dst_path. Backing up to ${rel_path}.bak"
    mv "$dst_path" "${dst_path}.bak" || error "Failed to backup $dst_path"
  fi

  # Create symlink
  ln -s "$src_full_path" "$dst_path" && \
    success "Linked: $rel_path -> $dst_path" || \
    warn "Failed to link: $rel_path"
done

success "Dotfile installation complete!"
