#!/bin/bash

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
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
	PS1="\e[1;34m$(condense-path $PWD)\e[0m\n\$ "
}
export PROMPT_COMMAND='history -a; history -c; history -r; bash_prompt'

# From bash-completion@2 brew package
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && source "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Config git completions
[[ -r "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash" ]] && source "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash"


# Add docker
export PATH="${PATH}:${HOME}/.docker/bin"
mkdir -p "${HOME}/.local/share/bash-completion/completions"
docker completion bash > "${HOME}/.local/share/bash-completion/completions/docker"

# Add aws
export PATH="${PATH}:${HOME}/aws-cli"
if [ -f '/Users/avrittrohwer/aws-cli/aws_completer' ]; then complete -C '/Users/avrittrohwer/aws-cli/aws_completer' aws; fi

# Add gcloud
if [ -f '/Users/avrittrohwer/google-cloud-sdk/path.bash.inc' ]; then . '/Users/avrittrohwer/google-cloud-sdk/path.bash.inc'; fi
if [ -f '/Users/avrittrohwer/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/avrittrohwer/google-cloud-sdk/completion.bash.inc'; fi

# Add uv
source "$HOME/.local/bin/env"

# Add pip binaries
export PATH="${PATH}:$(python3 -m site --user-base)/bin"

# Add rust
export PATH="${PATH}:${HOME}/.cargo/bin"

# Add shellcheck
export PATH="${PATH}:${HOME}/Installs/shellcheck-stable"

# Add coursier
export PATH="${PATH}:${HOME}/Library/Application Support/Coursier/bin"

# Add aws-nuke
export PATH="${PATH}:${HOME}/Installs/aws-nuke"

# Add nvim
export PATH="${PATH}:${HOME}/Installs/nvim-macos-arm64/bin"
export EDITOR='nvim'

# Add scripts
export PATH="${PATH}:${HOME}/Installs/scripts"

# Add skaffold
export PATH="${PATH}:${HOME}/Installs/skaffold"

# Add fzf
if [ -f ~/.fzf.bash ]; then
	source ~/.fzf.bash
fi
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND='rg --files --hidden'

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# Add homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# CiviForm setup
export USE_LOCAL_CIVIFORM=1
