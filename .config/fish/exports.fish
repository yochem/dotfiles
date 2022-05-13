# choose the default editor
if command -v nvim >/dev/null 2>&1
    set -xU VISUAL nvim
    set -xU MANPAGER 'nvim +Man!'
else if command -v vim >/dev/null 2>&1
    set -xU VISUAL vim
else
    set -xU VISUAL nano
end

set -xU EDITOR "$VISUAL"

# fix the bug of Apple creating a non-exisiting LC
set -xU LC_ALL "en_US.UTF-8"

set -xU FZF_DEFAULT_COMMAND 'fd --type f'
