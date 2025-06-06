#!/bin/bash


# for centos: /etc/yum.conf
# proxy=http://IP:port
# ip_resolve=IPv4

# for ubuntu
# create /etc/apt/apt.conf.d/99force-ipv4
# add "Acquire::ForceIPv4 "true";"

# ~/.bashrc
# PROXY_IP=192.168.1.1
# PROXY_PORT=7890
# http_proxy="http://$PROXY_IP:$PROXY_PORT
# https_proxy="http://$PROXY_IP:$PROXY_PORT

# sudo use proxy, add the line in /etc/sudoers
# Defaults    env_keep += "ftp_proxy http_proxy https_proxy no_proxy"

# ld library path: add /usr/local/lib to library search list
# add "/usr/local/lib" in /etc/ld.so.conf.d/usr-local.conf

# enable ssh login with password
# edit /etc/ssh/sshd_config
# set "PubkeyAuthentication yes"
# set "PasswordAuthentication yes"

# install network manager
# sudo apt-get install network-manager
# sudo systemctl start NetworkManager
# set "managed=true" in /etc/NetworkManager/NetworkManager.conf
# Disable waitting network online service
# systemctl disable systemd-networkd-wait-online.service

# sshd configure
# sudo ssh-keygen -A
# sudo /usr/sbin/sshd -T

# network: add to /etc/network/interfaces
# auto eth1
# iface eth1 inet dhcp

# can't ssh to the machine
# sudo ssh-keygen -A
# and set "PasswordAuthentication  yse"
#
# enable dhclient in /etc/rc.local
#===========================
# #!/bin/sh
# dhclient
#===========================
# chmod +x /etc/rd.lcoal

echo "please setup system proxy, then remove return, and try again"

return

#setup local language
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales

sudo apt upgrade update
sudo apt install -y build-essential

sudo apt install -y gcc g++ git curl pkg-config libglib2.0-dev
sudo apt install -y git autoconf automake binutils bison flex gettext \
                    libtool make patch elfutils indent patchutils curl cscope \
                    libffi-dev libncurses5-dev  zlib1g-dev \
		            ruby ruby-dev bc rsync libelf-dev libssl-dev cmake \
                    locales-all cscope

sudo apt install -y strace trace-cmd

# for build qemu
sudo apt install -y device-tree-compiler qemu-keymaps

# install libvirt
sudo apt install qemu-kvm libvirt-daemon-system
sudo adduser $USER libvirt
# use lagcy iptable, some platform can't create virbr0 NIC
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

mkdir software
cd software
git clone https://github.com/eastmoutain/vimrc
cp vimrc/vimrc /home/thomas/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
./configure --enable-optimizations --enable-shared -with-zlib=/usr/local/include
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

