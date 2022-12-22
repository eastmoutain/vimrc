

```sh
./configure --target-list=x86_64-softmmu --enable-debug --prefix=/usr/local/qemu-github --with-git-submodules=validate --enable-gtk

make -j${nproc}

sudo make isntall

```
