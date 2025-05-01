# setup cuda environment

## install cuda toolkit

Download cuda toolkit from https://developer.nvidia.com/cuda-toolkit, then
install it with sudo privilege. For example:

```bash
sudo cuda_12.8.1_570.124.06_linux.run
```

It will install both GPU driver and cuda toolkit.

## setup environment

Add cuda library path to `LD_LIBRARY_PATH` or ld.config

- LD_LIBRARY_PATH

```bash
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH
```

- ld.config

Edit /etc/ld.config.conf, add the following line:

```bash
/usr/local/cuda-12.8/lib64
```

Then reload ld.config
```sh
sudo ldconfig
```

## Install pytorch for cuda

```bash
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
```

Verify torch use cuda

```python
import torch
torch.cuda.is_available()
```

