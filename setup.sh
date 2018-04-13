#!/bin/sh

RED='\033[0;31m'
NC='\033[0m'

gitConfig=false
profileSetup=false

while [ $# -gt 0 ]
do
  key="$1"

  case $key in
    -git)
    gitConfig=true
    shift
    ;;
    -profile)
    profileSetup=true
    shift
    ;;
    *)
    shift
    ;;
  esac
done

if [ $gitConfig = true ]; then
  if [ ! which git -eq "" ]; then
    git config --global alias.ci commit
    git config --global alias.co checkout
    git config --global alias.st status
    git config --global alias.lg 'log --oneline --graph --decorate'
    git config --global alias.lgs 'log --oneline --graph --decorate --stat'
    git config --global core.editor 'vim'
  fi
fi

if [ $profileSetup = true ]; then
  if [ $HOME = "" ]; then
    HOME = '~'
  fi

  # check for existing .profile
  if [ -e $HOME/.profile ]; then
    mv $HOME/.profile $HOME/.old_profile
  fi

  # check for existing zsh config
  if [ -e $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.old_zshrc
  fi

  # check whethe zsh is installed
  if [ ! which zsh -eq "" ]; then
    echo -e "${RED}warning:\tno zsh installed${NC}"
  fi

  cp -r .profile $HOME/
fi

if [ $gitConfig = false ] && [ $profileSetup = false ]; then
  echo "usage: setup.sh -git -profile"
fi
