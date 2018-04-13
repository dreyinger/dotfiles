#!/bin/sh

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

if [ $gitConfig = false ] && [ $profileSetup = false ]; then
  echo "usage: setup.sh -git -profile"
fi

if [ $gitConfig = true ]; then
  if [ ! which git -eq "" ]
    git config --global alias.ci commit
    git config --global alias.co checkout
    git config --global alias.st status
    git config --global alias.lg 'log --oneline --graph --decorate'
    git config --global alias.lgs 'log --oneline --graph --decorate --stat'
    git config --global core.editor 'vim'
  fi
fi
