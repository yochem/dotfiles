fish_vi_key_bindings
fish_vi_cursor --force-iterm
set -g fish_vi_force_cursor 1
set -g fish_cursor_insert line
set -g fish_cursor_default block

function fish_greeting
end

set -g fish_color_command blue
set -g fish_color_comment 6f7683
set -g fish_color_quote green
set -g fish_color_redirection magenta
set -g fish_color_autosuggestion 6f7683

set files \
    "$HOME/.config/fish/xdg.fish" \
    "$HOME/.config/fish/prompt.fish" \
    "$HOME/.config/fish/exports.fish" \
    "$HOME/.config/fish/aliases.fish" \
    "$HOME/.config/fish/functions.fish"
for file in $files
    [ -f "$file" ] && source $file
end

bind --mode insert dn "commandline -i ' >/dev/null '"
bind --mode insert 2dn "commandline -i ' 2>/dev/null '"

if [ -z "$TMUX" ] && [ -z "$SSH_CLIENT" ]
    tmux ls 2>/dev/null | grep attached >/dev/null
    if [ "$status" = 1 ]
        tmux attach-session -t general || tmux new-session -s general
    end
end
