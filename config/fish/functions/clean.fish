function clean
    set temp (mktemp)
    git clean -ndfx | tee $temp
    if test ! -s $temp
        echo "nothing to clean"
        return
    end
    read -l -P "Proceed with cleaning? [y/N] " confirm
    if test "$confirm" = "y"
        git clean -dfx
    else
        echo "aborted"
    end
end
