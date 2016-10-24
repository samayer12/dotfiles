#!/bin/bash
cd "$(dirname "$0")"

echo "Creating symbolic link for NeoVim"
mkdir -p ~/.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim

# Install Vim-Plug
echo "Installing Vim-Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install FZF
echo "Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf
ln -s ~/.fzf/bin/fzf-tmux /usr/local/bin/fzf-tmux

# Install Powerline fonts
echo "Installing Powerline fonts"
git submodule init
git submodule update
powerline-fonts/install.sh

echo ""
echo "To install Plug pluggins"
echo "    :PlugInstall (inside vim)"
