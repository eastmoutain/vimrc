# reference repo
  https://github.com/ttroy50/cmake-examples

# added debug info
1. DCMAKE_BUILD_TYPE
    ```sh
    $ cmake -DCMAKE_BUILD_TYPE=Debug .
    ```

2. set CMAKE_C_FLAGS CMAKE_CXX_FLAGS
    edit CMakeList.txt file, add
    ```sh
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -ggdb")
    ```

3. verfiy
    after the settings above, execute make with VERBOSE=1
    ```sh
    $ make VERBOSE=1
    $ make[2]: Entering directory '/home/dsh/project/cmake-examples/01-basic/A-hello-cmake'
[ 50%] Building CXX object CMakeFiles/hello_cmake.dir/main.cpp.o
/usr/bin/c++   -g -MD -MT CMakeFiles/hello_cmake.dir/main.cpp.o -MF CMakeFiles/hello_cmake.dir/main.cpp.o.d -o CMakeFiles/hello_cmake.dir/main.cpp.o -c /home/dsh/project/cmake-examples/01-basic/A-hello-cmake/main.cpp
        ```
