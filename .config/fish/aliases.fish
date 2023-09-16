# fancy ls
set ls_type ls
command -v gls &>/dev/null && set ls_type gls
alias ls "$ls_type --group-directories-first -A1hF --time-style +%Y-%m-%d --color=auto"

# use some flags by default
alias grep "grep -iE --color=auto"
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -v"
alias less "less -R"
alias swipl "swipl -q"

# reload bash profile and stuff
abbr reload "exec fish"

alias vi \$VISUAL

# easier way to cd back one level
abbr .. "cd .."

# use aliases when sudoing
alias sudo "sudo "

[ -n (command -v nvim) ] && alias vim nvim

# fd is fdfind on ubuntu
command -v fdfind >/dev/null && alias fd fdfind

# get quick octal permissions of a file
abbr perms "stat --format '%a'"

# typo prevention
abbr gs "git status -s"
