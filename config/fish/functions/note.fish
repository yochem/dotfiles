function note
	set notes_dir "$HOME/drive/notes"
	if [ -n "$argv[1]" ]
		$VISUAL "$notes_dir/$argv[1].md"
	else
		$VISUAL "$notes_dir/"(ls -c "$notes_dir" | fzf)
	end
end
