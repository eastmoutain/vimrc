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

* Download source code

```sh
git clone https://github.com/ggml-org/llama.cpp --depth=1
cd llama.cpp
git fetch --unshdow
```

* Build for CUAD GPU

```sh
mkdir build
cd build 
cmake -B build -DGGML_CUDA=ON ..
cmake --build build --config Release
```

* Build for AMDGPU

Adjust you AMDGPU_TARGETS accordingly. Get your AMDGPU type with cmd:
```sh
rocminfo | grep gfx
Name:                    gfx1100
```

```sh
HIPCXX="$(hipconfig -l)/clang" HIP_PATH="$(hipconfig -R)" \
    cmake -S . -B build -DGGML_HIP=ON -DAMDGPU_TARGETS=gfx1100 -DCMAKE_BUILD_TYPE=Release \
    -DLLAMA_CURL=ON && cmake --build build --config Release -- -j 16
```
After build, you can find the executable at build/bin/llama-server. Here we copy
the `build` dir to `/opt/llama_amdgpu/build`. And add the executable to your PATH
variable.

```sh
export PATH=$PATH:/opt/llama_amdgpu/build/bin
```

* Download the model for llama.cpp

The offical website recommend to download the model from huggingface. Here is
an exmaple of download the model with llama.cli

```sh
llama-cli --hf-repo ggml-org/Qwen2.5-Coder-7B-Q8_0-GGUF \
          --hf-file qwen2.5-coder-7b-q8_0.gguf \
          -p "The meaning to life and the universe is"
```
The model is downloaded to `~/.cache/llama.cpp` by default.

# How to config remote server

On the server side, you need to install the llama.cpp and run llama-server.
Here is a linux kernel sevice template to start llama-server automatically.

Let's say you have install llama.cpp at /opt/llama_amdgpu.

Add a shell script to start llama-server which is executed by the service.

```sh
#!/bin/bash

# let g:llama_config = { 'endpoint' : 'http://192.168.1.102:8012/infill' }

source /home/dsh/.zshrc

/opt/llama_amdgpu/build/bin/llama-server -m /home/dsh/.cache/llama.cpp/ggml-org_Qwen2.5-Coder-1.5B-Q8_0-GGUF_qwen2.5-coder-1.5b-q8_0.gguf --host 192.168.1.102 --port 8012
```
> Remember to replace IP address and port number with your own, and them 
> identical with the config in your .vimrc

* llama.sercie file

```sh
[Unit]
Description="clash service"
After=syslog.target
After=network.target

[Service]
User=dsh
WorkingDirectory=/opt/llama_amdgpu
ExecStart=/bin/bash start_llama.sh
# optional items below
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
```

Install the service file at /etc/systemd/system/llama.service, then run the
command below to start the service.

```sh
systemctl enable llama.service
systemctl start llama.service
```
# How to use llama.vim at client side

* Add llama.vim plugin to your vim

```sh
Plug 'ggml-org/llama.vim'
```

* Add the following config to your .vimrc

```sh
let g:llama_config = { 'endpoint' : 'http://192.168.1.102:8012/infill' }
```

> Note: Remember to the IP address and port number identical with llama server config

# FAQ

* The client can't connect to llama server

vim throw error like this:

```
Job failed with exit code: 7
```

This is mainly caused by the network problem. Please check the network.

If you are using a proxy at the client side, make sure the connection to the
server is not forwarded through the proxy. You can add the following config to
your bashrc or zshrc to disable the proxy for the connection to the server.

```sh
export NO_PROXY="localhost, 127.0.0.1, 192.168.1.102"
```

Then source your bashrc or zshrc

