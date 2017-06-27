# smart_vopen - Opens two files in a vertical split, if there is room,
# in tabs otherwise
smart_vopen() {
    # 85 is the minimum column width because of line numbers and git gutter
    if (($(tput cols) / 85 >= $#));
    then
        # Open in a vertical split
        vim -O $@
    else
        # Open in tabs
        vim -p $@
    fi
}

# Shortened "vim" alias defined as a function, so it can be overridden by
# other modules (such as fzf.bash)
v() {
    smart_vopen $@;
}


