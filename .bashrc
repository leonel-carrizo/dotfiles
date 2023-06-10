## Use ZSH default
# if [ -t 1 ]; then
#   exec zsh
# fi

eval "$(oh-my-posh init bash --config C:/Users/leone/AppData/Local/Programs/oh-my-posh/themes/blueish.omp.json)"
# eval "$(oh-my-posh init bash --config $env:POSH_THEMES_PATH/blueish.omp.json)"


# enable bash completion
source ~/bash_completion.d/bash_completion

# enable readline initialization file for interactive shells
if [ -f "C:\Program Files\Git\etc\.inputrc" ]; then
    bind -f "C:\Program Files\Git\etc\.inputrc"
fi


# alias
alias ls='ls -F --color=auto --show-control-chars'
alias ll='ls -l'
alias vi="nvim"
alias myip="curl http://ipecho.net/plain; echo"
