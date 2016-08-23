#
# User configuration sourced by interactive shells
#

# thefuck
eval "$(thefuck --alias)"
eval "$(thefuck --alias shit)"

# Files
alias v='nvim'
alias mkexec="chmod +x"
alias lg="ls | grep"

# Configs
alias zshrc="nvim ${ZDOTDIR:-${HOME}}/.zshrc && source ${ZDOTDIR:-${HOME}}/.zshrc"
alias zimrc="nvim ${ZDOTDIR:-${HOME}}/.zimrc && source ${ZDOTDIR:-${HOME}}/.zimrc"
alias vinit="nvim $HOME/.config/nvim/init.vim"

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# auto-ls after changing directory
cd () {
    builtin cd $@ && ls --group-directories-first --color=auto
}

# easier extraction
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

