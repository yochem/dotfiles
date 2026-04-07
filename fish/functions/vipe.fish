function vipe --description 'Edit pipe content in your editor (like moreutils vipe)'
    set tmp (mktemp)
    if not isatty stdin
        cat >$tmp
    end
    nvim $tmp </dev/tty >/dev/tty
    cat $tmp
    command rm -f $tmp >/dev/null 2>&1
end
