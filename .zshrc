# this is used to measure zsh performance
# To use, run this command: zshperformance
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Allow comments in interactive shells.
setopt interactive_comments

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# brew zsh completions (kubectl, helm, gh, ...) — must be set before compinit
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

# kubectl krew plugins
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# uv-installed tools
export PATH="$HOME/.local/bin:$PATH"

# VCF CLI Essentials plugin version
export VCF_CLI_ESSENTIALS_PLUGIN_GROUP_VERSION=v9.1.0

source ~/.dotfiles/.aliases
[[ ! -f ~/.secrets ]] || source ~/.secrets

# compinit BEFORE plugins (they call compdef); full rebuild only if dump >24h old
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zstyle ':omz:plugins:nvm' lazy yes
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
plugins=(git git-open kubectl nvm zsh-autosuggestions zsh-syntax-highlighting history-substring-search)
source ~/.dotfiles/.plugins

# Arrow keys: substring history search (both escape-sequence variants)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# fzf keybindings (Ctrl-R history, Ctrl-T files)
command -v fzf >/dev/null && source <(fzf --zsh)

# Tab accepts the autosuggestion if one is showing, else normal completion.
# Must come AFTER fzf, which rebinds ^I to fzf-completion; this takes ^I back
# unconditionally and delegates the no-suggestion case to fzf-completion so
# **<tab> completion still works (with plain completion as its fallback).
fzf_default_completion=expand-or-complete
_tab_accept_or_complete() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
  elif zle -l fzf-completion; then
    zle fzf-completion
  else
    zle expand-or-complete
  fi
}
zle -N _tab_accept_or_complete
bindkey '^I' _tab_accept_or_complete

POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/.p10k.zsh
source ~/.dotfiles/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.dotfiles/.p10k.zsh ]] && p10k configure
source ~/.dotfiles/.p10k.zsh

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
