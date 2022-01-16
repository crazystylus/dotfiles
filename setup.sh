#!/bin/env bash

#Clone source repo
git clone --recurse-submodules -j8 https://github.com/crazystylus/dotfiles.git $HOME/.dotfiles

#Install Cargo and Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#Source cargo env
source $HOME/.cargo/env

#Install zoxide and exa
cargo install zoxide exa bat

#Install Vim Plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Install Vim Plug for NeoVim
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Creating all necessary directories
mkdir -p $HOME/.zprompts/
mkdir -p $HOME/.local/bin/
mkdir -p $HOME/.config/i3/
mkdir -p $HOME/.config/alacritty/
mkdir -p $HOME/.config/nvim/

#Create all required symlinks
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.zprofile $HOME/.zprofile
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/.dotfiles/.config/i3/config $HOME/.config/i3/config
ln -s $HOME/.dotfiles/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -s $HOME/.dotfiles/.vimrc $HOME/.config/nvim/init.vim
ln -s $HOME/.dotfiles/powerlevel10k/powerlevel10k.zsh-theme $HOME/.zprompts/prompt_powerline10k_setup

#Create SymLinks for bash scripts
ln -s $HOME/.dotfiles/scripts/dualm.sh $HOME/.local/bin/dualm.sh
ln -s $HOME/.dotfiles/scripts/force-composition-pipeline.sh $HOME/.local/bin/force-composition-pipeline.sh

#Install Vim Plugins
#vim + PlugInstall + qall + CocInstall coc - rust - analyzer

#Install nodejs for coc.nvim
#curl - sL install - node.vercel.app / lts | bash

#printf "\nVIM:\n:CocInstall coc-rust-analyzer\n\n"
# pip3 install yamllint yamlfix
