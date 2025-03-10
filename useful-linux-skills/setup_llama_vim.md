# install vim plugin
add the line below to your .vimrc
```sh
Plug 'ggml-org/llama.vim'
```

# install llama.cpp
The offical website: https://github.com/ggml-org/llama.cpp

You can download the pre-build binary from relese site, or build it for you sysetem if you have GPU card.

## download release binary
URL: https://github.com/ggml-org/llama.cpp/releases

## build from souce code

Download source code

```sh
git clone https://github.com/ggml-org/llama.cpp --depth=1
cd llama.cpp
git fetch --unshdow
```

Build for CUAD GPU.
```sh
mkdir build
cd build 
cmake -B build -DGGML_CUDA=ON ..
cmake --build build --config Release
```

Build for AMDGPU

Adjust you AMDGPU_TARGETS accordingly. Get your AMDGPU type with cmd:
```sh
rocminfo | grep gfx
Name:                    gfx1100
```

```sh
HIPCXX="$(hipconfig -l)/clang" HIP_PATH="$(hipconfig -R)" \
    cmake -S . -B build -DGGML_HIP=ON -DAMDGPU_TARGETS=gfx1100 -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --config Release -- -j 16
```
