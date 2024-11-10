# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi




# git submodule add --depth=1 https://github.com/lukechilds/zsh-nvm.git zsh-nvm





# enable plugins
export NVM_LAZY_LOAD=true
source zsh-nvm/zsh-nvm.plugin.zsh
source syntax-highlighting/zsh-syntax-highlighting.zsh
source history-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source completions/zsh-completions.plugin.zsh
fpath=(./completions/src $fpath)







# TODO fix this to be portable
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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