#!/bin/bash

THIS_FOLDER=$(pwd)
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
    vim +PluginInstall +qall
else
    echo 'Vundle already installed.'
fi

