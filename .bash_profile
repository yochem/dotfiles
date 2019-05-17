#!/usr/bin/env bash

dotfiles=(
    ~/.config/bash/xdg
    ~/.config/bash/prompt
    ~/.config/bash/exports
    ~/.config/bash/aliases
    ~/.config/bash/functions
    /usr/local/etc/profile.d/bash_completion.sh
    ~/bin/z.sh
    ~/.config/iterm2/iterm2_shell_integration.bash
)

# Load the shell dotfiles, and z.sh
for file in ${dotfiles[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
unset dotfiles

# load bash completion for commands
[ -d /usr/local/etc/bash_completion.d ] && . /usr/local/etc/bash_completion.d/*

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# cd without typing cd
shopt -s autocd

