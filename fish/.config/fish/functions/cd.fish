function cd
    builtin cd $argv; and ls --group-directories-first --color=auto
end
