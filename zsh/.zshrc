# Zsh init, this is god-awful. I'm sorry.

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/alistair/.zshrc'
autoload -Uz compinit
compinit

# End of lines added by compinstall



# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=500
setopt appendhistory autocd extendedglob
setopt HIST_IGNORE_DUPS
bindkey -e

# End of lines configured by zsh-newuser-install

# zinit
source ~/.zim/init.zsh

# Powerlevel9K

POWERLEVEL9K_INSTALLATION_PATH=~/.zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status todo)

# Aliases

# thefuck

eval "$(thefuck --alias)"
eval "$(thefuck --alias shit)"

# Files

alias v='nvim'
alias mkexec="chmod +x"
alias lg="ls | grep"

# Configs
alias zshrc="nvim ~/.zshrc && source ~/.zshrc"
alias zimrc="nvim ~/.zimrc && source ~/.zimrc"
alias vinit="nvim ~/.config/nvim/init.vim"
alias i3conf="nvim ~/.config/i3/config"

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# auto-ls after changing directory {{{
cd () {
    builtin cd $@ && ls -CF
}
# }}}


## easier extraction {{{
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.bz2) bunzip2 $1;;
            *.rar) unrar x $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7za x $1;;
            *) echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# }}}
