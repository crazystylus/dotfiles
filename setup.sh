#!/bin/env bash

# Clone source repo
git clone https://github.com/crazystylus/sources.git $HOME/.sources

# Install Cargo and Rust
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Source cargo env
#source $HOME/.cargo/env

# Install zoxide and exa
#cargo install zoxide exa

# Install Powerline10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
mkdir -p $HOME/.zprompts
ln -s $HOME/powerlevel10k/powerlevel10k.zsh-theme $HOME/.zprompts/prompt_powerline10k_setup

# Install Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Vim Plug for NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Creating all necessary directories
mkdir -p $HOME/.zprompts/
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/alacritty
mkdir -p $HOME/.config/nvim

# Create all required symlinks
ln -s $HOME/.sources/.zshrc $HOME/.zshrc
ln -s $HOME/.sources/.zprofile $HOME/.zprofile
ln -s $HOME/.sources/.vimrc $HOME/.vimrc
ln -s $HOME/.sources/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/.sources/.config/i3/config $HOME/.config/i3/config
ln -s $HOME/.sources/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -s $HOME/.sources/.vimrc $HOME/.config/nvim/init.vim

# Create SymLinks for bash scripts
ln -s $HOME/.sources/scripts/dualm.sh $HOME/.local/bin/dualm.sh
ln -s $HOME/.sources/scripts/force-composition-pipeline.sh $HOME/.local/bin/force-composition-pipeline.sh

# Install Vim Plugins
#vim +PlugInstall +qall +CocInstall coc-rust-analyzer

# Install nodejs for coc.nvim
#curl -sL install-node.vercel.app/lts | bash

#printf "\nVIM:\n:CocInstall coc-rust-analyzer\n\n"
