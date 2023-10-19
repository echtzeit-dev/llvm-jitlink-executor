; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

define i32 @icmp_eq(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_eq:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eq_constant(i32 %a) nounwind {
; RV32I-LABEL: icmp_eq_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -42
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, 42
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eq_constant_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_eq_constant_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -2047
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, 2049
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eq_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_eq_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -2048
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eq_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_eq_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, -2048
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, -2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eq_constant_neg_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_eq_constant_neg_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, 2047
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, -2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_eqz(i32 %a) nounwind {
; RV32I-LABEL: icmp_eqz:
; RV32I:       # %bb.0:
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp eq i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_ne:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_constant(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -42
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, 42
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_constant_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_constant_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -2047
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, 2049
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -2048
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, -2048
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, -2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_constant_neg_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_constant_neg_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, 2047
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, -2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_nez(i32 %a) nounwind {
; RV32I-LABEL: icmp_nez:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ne_neg_1(i32 %a) nounwind {
; RV32I-LABEL: icmp_ne_neg_1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, -1
; RV32I-NEXT:    ret
  %1 = icmp ne i32 %a, -1
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_ugt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp ugt i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_ugt_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ugt i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_ugt_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 2047
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp ugt i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt_constant_2046(i32 %a) nounwind {
; RV32I-LABEL: icmp_ugt_constant_2046:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, 2047
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp ugt i32 %a, 2046
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_ugt_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, -2048
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
; 4294965247 signed extend is -2049
  %1 = icmp ugt i32 %a, 4294965247
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ugt_constant_neg_2050(i32 %a) nounwind {
; RV32I-LABEL: icmp_ugt_constant_neg_2050:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2046
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    ret
; 4294965246 signed extend is -2050
  %1 = icmp ugt i32 %a, 4294965246
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_uge:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp uge i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_uge_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:    ret
  %1 = icmp uge i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_uge_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, 2047
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp uge i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_uge_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 2047
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp uge i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_uge_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, -2048
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
; 4294965248 signed extend is -2048
  %1 = icmp uge i32 %a, 4294965248
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_uge_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_uge_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2046
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    ret
; 4294965247 signed extend is -2049
  %1 = icmp uge i32 %a, 4294965247
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_ult:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp ult i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_ult_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:    ret
  %1 = icmp ult i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_ult_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, 2047
; RV32I-NEXT:    ret
  %1 = icmp ult i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_ult_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 11
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ult i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_ult_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, -2048
; RV32I-NEXT:    ret
; 4294965248 signed extend is -2048
  %1 = icmp ult i32 %a, 4294965248
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ult_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_ult_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2047
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    ret
; 4294965247 signed extend is -2049
  %1 = icmp ult i32 %a, 4294965247
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_ule:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp ule i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_ule_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ule i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule_constant_2046(i32 %a) nounwind {
; RV32I-LABEL: icmp_ule_constant_2046:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, 2047
; RV32I-NEXT:    ret
  %1 = icmp ule i32 %a, 2046
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_ule_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 11
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp ule i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_ule_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, -2048
; RV32I-NEXT:    ret
; 4294965247 signed extend is -2049
  %1 = icmp ule i32 %a, 4294965247
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_ule_constant_neg_2050(i32 %a) nounwind {
; RV32I-LABEL: icmp_ule_constant_neg_2050:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2047
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    ret
; 4294965246 signed extend is -2050
  %1 = icmp ule i32 %a, 4294965246
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_sgt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slt a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_sgt_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sgtz a0, a0
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt_constant_2046(i32 %a) nounwind {
; RV32I-LABEL: icmp_sgt_constant_2046:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 2047
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, 2046
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_sgt_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 2047
; RV32I-NEXT:    slt a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_sgt_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, -2048
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, -2049
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sgt_constant_neg_2050(i32 %a) nounwind {
; RV32I-LABEL: icmp_sgt_constant_neg_2050:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2046
; RV32I-NEXT:    slt a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp sgt i32 %a, -2050
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_sge:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_sge_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_sge_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 2047
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_sge_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 2047
; RV32I-NEXT:    slt a0, a1, a0
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge_constant_neg_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_sge_constant_neg_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, -2047
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, -2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sge_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_sge_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    ret
  %1 = icmp sge i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_slt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_slt_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_slt_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 2047
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt_constant_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_slt_constant_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    slli a1, a1, 11
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, 2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt_constant_neg_2048(i32 %a) nounwind {
; RV32I-LABEL: icmp_slt_constant_neg_2048:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, -2048
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, -2048
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_slt_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_slt_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2047
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp slt i32 %a, -2049
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: icmp_sle:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slt a0, a1, a0
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle_constant_zero(i32 %a) nounwind {
; RV32I-LABEL: icmp_sle_constant_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 1
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, 0
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle_constant_2046(i32 %a) nounwind {
; RV32I-LABEL: icmp_sle_constant_2046:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 2047
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, 2046
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle_constant_2047(i32 %a) nounwind {
; RV32I-LABEL: icmp_sle_constant_2047:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    slli a1, a1, 11
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, 2047
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle_constant_neg_2049(i32 %a) nounwind {
; RV32I-LABEL: icmp_sle_constant_neg_2049:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, -2048
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, -2049
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @icmp_sle_constant_neg_2050(i32 %a) nounwind {
; RV32I-LABEL: icmp_sle_constant_neg_2050:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2047
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp sle i32 %a, -2050
  %2 = zext i1 %1 to i32
  ret i32 %2
}
