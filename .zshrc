# this is used to measure zsh performance
# uncomment to enable, also uncomment the zprof at the end of the file
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# TODO fix this to be portable
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


zstyle ':omz:plugins:nvm' lazy yes
plugins=(git nvm zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-autosuggestions)
source .plugins

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down





# git submodule add --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git












compinit


autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C



POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/.p10k.zsh
source powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f .p10k.zsh ]] && p10k configure
source .p10k.zsh








# History search
# autoload -U history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^[[A" history-beginning-search-backward-end
# bindkey "^[[B" history-beginning-search-forward-end



# source aliases file
# source .aliases


# zprof