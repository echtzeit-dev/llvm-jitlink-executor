; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi ilp32f -mattr=+zfh < %s \
; RUN:     | FileCheck --check-prefix=RV32IZFH %s
; RUN: llc -mtriple=riscv32 -target-abi ilp32d -mattr=+zfh,+d < %s \
; RUN:     | FileCheck --check-prefix=RV32IDZFH %s
; RUN: llc -mtriple=riscv64 -target-abi lp64f -mattr=+zfh < %s \
; RUN:     | FileCheck --check-prefix=RV64IZFH %s
; RUN: llc -mtriple=riscv64 -target-abi lp64d -mattr=+zfh,+d < %s \
; RUN:     | FileCheck --check-prefix=RV64IDZFH %s

define half @f16_positive_zero(ptr %pf) nounwind {
; RV32IZFH-LABEL: f16_positive_zero:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x fa0, zero
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: f16_positive_zero:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fmv.h.x fa0, zero
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: f16_positive_zero:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x fa0, zero
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: f16_positive_zero:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fmv.h.x fa0, zero
; RV64IDZFH-NEXT:    ret
  ret half 0.0
}

define half @f16_negative_zero(ptr %pf) nounwind {
; RV32IZFH-LABEL: f16_negative_zero:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    lui a0, 1048568
; RV32IZFH-NEXT:    fmv.h.x fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: f16_negative_zero:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    lui a0, 1048568
; RV32IDZFH-NEXT:    fmv.h.x fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: f16_negative_zero:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    lui a0, 1048568
; RV64IZFH-NEXT:    fmv.h.x fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: f16_negative_zero:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    lui a0, 1048568
; RV64IDZFH-NEXT:    fmv.h.x fa0, a0
; RV64IDZFH-NEXT:    ret
  ret half -0.0
}
