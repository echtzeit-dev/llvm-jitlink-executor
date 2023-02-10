# llvm-jitlink-executor

Minimal fork of the [llvm-project repository](https://github.com/llvm/llvm-project) to build the `llvm-jitlink-executor` tool on low-resource systems like the Raspberry Pi

```
> sudo apt install build-essential clang-13 lld-13 cmake ninja-build
> git clone https://github.com/echtzeit-dev/llvm-jitlink-executor
> mkdir llvm-jitlink-executor/build
> cd llvm-jitlink-executor/build
> CC=clang-13 CXX=clang++-13 cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=host -DLLVM_USE_LINKER=lld -DLLVM_PARALLEL_LINK_JOBS=1 ../llvm
> ninja -j3 llvm-jitlink-executor
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
