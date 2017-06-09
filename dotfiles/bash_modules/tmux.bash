# tmux - terminal multiplexer

# gmux - Quickly open a tmux session, or create it if it doesn't exist. Named
# after a similar script for CITC clients I used at Google
gmux() {
    if [ -z "$1" ]
    then
        echo 'Usage:'
        echo 'open: gmux <session name>'
        echo 'list: gmux ls'
    else
        if [ "$1" = 'ls' ];
        then
            tmux ls
        else
            # Attempt to go to the given directory
            tmux attach-session -dt $1 || tmux new -s $1
        fi
    fi
}

