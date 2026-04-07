function root
	set markers .git .editorconfig
	set dir (pwd)
	while [ $dir != '/' -a $dir != $HOME ]
		set files $dir/* $dir/.*
		for marker in $markers
			if contains -- $dir/$marker $files
				cd $dir
				return
			end
		end
		set dir (path dirname $dir)
	end
end
