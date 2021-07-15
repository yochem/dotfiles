fish_vi_key_bindings
fish_vi_cursor --force-iterm
set -g fish_cursor_insert line
set -g fish_cursor_default block

function fish_greeting
end

set -g fish_color_command normal
set -g fish_color_comment 6f7683
set -g fish_color_quote green
set -g fish_color_redirection magenta
set -g fish_color_autosuggestion 6f7683

set files \
    "$HOME/.config/fish/z.fish" \
    "$HOME/.config/fish/xdg.fish" \
    "$HOME/.config/fish/prompt.fish" \
    "$HOME/.config/fish/exports.fish" \
    "$HOME/.config/fish/aliases.fish" \
    "$HOME/.config/fish/functions.fish"
for file in $files
    [ -f "$file" ] && source $file
end

[ -e /home/linuxbrew/ ] && eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if [ -z "$TMUX" ] && [ -z "$SSH_CLIENT" ]
    tmux ls 2>/dev/null | grep attached >/dev/null
    if [ "$status" = 1 ]
        tmux attach-session -t general || tmux new-session -s general
    end
end


set -Ux PYENV_ROOT $XDG_DATA_HOME/pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

status is-login; and pyenv init - | source
