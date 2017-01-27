#!/bin/bash
#
# Sets up resources on a new computer

# Make this resource path globally available
# Get directory code from:
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
RESOURCE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $RESOURCE_PATH > ~/.krulcik_resource_path

# First, link dotfiles
bash $RESOURCE_PATH/dotfiles/link_all.sh

# If we are on a Mac, run the mac configuration script
if [[ `uname` = "Darwin" || `uname` = "FreeBSD" ]]
then
    bash $RESOURCE_PATH/dotfiles/SetMacDefaults.sh
fi

# If not already done, update submodule for go command
if [ ! -e $RESOURCE_PATH/bin/go-navigator/go ];
then
    git submodule init
fi
# Update in case there are new changes
git submodule update
