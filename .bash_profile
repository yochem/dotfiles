dotfiles=(
    ~/.config/shell/xdg
    ~/.config/shell/prompt
    ~/.config/shell/exports
    ~/.config/shell/aliases
    ~/.config/shell/functions
    /usr/local/etc/profile.d/bash_completion.sh
    /usr/local/etc/profile.d/z.sh
    ~/.config/iterm2/iterm2_shell_integration.bash
)

# Load the shell dotfiles, and z.sh
for file in ${dotfiles[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
unset dotfiles

# load bash completion for commands
if [[ -d /usr/local/etc/bash_completion.d ]]; then
    for file in /usr/local/etc/bash_completion.d/*; do
        source $file
    done
    unset file

    __git_complete g __git_main
fi

if [[ $(command -v shopt) ]]; then
    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob

    # Append to the Bash history file, rather than overwriting it
    shopt -s histappend

    # Autocorrect typos in path names when using `cd`
    shopt -s cdspell

    # cd without typing cd
    shopt -s autocd

    # enable recursive globbing
    shopt -s globstar
fi

# linuxbrew
[ -e "/home/linuxbrew/" ] && {
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
}
