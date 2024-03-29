# check if git rpo and which branch
prompt_git() {
	git rev-parse --is-inside-work-tree &>/dev/null
	if [[ "$?" == "0" ]]; then
		# Get the short symbolic ref.
		# If HEAD isnt a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo -e '(unknown)')"
		echo -e "($1$branchName$2) "
	else
		return
	fi
}

###############
# BASH PROMPT #
###############
if [ -n "$BASH_VERSION" ]; then
	# Some colors to use for prompt
	reset="\[\033[0;39m\]"
	green="\[\033[0;92m\]"
	magenta="\[\033[01;38;5;005m\]"
	blue="\[\033[0;94m\]"
	bold="\[\033[1m\]"

	# build PS1
	PS1="$reset"
	PS1+="[ "
	PS1+="$reset"
	[ "$USER" == "root" ] && PS1+="$bold${magenta}root$reset"
	# if connected using SSH, show hostname
	[ -n "$SSH_CLIENT" ] && PS1+="$magenta@\h$reset: "
	PS1+="$blue\w " # full path of cwd
	PS1+="$reset"
	PS1+="\$(prompt_git \"$green\" \"$reset\")" # show git branch
	PS1+="$reset"
	PS1+="] "
	export PS1

	# adding color to default PS2
	export PS2="$reset$blue>$reset "
elif [ -n "$ZSH_VERSION" ]; then
	setopt PROMPT_SUBST
	PROMPT=""
	PROMPT+="["
	PROMPT+="%{$fg[magenta]%}%(!. root.)"
	PROMPT+="%{$reset_color%}"
	[ -n "$SSH_CLIENT" ] && PROMPT+="@%m:"
	PROMPT+=" %{$fg[blue]%}%~ "
	PROMPT+="%{$reset_color%}"
	PROMPT+='$(prompt_git "$fg[green]" "${reset_color}")'
	PROMPT+="%{$reset_color%}"
	PROMPT+="] "
fi
