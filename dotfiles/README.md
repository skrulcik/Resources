# Dotfiles

Configuration files and other scripts for setting up a new computer.

## Setup

1. <strike>Delete existing dotfiles</strike> Copy old dotfiles to a backup directory
2. Navigate to this folder
3. Run `link_all.sh`
4. Install vim plugins
    1. Run `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall`
5. Install tmux plugins
    1. Install [TPM](https://github.com/tmux-plugins/tpm).
    2. Set the configuration file: `$ tmux source ~/.tmux.conf`
    3. From within tmux, run `prefix + I` to import the packages.
6. If on a Mac:
    1. Download iTerm2
    2. Install Xcode command line tools
        `xcode-select --install`
    3. Run `./SetMacDefaults.sh`. Some changes won't take effect until the computer is restarted.
    4. If using Time Machine, ignore directories full of random crap:
        1. Go to System Preferences > Time Machine
        2. Click on the "Options..." button in the bottom left, and a dialog should pop up including a list of files to ignore.
        3. Add _at least_ these folders to the ignored list:
            - `~/Downloads`
            - `~/Library/Caches/com.spotify.client/Storage`
            - `~/.Trash`
            - Any virtual machines, sdks, emulator images, etc.



