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
- symlinks `.zshrc`, `ghostty/`, and `k9s/` into `~/.config` (backs up non-symlink originals to `*.bak`)
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
| `k9s/` | K9s config (`config.yaml`, `hotkeys.yaml`, `plugins.yaml`, custom skin) |
| `.zshrc` / `.aliases` / `.plugins` / `.p10k.zsh` | zsh config |

## Includes

- **oh-my-zsh plugins** + **powerlevel10k** + **zsh-autosuggestions** + **zsh-syntax-highlighting** (submodules)
- **Custom aliases** — git, kubectl, and utility shortcuts

## Performance

Startup is profiled with zprof — run `zshperformance` (aliased in `.aliases`):

```text
🦋 time zsh -i -c exit
zsh -i -c exit  0.04s user 0.03s system 85% cpu 0.074 total
```

~74ms cold start as of 2026-06, with p10k instant prompt hiding most of it.

Things that keep it fast: p10k instant prompt, cached compinit, omz used as a plugin library only (no framework load), nvm lazy-loaded on first use.

## License

MIT
