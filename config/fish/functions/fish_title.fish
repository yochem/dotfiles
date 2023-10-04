function fish_title
	[ -z $TMUX ] && return
	if [ fish != $_ ]
		tmux rename-window "$_"
	else
		set basename (string lower (basename (pwd)))
		if [ $basename = "yochem" ]
			tmux rename-window "home/"
		else if [ $basename = "/" ]
			tmux rename-window "/"
		else
			tmux rename-window "$basename/"
		end
	end
	# tmux set-option automatic-rename on
end
