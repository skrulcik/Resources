#!/bin/bash
#
# Creates symbolic links between dotfiles and their counterparts in this
# resources directory

# Get directory code from:
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
THIS_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES=(vimrc bashrc gitconfig tmux.conf)

# First copy standard dotfiles
for i in ${DOTFILES[@]};
do
    if [ -L ~/.$i ]
    then
        echo ~/.$i exists, skipped.
    else
        echo "Linking $i..."
        ln -s "$THIS_FOLDER/$i" ~/.$i
    fi
done

# Special case to create vim color and plugins directory
mkdir -p ~/.vim/colors

VIM_COLOR_FILE=krulcikcolor.vim
if [ ! -L ~/.vim/colors/$VIM_COLOR_FILE ]
then
    echo "Linking Vim color file..."
    ln -s "$THIS_FOLDER/$VIM_COLOR_FILE" ~/.vim/colors/$VIM_COLOR_FILE
else
    echo Vim color file exists, skipped.
fi

# Install Vim Plugins
mkdir -p ~/.vim/bundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
    echo 'Installing Vundle'
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    echo 'Vundle already installed.'
fi

echo 'Updating Vim plugins...'
vim +PluginInstall +qall
