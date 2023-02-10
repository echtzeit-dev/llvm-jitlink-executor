; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefix=WAVE64 %s
; RUN: llc -global-isel -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1031 < %s | FileCheck -check-prefix=WAVE32 %s

; This was mishandling the constant true and false values used as a
; scalar branch condition.

define void @br_false() {
; WAVE64-LABEL: br_false:
; WAVE64:       ; %bb.0: ; %.exit
; WAVE64-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE64-NEXT:  .LBB0_1: ; %bb0
; WAVE64-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE64-NEXT:    s_mov_b32 s4, 1
; WAVE64-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE64-NEXT:    s_cbranch_scc1 .LBB0_1
; WAVE64-NEXT:  ; %bb.2: ; %.exit5
; WAVE64-NEXT:    s_setpc_b64 s[30:31]
;
; WAVE32-LABEL: br_false:
; WAVE32:       ; %bb.0: ; %.exit
; WAVE32-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE32-NEXT:    s_waitcnt_vscnt null, 0x0
; WAVE32-NEXT:  .LBB0_1: ; %bb0
; WAVE32-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE32-NEXT:    s_mov_b32 s4, 1
; WAVE32-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE32-NEXT:    s_cbranch_scc1 .LBB0_1
; WAVE32-NEXT:  ; %bb.2: ; %.exit5
; WAVE32-NEXT:    s_setpc_b64 s[30:31]
.exit:
  br label %bb0

bb0:
  br i1 false, label %.exit5, label %bb0

.exit5:
  ret void
}

define void @br_true() {
; WAVE64-LABEL: br_true:
; WAVE64:       ; %bb.0: ; %.exit
; WAVE64-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE64-NEXT:  .LBB1_1: ; %bb0
; WAVE64-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE64-NEXT:    s_mov_b32 s4, 0
; WAVE64-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE64-NEXT:    s_cbranch_scc1 .LBB1_1
; WAVE64-NEXT:  ; %bb.2: ; %.exit5
; WAVE64-NEXT:    s_setpc_b64 s[30:31]
;
; WAVE32-LABEL: br_true:
; WAVE32:       ; %bb.0: ; %.exit
; WAVE32-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE32-NEXT:    s_waitcnt_vscnt null, 0x0
; WAVE32-NEXT:  .LBB1_1: ; %bb0
; WAVE32-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE32-NEXT:    s_mov_b32 s4, 0
; WAVE32-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE32-NEXT:    s_cbranch_scc1 .LBB1_1
; WAVE32-NEXT:  ; %bb.2: ; %.exit5
; WAVE32-NEXT:    s_setpc_b64 s[30:31]
.exit:
  br label %bb0

bb0:
  br i1 true, label %.exit5, label %bb0

.exit5:
  ret void
}

define void @br_undef() {
; WAVE64-LABEL: br_undef:
; WAVE64:       ; %bb.0: ; %.exit
; WAVE64-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE64-NEXT:  .LBB2_1: ; %bb0
; WAVE64-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE64-NEXT:    ; implicit-def: $sgpr4
; WAVE64-NEXT:    s_and_b32 s4, s4, 1
; WAVE64-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE64-NEXT:    s_cbranch_scc1 .LBB2_1
; WAVE64-NEXT:  ; %bb.2: ; %.exit5
; WAVE64-NEXT:    s_setpc_b64 s[30:31]
;
; WAVE32-LABEL: br_undef:
; WAVE32:       ; %bb.0: ; %.exit
; WAVE32-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE32-NEXT:    s_waitcnt_vscnt null, 0x0
; WAVE32-NEXT:  .LBB2_1: ; %bb0
; WAVE32-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE32-NEXT:    ; implicit-def: $sgpr4
; WAVE32-NEXT:    s_and_b32 s4, s4, 1
; WAVE32-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE32-NEXT:    s_cbranch_scc1 .LBB2_1
; WAVE32-NEXT:  ; %bb.2: ; %.exit5
; WAVE32-NEXT:    s_setpc_b64 s[30:31]
.exit:
  br label %bb0

bb0:
  br i1 undef, label %.exit5, label %bb0

.exit5:
  ret void
}

define void @br_poison() {
; WAVE64-LABEL: br_poison:
; WAVE64:       ; %bb.0: ; %.exit
; WAVE64-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE64-NEXT:  .LBB3_1: ; %bb0
; WAVE64-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE64-NEXT:    ; implicit-def: $sgpr4
; WAVE64-NEXT:    s_and_b32 s4, s4, 1
; WAVE64-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE64-NEXT:    s_cbranch_scc1 .LBB3_1
; WAVE64-NEXT:  ; %bb.2: ; %.exit5
; WAVE64-NEXT:    s_setpc_b64 s[30:31]
;
; WAVE32-LABEL: br_poison:
; WAVE32:       ; %bb.0: ; %.exit
; WAVE32-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; WAVE32-NEXT:    s_waitcnt_vscnt null, 0x0
; WAVE32-NEXT:  .LBB3_1: ; %bb0
; WAVE32-NEXT:    ; =>This Inner Loop Header: Depth=1
; WAVE32-NEXT:    ; implicit-def: $sgpr4
; WAVE32-NEXT:    s_and_b32 s4, s4, 1
; WAVE32-NEXT:    s_cmp_lg_u32 s4, 0
; WAVE32-NEXT:    s_cbranch_scc1 .LBB3_1
; WAVE32-NEXT:  ; %bb.2: ; %.exit5
; WAVE32-NEXT:    s_setpc_b64 s[30:31]
.exit:
  br label %bb0

bb0:
  br i1 poison, label %.exit5, label %bb0

.exit5:
  ret void
}
