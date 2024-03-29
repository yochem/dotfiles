# choose the default editor
if command -v nvim >/dev/null 2>&1; then
	export VISUAL="nvim"

	# view manpage in neovim
	export MANPAGER='nvim +Man!'
elif command -v vim >/dev/null 2>&1; then
	export VISUAL="vim"
else
	export VISUAL="nano"
fi

export EDITOR="$VISUAL"

# add local bin to path
export PATH="$PATH:$HOME/.local/bin"

# increase bash history size
export HISTSIZE="32768"

# add time stamp to bash history
export HISTTIMEFORMAT="%c "

# gpg safety
export GPG_TTY="$(tty)"

# don't put duplicates in history
export HISTCONTROL="ignoreboth"
export HISTIGNORE='rm *'

# don't let Terminal.app write session history
# (https://stackoverflow.com/questions/32418438/how-can-i-disable-bash-sessions-in-os-x-el-capitan)
export SHELL_SESSION_HISTORY=0

# fix the bug of Apple creating a non-exisiting LC
export LC_ALL="en_US.UTF-8"

export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.8/site-packages/"
