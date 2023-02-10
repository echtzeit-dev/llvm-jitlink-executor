# llvm-jitlink-executor

Minimal fork of the [llvm-project repository](https://github.com/llvm/llvm-project) to build the `llvm-jitlink-executor` tool on low-resource systems like the Raspberry Pi

## Build

LLVM requires CMake 3.20.0 and Raspbian only 3.18.4 has. We have to build our own CMake first (that will take a while):
```
> git clone https://github.com/Kitware/CMake cmake
> cd cmake
> git checkout tags/v3.27.7 -b release/v3.27.7
> ./bootstrap && make && sudo make install
> cmake --version | head -1
cmake version 3.27.7
```

Now that we have a recent CMake version, we can install remaining tools, configure and build:
```
> sudo apt install build-essential clang-13 lld-13 ninja-build
> git clone https://github.com/echtzeit-dev/llvm-jitlink-executor
> mkdir llvm-jitlink-executor/build
> cd llvm-jitlink-executor/build
> CC=clang-13 CXX=clang++-13 cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=host -DLLVM_USE_LINKER=lld -DLLVM_PARALLEL_LINK_JOBS=1 ../llvm
> ninja -j3 llvm-jitlink-executor
```

## Run

Once we run `llvm-jitlink-executor`, it will wait for an incoming TCP connection from `llvm-jitlink`. Let's dump our device IP address first so we can pass it to `llvm-jitlink` later like this `--oop-executor-connect=192.168.1.103:20000`.

```
> ip address | grep 192.168
    inet 192.168.1.103/24 brd 192.168.1.255 scope global noprefixroute eth0
> ./bin/llvm-jitlink-executor listen=0.0.0.0:20000
Listening at 0.0.0.0:20000
Connected! Starting SimpleRemoteEPCServer.
Bootstrap symbols:
  __llvm_orc_bootstrap_deregister_ehframe_section_wrapper: 0x00101ff0
  __llvm_orc_bootstrap_run_as_main_wrapper: 0x0011cb04
  __llvm_orc_bootstrap_run_as_void_function_wrapper: 0x0011cb4c
  __llvm_orc_bootstrap_mem_write_uint32s_wrapper: 0x0011ca2c
  __llvm_orc_bootstrap_register_ehframe_section_wrapper: 0x00101f34
  __llvm_orc_bootstrap_mem_write_uint16s_wrapper: 0x0011c9e4
  __llvm_orc_bootstrap_mem_write_uint8s_wrapper: 0x0011c99c
  __llvm_orc_bootstrap_mem_write_uint64s_wrapper: 0x0011ca74
  __llvm_orc_bootstrap_mem_write_buffers_wrapper: 0x0011cabc
  __llvm_orc_bootstrap_run_as_int_function_wrapper: 0x0011cb94
Calling int main(0, 0x758005f8) @0x76ff4001
Hello arm!
main @0x76ff4001 returned: 0
^C
```
