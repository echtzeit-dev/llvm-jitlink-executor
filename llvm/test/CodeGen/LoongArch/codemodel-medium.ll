; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --code-model=small < %s | \
; RUN:    FileCheck --check-prefix=SMALL %s
; RUN: llc --mtriple=loongarch64 --code-model=medium < %s | \
; RUN:    FileCheck --check-prefix=MEDIUM %s

declare void @llvm.memset.p0.i64(ptr, i8, i64, i1)
declare i32 @callee(i32)

define i32 @call_globaladdress(i32 %a) nounwind {
; SMALL-LABEL: call_globaladdress:
; SMALL:       # %bb.0:
; SMALL-NEXT:    addi.d $sp, $sp, -16
; SMALL-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; SMALL-NEXT:    bl %plt(callee)
; SMALL-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; SMALL-NEXT:    addi.d $sp, $sp, 16
; SMALL-NEXT:    ret
;
; MEDIUM-LABEL: call_globaladdress:
; MEDIUM:       # %bb.0:
; MEDIUM-NEXT:    addi.d $sp, $sp, -16
; MEDIUM-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; MEDIUM-NEXT:    pcalau12i $ra, %pc_hi20(callee)
; MEDIUM-NEXT:    jirl $ra, $ra, %pc_lo12(callee)
; MEDIUM-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; MEDIUM-NEXT:    addi.d $sp, $sp, 16
; MEDIUM-NEXT:    ret
  %1 = call i32 @callee(i32 %a)
  ret i32 %1
}

define void @call_external_sym(ptr %dst) {
; SMALL-LABEL: call_external_sym:
; SMALL:       # %bb.0: # %entry
; SMALL-NEXT:    addi.d $sp, $sp, -16
; SMALL-NEXT:    .cfi_def_cfa_offset 16
; SMALL-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; SMALL-NEXT:    .cfi_offset 1, -8
; SMALL-NEXT:    ori $a2, $zero, 1000
; SMALL-NEXT:    move $a1, $zero
; SMALL-NEXT:    bl %plt(memset)
; SMALL-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; SMALL-NEXT:    addi.d $sp, $sp, 16
; SMALL-NEXT:    ret
;
; MEDIUM-LABEL: call_external_sym:
; MEDIUM:       # %bb.0: # %entry
; MEDIUM-NEXT:    addi.d $sp, $sp, -16
; MEDIUM-NEXT:    .cfi_def_cfa_offset 16
; MEDIUM-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; MEDIUM-NEXT:    .cfi_offset 1, -8
; MEDIUM-NEXT:    ori $a2, $zero, 1000
; MEDIUM-NEXT:    move $a1, $zero
; MEDIUM-NEXT:    pcalau12i $ra, %pc_hi20(memset)
; MEDIUM-NEXT:    jirl $ra, $ra, %pc_lo12(memset)
; MEDIUM-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; MEDIUM-NEXT:    addi.d $sp, $sp, 16
; MEDIUM-NEXT:    ret
entry:
  call void @llvm.memset.p0.i64(ptr %dst, i8 0, i64 1000, i1 false)
  ret void
}

;; Tail call with different codemodel.
declare i32 @callee_tail(i32 %i)
define i32 @caller_tail(i32 %i) nounwind {
; SMALL-LABEL: caller_tail:
; SMALL:       # %bb.0: # %entry
; SMALL-NEXT:    b %plt(callee_tail)
;
; MEDIUM-LABEL: caller_tail:
; MEDIUM:       # %bb.0: # %entry
; MEDIUM-NEXT:    pcalau12i $a1, %pc_hi20(callee_tail)
; MEDIUM-NEXT:    jirl $zero, $a1, %pc_lo12(callee_tail)
entry:
  %r = tail call i32 @callee_tail(i32 %i)
  ret i32 %r
}
