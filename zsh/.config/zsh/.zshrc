

#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# vim keybindings
bindkey -v
export KEYTIMEOUT=1

# powerlevel9k
POWERLEVEL9K_INSTALLATION_PATH=~/.config/zsh/.zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode)
DEFAULT_USER=alistair
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

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
            *.tar.xz) tar xvf $1;;
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
