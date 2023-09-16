# fancy ls
ls_type="ls"
command -V gls &>/dev/null && ls_type="gls"
alias ls="$ls_type --group-directories-first -1F --color=auto"
alias ll="$ls_type --group-directories-first -oAF --color=auto"
unset ls_type

# use some flags by default
alias grep="grep -iE --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -v"
alias less="less -R"
alias swipl="swipl -q"

alias python="python3"
alias py="python3"
alias p2="python"

# reload bash profile and stuff
alias reload="exec bash"

# use $VISUAL as editor (it's mostly vim, so i've always used 'v'
alias vi=\$VISUAL

# easier way to cd back one level
alias ..="cd .."

# use hub for github
[ -n "$(command -v hub)" ] && alias git=hub

[ "$(uname -s)" = "Darwin" ] && alias lock="pmset displaysleepnow"

# start writing a mail in /tmp
alias newmail='$VISUAL /tmp/vim-mail-$(date +%s).mail'

# use aliases when sudoing
alias sudo="sudo "

# new iterm tab
alias tab="open -a iterm ."

# shorten this long command
alias jup="jupyter lab"

[ -n "$(command -v nvim)" ] && alias vim="nvim"

# fd is fdfind on ubuntu
[ -n "$(command -v fdfind)" ] && alias fd="fdfind"

# get quick octal permissions of a file
alias perms="stat -f '%A'"

# typo prevention
alias gs="g s"
