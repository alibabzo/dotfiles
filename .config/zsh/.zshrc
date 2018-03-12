HISTFILE=~/.config/zsh/.history
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory autocd extendedglob nomatch hist_ignore_all_dups
unsetopt beep notify

autoload -Uz compinit
compinit

zstyle ':completion:*' rehash true

source <(antibody init)
antibody bundle < ~/.config/antibody/plugins.txt

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias ls='ls --color=auto'
alias ll='ls -al'

alias e='emacsclient -t'
alias ec='emacsclient -nc'

alias pacu='trizen -Syu'
alias paci='trizen -S'
alias pacq='trizen -Ss'
alias pacr='trizen -Rns'

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias mkexec='chmod +x'

function chpwd() {
	ls
}
