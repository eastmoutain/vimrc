#!/bin/bash


# /etc/yum.conf
# proxy=http://IP:port
# ip_resolve=IPv4

# ~/.bashrc
# http_proxy="http://IP:port
# https_proxy="http://IP:port

# sudo use proxy, add the line in /etc/sudoers
# Defaults    env_keep += "ftp_proxy http_proxy https_proxy no_proxy"

# add /usr/local/lib to library search list
# add "/usr/local/lib" in /etc/ld.so.conf.d/usr-local.conf
echo "please setup system proxy, then remove return, and try again"

return


sudo yum update -y
sudo yum groupinstall 'Development Tools'
sudo yum install -y centos-release-scl devtoolset-7 devtoolset-8 devtoolset-9 devtoolset-11
sudo yum install -y openssl openssl-devel glib2 glib2-devel pixman pixman-devel
sudo yum install -y git autoconf automake binutils bison flex gettext libtool make patch pkgconfig \
     redhat-rpm-config rpm-build rpm-sign elfutils indent patchutils curl cscope ripgrep \
     libffi libffi-devel ncurses-devel cmake locales-all
sudo yum install -y elfutils-libelf-devel

sudo yum install -y strace trace-cmd

mkdir software
cd software
git clone https://github.com/eastmoutain/vimrc
cp vimrc/vimrc /home/thomas/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#install ctags
sudo rm -rf ctags
git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen.sh && ./configure --prefix=/usr/local && make -j4 && sudo make install
cd ..


#install cmake3
sudo rm -rf cmake-3.27.5-linux-x86_64.sh
wget https://github.com/Kitware/CMake/releases/download/v3.27.5/cmake-3.27.5-linux-x86_64.sh
sudo chmod +x cmake-3.27.5-linux-x86_64.sh
./cmake-3.27.5-linux-x86_64.sh --skip-license --prefix=/usr/local

# install python3.10
sudo rm -rf Python-3.10.13.tgz Python-3.10.13
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
sudo tar xvf Python-3.10.13.tgz
cd Python-3.10.13
./configure --enable-optimizations --enable-shared
sudo make -j64 altinstall
cd ..


#install vim
rm -rm -rf vim
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte \
    --enable-rubyinterp=yes --enable-python3interp=yes \
    --enable-cscope \
    --prefix=/usr/local \
    --enable-fail-if-missing
make -j64 && sudo make install
cd ..

##install fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git fzf
#cd fzf && ./install
#cd ..

#install oh-my-bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

