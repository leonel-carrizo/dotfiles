###################################################################################
pfetch
# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias lll='lsd */**/*'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias myip="curl http://ipecho.net/plain; echo"
alias nv='nvim'
alias norm="norminette"
alias comp="cc -Wall -Werror -Wextra"
alias cl="clear"
alias gitb="lazy_git"
alias gits="git status"
alias rgr="ranger"
alias gdbc="gcc -Wall -Werror -Wextra -g"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_gb=$'\e[01;32m' \
    man "$@"
}

# Erased deep files
  function rmk(){
    scrub -p dod $1
    shred -zun -v $1
  }

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

export TERMINAL=xterm-kitty
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export PAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"
export LESS='-R --use-color -Dd+r$Du+b$'


# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

# Manual configuration
PATH=/root/.local/bin:$PATH
PATH=/snap/bin:/usr/sandbox/:$PATH
PATH=/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:$PATH
PATH=/usr/local/games:/usr/games:$PATH
PATH=/home/l3o/.local/bin/:/home/l3o/.cargo/bin/:/home/l3o/.luarocks:$PATH
PATH=~/.console-ninja/.bin:$PATH
PATH="/home/l3o/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/l3o/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/l3o/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/l3o/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/l3o/perl5"; export PERL_MM_OPT;

# for fnm (fast node manager)
eval "$(fnm env --use-on-cd --shell zsh)"
