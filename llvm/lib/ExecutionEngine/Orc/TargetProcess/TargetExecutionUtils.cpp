//===--- TargetExecutionUtils.cpp - Execution utils for target processes --===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/ExecutionEngine/Orc/TargetProcess/TargetExecutionUtils.h"
#include "llvm/ExecutionEngine/JITSymbol.h"

#include <vector>

namespace llvm {
namespace orc {

int runAsMain(int (*Main)(int, char *[]), ArrayRef<std::string> Args,
              std::optional<StringRef> ProgramName) {
  std::vector<std::unique_ptr<char[]>> ArgVStorage;
  std::vector<char *> ArgV;

  ArgVStorage.reserve(Args.size() + (ProgramName ? 1 : 0));
  ArgV.reserve(Args.size() + 1 + (ProgramName ? 1 : 0));

  if (ProgramName) {
    ArgVStorage.push_back(std::make_unique<char[]>(ProgramName->size() + 1));
    llvm::copy(*ProgramName, &ArgVStorage.back()[0]);
    ArgVStorage.back()[ProgramName->size()] = '\0';
    ArgV.push_back(ArgVStorage.back().get());
  }

  for (const auto &Arg : Args) {
    ArgVStorage.push_back(std::make_unique<char[]>(Arg.size() + 1));
    llvm::copy(Arg, &ArgVStorage.back()[0]);
    ArgVStorage.back()[Arg.size()] = '\0';
    ArgV.push_back(ArgVStorage.back().get());
  }
  ArgV.push_back(nullptr);

  int RawArgc = Args.size() + !!ProgramName;
  char **RawArgv = ArgV.data();

  printf("Calling int main(%d, 0x%08" PRIx64 ") @0x%08" PRIx64 "\n",
         RawArgc, pointerToJITTargetAddress(RawArgv),
         pointerToJITTargetAddress(Main));
  int Result = Main(RawArgc, RawArgv);
  printf("main @0x%08" PRIx64 " returned: %d\n", pointerToJITTargetAddress(Main), Result);

  return Result;
}

int runAsVoidFunction(int (*Func)(void)) { return Func(); }

int runAsIntFunction(int (*Func)(int), int Arg) { return Func(Arg); }

} // End namespace orc.
} // End namespace llvm.
