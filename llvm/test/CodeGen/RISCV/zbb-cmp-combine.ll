; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -mtriple=riscv64 -mattr=+zbb -O3 < %s \
; RUN:  | FileCheck %s --check-prefixes=CHECK,CHECK-RV64I
; RUN: llc  -mtriple=riscv64 -mattr=+zbb,+f -target-abi=lp64f -O3 < %s \
; RUN:  | FileCheck %s --check-prefixes=CHECK,CHECK-RV64IF
; Tests aimed to check optimization which combines
; two comparison operations and logic operation into
; one select(min/max) operation and one comparison
; operaion.

; 4 patterns below will be converted to umin+less.
define i1 @ulo(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ulo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %a, %c
  %l1 = icmp ult i64 %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ulo_swap1(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ulo_swap1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %c, %a
  %l1 = icmp ult i64 %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ulo_swap2(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ulo_swap2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %a, %c
  %l1 = icmp ugt i64 %c, %b
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ulo_swap12(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ulo_swap12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %c, %a
  %l1 = icmp ugt i64 %c, %b
  %res = or i1 %l0, %l1
  ret i1 %res
}

; 4 patterns below will be converted to umax+less.
define i1 @ula(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ula:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %a, %c
  %l1 = icmp ult i64 %b, %c
  %res = and i1 %l0, %l1
  ret i1 %res
}

define i1 @ula_swap1(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ula_swap1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %c, %a
  %l1 = icmp ult i64 %b, %c
  %res = and i1 %l0, %l1
  ret i1 %res
}

define i1 @ula_swap2(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ula_swap2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %a, %c
  %l1 = icmp ugt i64 %c, %b
  %res = and i1 %l0, %l1
  ret i1 %res
}

define i1 @ula_swap12(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ula_swap12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %c, %a
  %l1 = icmp ugt i64 %c, %b
  %res = and i1 %l0, %l1
  ret i1 %res
}

; 4 patterns below will be converted to umax+greater
; (greater will be converted to setult somehow)
define i1 @ugo(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ugo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %a, %c
  %l1 = icmp ugt i64 %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ugo_swap1(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ugo_swap1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %c, %a
  %l1 = icmp ugt i64 %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ugo_swap2(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ugo_swap2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %a, %c
  %l1 = icmp ult i64 %c, %b
  %res = or i1 %l0, %l1
  ret i1 %res
}

define i1 @ugo_swap12(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ugo_swap12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    maxu a1, a1, a2
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %c, %a
  %l1 = icmp ult i64 %c, %b
  %res = or i1 %l0, %l1
  ret i1 %res
}

; Pattern below will be converted to umin+greater or equal
; (greater will be converted to setult somehow)
define i1 @ugea(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: ugea:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a1, a0
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    ret
  %l0 = icmp uge i64 %a, %c
  %l1 = icmp uge i64 %b, %c
  %res = and i1 %l0, %l1
  ret i1 %res
}

; Pattern below will be converted to umin+greater
; (greater will be converted to setult somehow)
define i1 @uga(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: uga:
; CHECK:       # %bb.0:
; CHECK-NEXT:    minu a1, a1, a2
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %a, %c
  %l1 = icmp ugt i64 %b, %c
  %res = and i1 %l0, %l1
  ret i1 %res
}

; Patterns below will be converted to smax+less.
; Sign check.
define i1 @sla(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: sla:
; CHECK:       # %bb.0:
; CHECK-NEXT:    max a1, a1, a2
; CHECK-NEXT:    slt a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp slt i64 %a, %c
  %l1 = icmp slt i64 %b, %c
  %res = and i1 %l0, %l1
  ret i1 %res
}

; Negative test
; Float check.
define i1 @flo(float %c, float %a, float %b) {
; CHECK-RV64I-LABEL: flo:
; CHECK-RV64I:       # %bb.0:
; CHECK-RV64I-NEXT:    addi sp, sp, -32
; CHECK-RV64I-NEXT:    .cfi_def_cfa_offset 32
; CHECK-RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; CHECK-RV64I-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; CHECK-RV64I-NEXT:    .cfi_offset ra, -8
; CHECK-RV64I-NEXT:    .cfi_offset s0, -16
; CHECK-RV64I-NEXT:    .cfi_offset s1, -24
; CHECK-RV64I-NEXT:    .cfi_offset s2, -32
; CHECK-RV64I-NEXT:    mv s0, a2
; CHECK-RV64I-NEXT:    mv s1, a0
; CHECK-RV64I-NEXT:    mv a0, a1
; CHECK-RV64I-NEXT:    mv a1, s1
; CHECK-RV64I-NEXT:    call __gesf2@plt
; CHECK-RV64I-NEXT:    mv s2, a0
; CHECK-RV64I-NEXT:    mv a0, s0
; CHECK-RV64I-NEXT:    mv a1, s1
; CHECK-RV64I-NEXT:    call __gesf2@plt
; CHECK-RV64I-NEXT:    or a0, s2, a0
; CHECK-RV64I-NEXT:    slti a0, a0, 0
; CHECK-RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; CHECK-RV64I-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; CHECK-RV64I-NEXT:    addi sp, sp, 32
; CHECK-RV64I-NEXT:    ret
;
; CHECK-RV64IF-LABEL: flo:
; CHECK-RV64IF:       # %bb.0:
; CHECK-RV64IF-NEXT:    fle.s a0, fa0, fa1
; CHECK-RV64IF-NEXT:    fle.s a1, fa0, fa2
; CHECK-RV64IF-NEXT:    and a0, a0, a1
; CHECK-RV64IF-NEXT:    xori a0, a0, 1
; CHECK-RV64IF-NEXT:    ret
  %l0 = fcmp ult float %a, %c
  %l1 = fcmp ult float %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

; Negative test
; Double check.
define i1 @dlo(double %c, double %a, double %b) {
; CHECK-LABEL: dlo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -8
; CHECK-NEXT:    .cfi_offset s0, -16
; CHECK-NEXT:    .cfi_offset s1, -24
; CHECK-NEXT:    .cfi_offset s2, -32
; CHECK-NEXT:    mv s0, a2
; CHECK-NEXT:    mv s1, a0
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:    mv a1, s1
; CHECK-NEXT:    call __gedf2@plt
; CHECK-NEXT:    mv s2, a0
; CHECK-NEXT:    mv a0, s0
; CHECK-NEXT:    mv a1, s1
; CHECK-NEXT:    call __gedf2@plt
; CHECK-NEXT:    or a0, s2, a0
; CHECK-NEXT:    slti a0, a0, 0
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %l0 = fcmp ult double %a, %c
  %l1 = fcmp ult double %b, %c
  %res = or i1 %l0, %l1
  ret i1 %res
}

; Negative test
; More than one user
define i1 @multi_user(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: multi_user:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a1, a1, a0
; CHECK-NEXT:    sltu a0, a2, a0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ugt i64 %c, %a
  %l1 = icmp ult i64 %b, %c
  %res = or i1 %l0, %l1

  %out = and i1 %l0, %res
  ret i1 %out
}

; Negative test
; No same comparations
define i1 @no_same_ops(i64 %c, i64 %a, i64 %b) {
; CHECK-LABEL: no_same_ops:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a1, a0, a1
; CHECK-NEXT:    sltu a0, a2, a0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %l0 = icmp ult i64 %c, %a
  %l1 = icmp ugt i64 %c, %b
  %res = or i1 %l0, %l1
  ret i1 %res
}

