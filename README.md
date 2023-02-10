# llvm-jitlink-executor

Minimal fork of the [llvm-project repository](https://github.com/llvm/llvm-project) to build the `llvm-jitlink-executor` tool on low-resource systems like the Raspberry Pi

```
> sudo apt install build-essential clang-13 lld-13 cmake ninja-build
> git clone https://github.com/echtzeit-dev/llvm-jitlink-executor
> mkdir llvm-jitlink-executor/build
> cd llvm-jitlink-executor/build
> CC=clang-13 CXX=clang++-13 cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=host -DLLVM_USE_LINKER=lld -DLLVM_PARALLEL_LINK_JOBS=1 ../llvm
> ninja -j3 llvm-jitlink-executor
```
