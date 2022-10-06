alias xclip='xclip -selection clip-board'
alias shrug='echo -n "¯\_(ツ)_/¯" | xclip -selection clipboard; echo "¯\_(ツ)_/¯"'

# git
alias gs='git status'
alias gl='git log --all --decorate --oneline --graph'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
