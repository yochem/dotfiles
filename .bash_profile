#!/usr/bin/env bash

# first checking if iTerm. This fixes the issue of not recognising
# $SSH_CLIENT without resourcing .bash_profile
# test -e "$HOME/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"

dotfiles=(
    "~/.iterm2_shell_integration.bash"
    "~/.prompt"
    "~/.exports"
    "~/.aliases"
    "~/.functions"
    "~/.z.sh"
    "/usr/local/etc/profile.d/bash_completion.sh"
)


# Load the shell dotfiles, and z.sh
for file in ${dotfiles[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
unset dotfiles

# load bash completion for commands
[ -d /usr/local/etc/bash_completion.d ] && . /usr/local/etc/bash_completion.d/* 2>/dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# cd without typing cd
shopt -s autocd

