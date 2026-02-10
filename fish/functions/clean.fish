function clean
    set dir $argv
    set temp (mktemp)
    git clean -ndfx $dir | tee $temp
    if test ! -s $temp
        echo "nothing to clean"
        return
    end
    read -l -P "Proceed with cleaning? [y/N] " confirm
    if test "$confirm" = "y"
        git clean -dfx $dir
    else
        echo "aborted"
    end
end
