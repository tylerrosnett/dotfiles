#!/usr/bin/env bash
# Idempotent dotfiles bootstrap — macOS (Apple Silicon).
# Usage: ~/.dotfiles/setup.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# --- Homebrew ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

log "brew bundle"
brew bundle --file="$DOTFILES/Brewfile"

# --- Submodules (p10k, omz plugins, etc.) ---
log "Syncing git submodules"
git -C "$DOTFILES" submodule update --init --recursive

# --- Symlinks ---
link() { # link <repo-relative-src> <dest>
  local src="$DOTFILES/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e $dest && ! -L $dest ]]; then
    log "Backing up existing $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sfn "$src" "$dest"
  log "Linked $dest -> $src"
}

link .zshrc "$HOME/.zshrc"
link .gitconfig "$HOME/.gitconfig"
link ghostty "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"

# --- SSH signing key (used by .gitconfig: commit.gpgsign with ssh format) ---
if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
  log "Generating SSH key"
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "32503435+tylerrosnett@users.noreply.github.com" -f "$HOME/.ssh/id_ed25519" -N ""
  log "ACTION NEEDED: add this key to GitHub as BOTH auth and signing key (gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication / --type signing)"
fi
# Keep allowed_signers in sync so local signature verification works
if ! grep -qs "$(awk '{print $2}' "$HOME/.ssh/id_ed25519.pub")" "$HOME/.ssh/allowed_signers" 2>/dev/null; then
  echo "32503435+tylerrosnett@users.noreply.github.com $(cat "$HOME/.ssh/id_ed25519.pub")" >> "$HOME/.ssh/allowed_signers"
  log "Added key to ~/.ssh/allowed_signers"
fi

# --- Switch this repo's origin to SSH (initial clone is usually HTTPS) ---
origin_url="$(git -C "$DOTFILES" remote get-url origin 2>/dev/null || true)"
if [[ $origin_url == https://github.com/* ]]; then
  git -C "$DOTFILES" remote set-url origin "${origin_url/https:\/\/github.com\//git@github.com:}"
  log "origin switched to SSH: $(git -C "$DOTFILES" remote get-url origin)"
fi

# --- VS Code ---
VSCODE_USER="$HOME/Library/Application Support/Code/User"
link vscode/settings.json "$VSCODE_USER/settings.json"
link vscode/keybindings.json "$VSCODE_USER/keybindings.json"
if command -v code >/dev/null 2>&1; then
  log "Installing VS Code extensions"
  installed="$(code --list-extensions)"
  while IFS= read -r ext; do
    [[ -z $ext ]] && continue
    grep -qix "$ext" <<<"$installed" || code --install-extension "$ext"
  done < "$DOTFILES/vscode/extensions.txt"
fi

# --- Python via uv ---
if command -v uv >/dev/null 2>&1; then
  log "Installing default Python (uv)"
  uv python install   # latest stable; no-op if already installed
fi

# --- kubectl krew plugins ---
if command -v kubectl >/dev/null 2>&1 && command -v kubectl-krew >/dev/null 2>&1; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  for plugin in neat view-secret tree; do
    kubectl krew list 2>/dev/null | grep -qx "$plugin" || kubectl krew install "$plugin"
  done
fi

# --- macOS defaults ---
log "Applying macOS defaults"
"$DOTFILES/macos-defaults.sh"

# Silence "Last login" banner in new terminals
touch "$HOME/.hushlogin"

log "Done. Restart your terminal."
