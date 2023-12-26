# install rocm
https://rocm.docs.amd.com/en/docs-5.7.1/deploy/linux/os-native/install.html

# build hip-test
https://github.com/ROCm/HIP/blob/develop/docs/developer_guide/build.md

```sh
export ROCM_BRANCH=rocm-5.7.x

git clone -b "$ROCM_BRANCH" https://github.com/ROCm-Developer-Tools/hip-tests.git
export HIPTESTS_DIR="$(readlink -f hip-tests)"
cd "$HIPTESTS_DIR"
mkdir -p build; cd build
cmake ../catch -DHIP_PLATFORM=amd -DHIP_PATH=$CLR_DIR/build/install # or any path where HIP is installed, for example, /opt/rocm.
#cmake ../catch -DHIP_PLATFORM=amd -DHIP_PATH=/opt/rocm # or any path where HIP is installed, for example, /opt/rocm.

make -j$(nproc) build_tests # build tests

cd build/catch_tests && ctest # to run all tests.
```
