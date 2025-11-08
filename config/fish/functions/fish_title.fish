function fish_title
	[ -z $TMUX ] && return
	if [ fish != $_ ]
		echo "$_"
	else
		echo (string replace -r '/*$' '/' (basename (prompt_pwd --dir-length 0)))
	end
end
