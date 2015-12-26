#!/bin/sh
#
# Scott Krulcik
#
# A lot of this is shamelessly stolen from bashrc_gpi from CMU's Great 
# Practical Ideas course
#
# To use on Mac, put `source ~/.bashrc` in the .bash_profile file
#

## Prompt style (uncomment 1)
# Short path, no host:
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
# Short path, with host:
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# Long path, no host:
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Long path, with host:
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

shopt -s checkwinsize         # Update window size after each command

## History configuration
export HISTCONTROL=ignoreboth # Don't store duplicates
shopt -s histappend           # Append only to history

#Set up environment variables
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/Applications/ShellScripts:$PATH
#Remove case sensitive completion
if [ -f /etc/bash_completion ]; then
     . /etc/bash_completion
fi
bind "set completion-ignore-case on"


## Open shell to last cd
if [ -e ~/.last_cd ]
then
    cd "$(cat ~/.last_cd)"
fi
logged_cd() {
    cd "$@"
    pwd > ~/.last_cd
}
alias cd="logged_cd" # Keep track of most recent directory

## Useful aliases
alias ls="ls -G"
alias ccomp='gcc -Wall -Wextra -Werror -std=c99 -pedantic'
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'
alias hidden='ls -a | grep "^\..*"'
alias linelength='wc -L'
alias grep='grep --color=auto'
mkcd() { mkdir -p "$@" && cd "$_"; }


## Mac-specific changes
if [[ `uname` = "Darwin" || `uname` = "FreeBSD" ]]
then
  alias ls='ls -G'
  # Start up ssh-agent
  [[ -z $SSH_AGENT_PID && -z $DISPLAY ]] &&
    exec -l ssh-agent $SHELL -c "bash --login"
else
  alias ls='ls --color=auto'
  # Linux shutdown command (works on RasPi, haven't tested on others)
  alias shutdown="sudo shutdown -h now"
fi


gpi_makemake() {
    supported_extensions='tex java c c0'
	found=0
    for ext in $supported_extensions; do
        files=$(ls *.$ext 2> /dev/null | wc -l)
        if [ "$files" != "0" ]; then
			found=1
            break
        fi
    done
	if [ "$found" == "0" ]; then
		echo -e "You don't have any of the supported file types in this directory"
		return
	fi
	

    if [ "$ext" == "tex" ]; then
        echo -e "gpi_makemake is making you a LaTeX Makefile!"
        if [ "$files" == "1" ]; then
            file=$(echo *.${ext})
        else
            echo -e "There is more than one LaTeX file in your directory..."
            echo -e "Choose one from the list to be the main source file."
            select file in *.$ext; do break; done
        fi

        if [ "$file" == "" ]; then
            echo -e "Aborting..."
        else
            cat ${GPI_PATH}/makefiles/latex.mk |
                sed -e "s/GPIMAKEMAKE/${file%.tex}/" > Makefile
            echo "gpi_makemake has installed a LaTeX Makefile for $file"
            echo "${c_green}make${c_reset} -- Compiles the LaTeX document into a PDF"
            echo "${c_green}make clean${c_reset} -- Removes aux and log files"
            echo "${c_green}make veryclean${c_reset} -- Removes pdf, aux, and log files"
            echo "${c_green}make view${c_reset} -- Display the generated PDF file"
            echo "${c_green}make print${c_reset} -- Sends the PDF to print"
        fi
    elif [ "$ext" == "java" ]; then
        echo "gpi_makemake doesn't support java yet.  We will add it soon!"
    elif [ "$ext" == "c" ]; then
        echo -e "gpi_makemake is making you a C Makefile!"
        echo -n "What should the name of the target executable be? "
        read target

        cat ${GPI_PATH}/makefiles/c.mk |
            sed -e "s/GPIMAKEMAKE_TARGET/${target}/" > Makefile
        echo "gpi_makemake has installed a C Makefile!"
        echo "${c_green}make${c_reset} -- Compiles the C Program (no debug information)"
        echo "${c_green}make debug${c_reset} -- Compiles the C Program (with debugging information!)"
        echo "${c_green}make run${c_reset} -- Re-compiles (if necessary) and run the program"
        echo "${c_green}make clean${c_reset} -- Deletes the created object files"
        echo "${c_green}make veryclean${c_reset} -- Deletes the created object files and dependencies"
    elif [ "$ext" == "c0" ]; then
        echo -e "gpi_makemake is making you a C0 Makefile!"
        echo -n "List the C0 source files separated by spaces: "
        read sources
        echo -n "What should the name of the target executable be? "
        read target
 cat ${GPI_PATH}/makefiles/c0.mk |
            sed -e "s/GPIMAKEMAKE_TARGET/${target}/" |
            sed -e "s/GPIMAKEMAKE_SOURCE/${sources}/" > Makefile
        echo "gpi_makemake has installed a C0 Makefile"
        echo "${c_green}make${c_reset} -- Compiles the C0 Program (no debug information)"
        echo "${c_green}make debug${c_reset} -- Compiles the C0 Program (with debugging information!)"
        echo "${c_green}make run${c_reset} -- Re-compiles (if necessary) and run the program"
        echo "${c_green}make clean${c_reset} -- Deletes the created object files"
        echo "${c_green}make veryclean${c_reset} -- Deletes the created object files and dependencies"

    fi
}




