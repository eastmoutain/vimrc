
## how to set gcc

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9

sudo update-alternatives --config gcc
sudo update-alternatives --config g++

## how to set python, for example python3.8
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 360
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 380
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 390
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 311

sudo update-alternatives --config python3
