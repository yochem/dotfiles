# fancy ls
set ls_type ls
command -v gls &>/dev/null && set ls_type gls
alias ls "$ls_type --group-directories-first -1F --color=auto"
alias ll "$ls_type --group-directories-first -oAF --color=auto"

# use some flags by default
alias grep "grep -iE --color=auto"
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -v"
alias less "less -R"
alias swipl "swipl -q"

# reload bash profile and stuff
alias reload "source \$HOME/.config/fish/config.fish"

alias vi \$VISUAL

# easier way to cd back one level
alias .. "cd .."

# start writing a mail in /tmp
alias newmail '$VISUAL /tmp/vim-mail-(date +%s).mail'

# use aliases when sudoing
alias sudo "sudo "

[ -n (command -v nvim) ] && alias vim nvim

# fd is fdfind on ubuntu
command -v fdfind >/dev/null && alias fd fdfind

# get quick octal permissions of a file
alias perms "stat -f '%A'"

# typo prevention
alias gs "g s"
