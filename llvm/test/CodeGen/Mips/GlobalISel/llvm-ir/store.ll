; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

define void @store_i32(i32 %val, ptr %ptr)  {
; MIPS32-LABEL: store_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sw $4, 0($5)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  store i32 %val, ptr %ptr
  ret void
}

define void @store_i64(i64 %val, ptr %ptr)  {
; MIPS32-LABEL: store_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sw $4, 0($6)
; MIPS32-NEXT:    sw $5, 4($6)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  store i64 %val, ptr %ptr
  ret void
}

define void @store_float(float %val, ptr %ptr)  {
; MIPS32-LABEL: store_float:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    swc1 $f12, 0($5)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  store float %val, ptr %ptr
  ret void
}

define void @store_double(double %val, ptr %ptr)  {
; MIPS32-LABEL: store_double:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sdc1 $f12, 0($6)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  store double %val, ptr %ptr
  ret void
}
