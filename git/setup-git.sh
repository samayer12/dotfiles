#!/bin/bash
cd "$(dirname "$0")"

source ../_helpers.sh

if [[ ! `command -v diff-highlight` ]] && prompt "Install diff-highlight"; then 
  echo "Installing diff-highlight"
  if [[ `command -v easy_install` ]]; then
    sudo easy_install diff-highlight
  else
    echo "CANT INSTALL DIFF-HIGHLIGHT WITHOUT EASY_INSTALL"
  fi
else
  echo "Skipping diff-highlight"
fi
# alternatively:
# ln -s `pwd`/diff-highlight ~/bin/diff-highlight

if [[ ! `command -v git-number` ]] && prompt "Install git-number"; then
  if [ "$(uname)" == "Darwin" ]; then
    echo Installing git-number for Mac
    brew install git-number
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo Installing git-number for linux
    mkdir -p ~/git/git-number
    git clone https://github.com/holygeek/git-number.git ~/git/git-number
    cd ~/git/git-number
    if [[ ! `command -v make` ]]; then
      echo "PLEASE INSTALL MAKE TO INSTALL GIT-NUMBER"
    else
      sudo make install
    fi
    cd -
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo Good luck installing git-number here
  fi
else
  echo "Skipping git-number"
fi
