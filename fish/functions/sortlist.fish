function sortlist
	echo $argv[1] |tr $argv[2] '\n' | sort -b |  paste -s -d $argv[2] -
end
