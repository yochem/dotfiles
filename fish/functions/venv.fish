function venv --on-variable PWD
    set -l dir (pwd)
    while test $dir != /
        if test -f $dir/.venv/bin/activate.fish
            if test "$VIRTUAL_ENV" != "$dir/.venv"
                source $dir/.venv/bin/activate.fish
            end
            return
        end
        set dir (dirname $dir)
    end

    if set -q VIRTUAL_ENV
        deactivate
    end
end
