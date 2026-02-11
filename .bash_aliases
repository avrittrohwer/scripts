#!/bin/bash

alias bloomtofu="podman container run --rm -it --userns=keep-id -v /home/avritt/github/bloom/infra:/infra:z -v ${HOME}/.aws/cli:/home/.aws/cli:z -v ${HOME}/.aws/sso/cache:/home/.aws/sso/cache:z bloom-infra:dev"
alias bloomtofu2="podman container run --rm -it --userns=keep-id -v /home/avritt/github/bloom-2/infra:/infra:z -v /home/avritt/github/bloom/infra:/github/bloom/infra:z -v ${HOME}/.aws/cli:/home/.aws/cli:z -v ${HOME}/.aws/sso/cache:/home/.aws/sso/cache:z bloom-infra:dev"

# python
alias python='python3'
alias pip='pip3'

# docker
alias pcu='podman compose up'
alias pcd='podman compose down'

# git
alias gs='git status && git --no-pager log --decorate --oneline --graph -4'
alias gl='git log --decorate --oneline --graph'
alias gla='git log --all --decorate --oneline --graph'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'
alias gr='git remote -v'

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Korg
alias korg="wine ~/.wine/drive_c/'Program Files'/KORG/'KORG KONTROL EDITOR'/'KORG KONTROL EDITOR.exe' 2>/dev/null"
