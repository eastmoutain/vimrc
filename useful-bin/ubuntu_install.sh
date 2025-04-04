#!/bin/bash

echo "hello"

# install tools
sudo apt install -y openssh-server curl autoconf automake libncurses5-dev cmake vim git gcc g++ pkg-config  cscope

# install vundle for vim plugins managment
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir software -p && cd software

git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen && ./configure --prefix="/usr/local" && make -j$(nproc) && sudo make install

#install zsh
sudo apt install zsh && chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git
./fzf/install

git clone https://github.com/eastmoutain/vimrc
cp vimrc/vimrc ~/.vimrc
cp vimrc/myprofile ~/.myprofile
# add this line at the end of ~/.zshrc
#[ -f ~/.myprofile ] && source ~/.myprofile

