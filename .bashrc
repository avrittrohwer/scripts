#!/bin/bash

# If not running interactively, don't do anything.
case $- in
  *i*) ;;
  *) return ;;
esac

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Append history (useful for not losing history while running parallel bash instances).
shopt -s histappend

# Make commands spanning multiple lines appear on one line in history file.
shopt -s cmdhist

export SHELL=/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1

# Config hist
export HISTSIZE=1000000000
export HISTFILESIZE=50000000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:history:exit'

# Config prompt
function bash_prompt {
  if [[ "$NIX_STORE" != "" ]]; then
    PS1="\e[1;34mnix-shell\e[0m\n\$ "
  else
    PS1="\e[1;34m$(condense-path $PWD)\e[0m\n\$ "
  fi
}
export PROMPT_COMMAND='history -a; history -c; history -r; bash_prompt'

# Add stuff for mac
if [[ "$(uname -s)" == "Darwin" ]]; then
  # Add homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # From bash-completion@2 brew package
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && source "/opt/homebrew/etc/profile.d/bash_completion.sh"

  # Config git completions
  [[ -r "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash" ]] && source "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash"

  # Add podman
  export PATH="${PATH}:${HOME}/Installs/podman-5.6.0/usr/bin/"

  # Add nvim
  export PATH="${PATH}:${HOME}/Installs/nvim-macos-arm64/bin"

  # Add docker desktop
  export PATH="${PATH}:${HOME}/.docker/bin"
fi

source "${HOME}/github/agent/source.sh"

# Add aws
export PATH="${PATH}:${HOME}/Installs/aws"
if [ -f "${HOME}/Installs/aws/aws_completer" ]; then complete -C "${HOME}/Installs/aws/aws_completer" aws; fi

# Add gcloud
if [ -f '${HOME}/google-cloud-sdk/path.bash.inc' ]; then . '${HOME}/google-cloud-sdk/path.bash.inc'; fi
if [ -f '${HOME}/google-cloud-sdk/completion.bash.inc' ]; then . '${HOME}/google-cloud-sdk/completion.bash.inc'; fi

# Add binaries in ~/.local/bin
source "$HOME/.local/bin/env"

# Add Go
export PATH="${PATH}:/usr/local/go/bin:/${HOME}/go/bin"

# Add nvim
export EDITOR='nvim'

# Add scripts
export PATH="${PATH}:${HOME}/Installs/scripts"

# Add fzf
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
fi
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND='rg --files --hidden'
# To show files ignored by .gitignore:
# export FZF_DEFAULT_COMMAND='rg --files --hidden && rg --files --hidden --no-ignore --glob=**/*avritt*/*/*'

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# CiviForm setup
export USE_LOCAL_CIVIFORM=1
export USE_PODMAN_FOR_CIVIFORM=1
export CONTAINERS_REGISTRIES_CONF=/home/avritt/registries.conf
