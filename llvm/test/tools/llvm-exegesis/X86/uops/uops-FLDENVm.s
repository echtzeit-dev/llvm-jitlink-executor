# RUN: llvm-exegesis -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mode=uops --benchmark-phase=assemble-measured-code -opcode-name=FLDENVm,FLDL2E -repetition-mode=duplicate | FileCheck %s

CHECK:      mode:            uops
CHECK-NEXT: key:
CHECK-NEXT:   instructions:
CHECK-NEXT:     FLDENVm
