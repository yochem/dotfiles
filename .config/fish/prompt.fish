# don't prepend prompt with vi command mode
function fish_mode_prompt
end

# function for showing the git branch
function prompt_git
    git rev-parse --is-inside-work-tree &>/dev/null
    if [ "$status" = "0" ]
        set branchName (git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo -e '(unknown)')
        printf " ("
        set_color green
        printf "$branchName"
        set_color normal
        printf ") "
    else
        printf " "
    end
end

# the prompt normally looks like this: [ ~/Documents ]
# but can look like these:
# [ @host: ~/Documents ]
# [ root ~/Documents ]
# [ root@host: ~/Documents ]
function fish_prompt
    z --add "$PWD"
    set_color normal
    printf "[ "

    if [ "$USER" = "root" ]
        set_color brmagenta --bold
        printf "root"
        set_color normal
    end

    if [ -n "$SSH_CLIENT" ]
        set_color brmagenta
        printf "@"
        printf (prompt_hostname)
        set_color normal
        printf ": "
    end

    if [ "$USER" = "root" ] && [ -z "$SSH_CLIENT" ]
        printf " "
    end

    set_color blue
    printf (pwd | sed "s|$HOME|~|")
    set_color normal

    printf (prompt_git)
    printf "] "
end
