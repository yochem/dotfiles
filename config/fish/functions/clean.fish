function clean
    git clean -ndfx
    read -l -P "Proceed with cleaning? [y/N] " confirm
    if test "$confirm" = "y"
        git clean -dfx
    else
        echo "Aborted."
    end
end
