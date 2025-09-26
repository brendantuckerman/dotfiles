#!/bin/sh

echo "Cloning repositories..."

# CODE=$HOME/Code
SITES=$HOME/Projects
# BLADE=$CODE/blade-ui-kit
# LARAVEL=$CODE/laravel

# Sites
git clone git@github.com:brendantuckerman/project-eureka.git $SITES/ridd-site

# Vim
git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime


# Personal
# git clone git@github.com:lmsqueezy/laravel.git $CODE/lmsqueezy-laravel

# other categories ....
