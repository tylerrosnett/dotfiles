# dotfiles

Personal shell + tooling setup for macOS (Apple Silicon).

## Setup

```bash
git clone --recurse-submodules https://github.com/tylerrosnett/dotfiles ~/.dotfiles
~/.dotfiles/setup.sh
```

`setup.sh` is idempotent — safe to re-run anytime. It:

- installs Homebrew if missing, then `brew bundle` (Brewfile — CLI tools, apps, fonts)
- syncs git submodules (powerlevel10k, omz plugins, etc.)
- symlinks `.zshrc` and the `ghostty/` dir (config + themes) (backs up non-symlink originals to `*.bak`)
- installs a default Python via uv
- installs kubectl krew plugins (neat, view-secret, tree)
- applies macOS defaults (`macos-defaults.sh`)

## Layout

| File | Purpose |
|---|---|
| `Brewfile` | all packages — `brew bundle --file=~/.dotfiles/Brewfile` |
| `setup.sh` | bootstrap script (above) |
| `macos-defaults.sh` | macOS `defaults write` settings |
| `ghostty/config` | terminal: MesloLGS NF, catppuccin-mocha |
| `.zshrc` / `.aliases` / `.plugins` / `.p10k.zsh` | zsh config |

## Includes

- **oh-my-zsh plugins** + **powerlevel10k** + **zsh-autosuggestions** + **zsh-syntax-highlighting** (submodules)
- **Custom aliases** — git, kubectl, and utility shortcuts

## License

MIT
