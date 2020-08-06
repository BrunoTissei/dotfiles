#!/bin/bash

DPROFILE=$(dconf list /org/gnome/terminal/legacy/profiles:/)
dconf write /org/gnome/terminal/legacy/profiles:/${DPROFILE%/}/background-color "'rgb(27,32,42)'"
dconf write /org/gnome/terminal/legacy/profiles:/${DPROFILE%/}/foreground-color "'rgb(255,255,255)'"

sudo apt install neovim git curl tmux

if [ ! -L $HOME/.config/nvim ]; then
  ln -s $DROPBOX/config/nvim $HOME/.config/nvim
fi

if [ ! -f $HOME/.tmux.conf ]; then
  ln -s $DROPBOX/Dotfiles/tmux.conf $HOME/.tmux.conf
fi

if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
