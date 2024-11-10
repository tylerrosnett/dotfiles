# this is used to measure zsh performance
# Run this to use 
# zshperformance
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory                                     # Enable history
setopt extendedhistory                                   # Timestamps in history
setopt incappendhistory                                  # Write history immediately
setopt histfindnodups                                    # Skip duplicates in history


# TODO fix this to be portable
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source .aliases

zstyle ':omz:plugins:nvm' lazy yes
plugins=(git git-open aws kubectl fluxcd argocd nvm zsh-autosuggestions zsh-syntax-highlighting history-substring-search)
source .plugins

bindkey "$terminfo[kcuu1]" history-search-backward
bindkey "$terminfo[kcud1]" history-search-forward

# TODO fix this nonsense
autoload -Uz compinit                                    # Enable completions
compinit
# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C



POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/.p10k.zsh
source powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f .p10k.zsh ]] && p10k configure
source .p10k.zsh

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi