function fish_title
	# [ -z $TMUX ] && return
	if [ fish != $_ ]
		echo "$_"
	else
		echo (nice_path (string replace -r '/*$' '/' (prompt_pwd -D 20)))
	end
end
