#!/bin/sh

echo "Setting up your Mac..."

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

#Do the same with the p10k.zsh file
rm -rf $HOME/.p10k.zsh
ln -sw $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Create a projects location
mkdir $HOME/Projects

# Create Code subdirectories
# mkdir $HOME/Code/work
# mkdir $HOME/Code/play

# Clone Github repositories
./clone.sh

# Install the newly cloned Awesome vim
sh $HOME/.vim_runtime/install_awesome_vimrc.sh

# Symlink my personal vim preferences
rm $HOME/.vim_runtime/my_configs.vim
ln -sw $HOME/.dotfiles/my_configs.vim $HOME/.vim_runtime/my_configs.vim

# Symlink the Mackup config file to the home directory
ln -s ./.mackup.cfg $HOME/.mackup.cfg

# Add VS Code CLI to PATH if not already available
if ! command -v code &>/dev/null; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Install VS Code extensions
code --install-extension antfu.iconify
code --install-extension anthropic.claude-code
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension dbaeumer.vscode-eslint
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension hollowtree.vue-snippets
code --install-extension mblode.twig-language-2
code --install-extension ms-python.debugpy
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.vscode-python-envs
code --install-extension ms-vscode.makefile-tools
code --install-extension vue.volar
code --install-extension xdebug.php-debug

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
