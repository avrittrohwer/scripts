# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# The pattern "**" used in a pathname expansion context will match all files
# and zero or more directories and subdirectories.
shopt -s globstar

# Append history (useful for not losing history while running parallel bash instances).
shopt -s histappend

# Make commands spanning multiple lines appear on one line in history file.
shopt -s cmdhist


# Source variables.
if [ -f ~/.bash_vars ]; then
	source ~/.bash_vars
fi

# Source aliases.
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# Add scripts directory to path.
export PATH=$PATH:~/Scripts

# Add manual installs to path.
export PATH=$PATH:~/Installs/bin

# Configure fzf.
if [ -f ~/.fzf.bash ]; then
	source ~/.fzf.bash
fi

# Enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile sources
# /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
