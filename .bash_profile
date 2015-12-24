#!/bin/bash
for file in ~/{.bash_prompt,.exports,.aliases,.functions,.extra}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && source "$file"
done
unset file
# extra libs
source ~/local/z/z.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Set custom colours in folders and add defaults to common commands
if [ -x /usr/bin/dircolors ]; then
  [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi


# Add tab completion for SSH hostnames based on ~/.ssh/config
[ -e "$HOME/.ssh/config" ] || touch $HOME/.ssh/config
complete -o "default" \
  -o "nospace" \
  -W "$(grep "^Host" ~/.ssh/config | \
  grep -v "[?*]" | cut -d " " -f2 | \
  tr ' ' '\n')" scp sftp ssh
