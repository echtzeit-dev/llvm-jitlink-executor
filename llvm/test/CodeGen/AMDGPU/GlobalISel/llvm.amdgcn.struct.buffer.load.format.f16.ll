; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=UNPACKED %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=PACKED %s

define amdgpu_ps half @struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  ; PACKED-LABEL: name: struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; PACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call half @llvm.amdgcn.struct.buffer.load.format.f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret half %val
}

define amdgpu_ps <2 x half> @struct_buffer_load_format_v2f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_v2f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XY_gfx80_BOTHEN:%[0-9]+]]:vreg_64 = BUFFER_LOAD_FORMAT_D16_XY_gfx80_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (<2 x s16>), align 1, addrspace 7)
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XY_gfx80_BOTHEN]].sub0
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XY_gfx80_BOTHEN]].sub1
  ; UNPACKED-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 65535
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY7]], [[COPY9]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_1:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY8]], [[COPY10]], implicit $exec
  ; UNPACKED-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; UNPACKED-NEXT:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_1]]
  ; UNPACKED-NEXT:   [[V_LSHLREV_B32_e64_:%[0-9]+]]:vgpr_32 = V_LSHLREV_B32_e64 [[COPY11]], [[V_AND_B32_e64_1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_OR_B32_e64_:%[0-9]+]]:vgpr_32 = V_OR_B32_e64 [[V_AND_B32_e64_]], [[V_LSHLREV_B32_e64_]], implicit $exec
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[V_OR_B32_e64_]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  ; PACKED-LABEL: name: struct_buffer_load_format_v2f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XY_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_XY_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (<2 x s16>), align 1, addrspace 7)
  ; PACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_XY_BOTHEN]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call <2 x half> @llvm.amdgcn.struct.buffer.load.format.v2f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <2 x half> %val
}

; FIXME: Crashes
; define amdgpu_ps <3 x half> @struct_buffer_load_format_v3f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
;   %val = call <3 x half> @llvm.amdgcn.struct.buffer.load.format.v3f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
;   ret <3 x half> %val
; }

define amdgpu_ps <4 x half> @struct_buffer_load_format_v4f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_v4f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN:%[0-9]+]]:vreg_128 = BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s16>), align 1, addrspace 7)
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub0
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub1
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub2
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub3
  ; UNPACKED-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 65535
  ; UNPACKED-NEXT:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY7]], [[COPY11]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY12:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_1:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY8]], [[COPY12]], implicit $exec
  ; UNPACKED-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; UNPACKED-NEXT:   [[COPY13:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_1]]
  ; UNPACKED-NEXT:   [[V_LSHLREV_B32_e64_:%[0-9]+]]:vgpr_32 = V_LSHLREV_B32_e64 [[COPY13]], [[V_AND_B32_e64_1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_OR_B32_e64_:%[0-9]+]]:vgpr_32 = V_OR_B32_e64 [[V_AND_B32_e64_]], [[V_LSHLREV_B32_e64_]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY14:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_2:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY9]], [[COPY14]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY15:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_3:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY10]], [[COPY15]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY16:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_1]]
  ; UNPACKED-NEXT:   [[V_LSHLREV_B32_e64_1:%[0-9]+]]:vgpr_32 = V_LSHLREV_B32_e64 [[COPY16]], [[V_AND_B32_e64_3]], implicit $exec
  ; UNPACKED-NEXT:   [[V_OR_B32_e64_1:%[0-9]+]]:vgpr_32 = V_OR_B32_e64 [[V_AND_B32_e64_2]], [[V_LSHLREV_B32_e64_1]], implicit $exec
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[V_OR_B32_e64_]]
  ; UNPACKED-NEXT:   $vgpr1 = COPY [[V_OR_B32_e64_1]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  ; PACKED-LABEL: name: struct_buffer_load_format_v4f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN:%[0-9]+]]:vreg_64 = BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s16>), align 1, addrspace 7)
  ; PACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN]].sub0
  ; PACKED-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN]].sub1
  ; PACKED-NEXT:   $vgpr0 = COPY [[COPY7]]
  ; PACKED-NEXT:   $vgpr1 = COPY [[COPY8]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %val = call <4 x half> @llvm.amdgcn.struct.buffer.load.format.v4f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <4 x half> %val
}

; Waterfall for rsrc and soffset, copy for voffset
define amdgpu_ps <4 x half> @struct_buffer_load_format_v4f16__vpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset(<4 x i32> %rsrc, i32 inreg %vindex, i32 inreg %voffset, i32 %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_v4f16__vpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   successors: %bb.2(0x80000000)
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY4]]
  ; UNPACKED-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; UNPACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.2:
  ; UNPACKED-NEXT:   successors: %bb.3(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY10:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED-NEXT:   [[COPY11:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; UNPACKED-NEXT:   [[COPY12:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY11]], [[COPY9]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY12]], [[COPY10]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; UNPACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; UNPACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def dead $scc
  ; UNPACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.3:
  ; UNPACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY7]], %subreg.sub0, [[COPY8]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN:%[0-9]+]]:vreg_128 = BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s16>), align 1, addrspace 7)
  ; UNPACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.4:
  ; UNPACKED-NEXT:   successors: %bb.5(0x80000000)
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT: bb.5:
  ; UNPACKED-NEXT:   [[COPY13:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub0
  ; UNPACKED-NEXT:   [[COPY14:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub1
  ; UNPACKED-NEXT:   [[COPY15:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub2
  ; UNPACKED-NEXT:   [[COPY16:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_gfx80_BOTHEN]].sub3
  ; UNPACKED-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 65535
  ; UNPACKED-NEXT:   [[COPY17:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY13]], [[COPY17]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY18:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_1:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY14]], [[COPY18]], implicit $exec
  ; UNPACKED-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; UNPACKED-NEXT:   [[COPY19:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_1]]
  ; UNPACKED-NEXT:   [[V_LSHLREV_B32_e64_:%[0-9]+]]:vgpr_32 = V_LSHLREV_B32_e64 [[COPY19]], [[V_AND_B32_e64_1]], implicit $exec
  ; UNPACKED-NEXT:   [[V_OR_B32_e64_:%[0-9]+]]:vgpr_32 = V_OR_B32_e64 [[V_AND_B32_e64_]], [[V_LSHLREV_B32_e64_]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY20:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_2:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY15]], [[COPY20]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY21:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED-NEXT:   [[V_AND_B32_e64_3:%[0-9]+]]:vgpr_32 = V_AND_B32_e64 [[COPY16]], [[COPY21]], implicit $exec
  ; UNPACKED-NEXT:   [[COPY22:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_1]]
  ; UNPACKED-NEXT:   [[V_LSHLREV_B32_e64_1:%[0-9]+]]:vgpr_32 = V_LSHLREV_B32_e64 [[COPY22]], [[V_AND_B32_e64_3]], implicit $exec
  ; UNPACKED-NEXT:   [[V_OR_B32_e64_1:%[0-9]+]]:vgpr_32 = V_OR_B32_e64 [[V_AND_B32_e64_2]], [[V_LSHLREV_B32_e64_1]], implicit $exec
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[V_OR_B32_e64_]]
  ; UNPACKED-NEXT:   $vgpr1 = COPY [[V_OR_B32_e64_1]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  ; PACKED-LABEL: name: struct_buffer_load_format_v4f16__vpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   successors: %bb.2(0x80000000)
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY4]]
  ; PACKED-NEXT:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; PACKED-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.2:
  ; PACKED-NEXT:   successors: %bb.3(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY1]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY2]], implicit $exec
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY3]], implicit $exec
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED-NEXT:   [[COPY10:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED-NEXT:   [[COPY11:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub0_sub1
  ; PACKED-NEXT:   [[COPY12:%[0-9]+]]:sreg_64 = COPY [[REG_SEQUENCE1]].sub2_sub3
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY11]], [[COPY9]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[COPY12]], [[COPY10]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; PACKED-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; PACKED-NEXT:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[S_AND_B64_]], [[V_CMP_EQ_U32_e64_]], implicit-def dead $scc
  ; PACKED-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.3:
  ; PACKED-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY7]], %subreg.sub0, [[COPY8]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN:%[0-9]+]]:vreg_64 = BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN [[REG_SEQUENCE2]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s16>), align 1, addrspace 7)
  ; PACKED-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.4:
  ; PACKED-NEXT:   successors: %bb.5(0x80000000)
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT: bb.5:
  ; PACKED-NEXT:   [[COPY13:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN]].sub0
  ; PACKED-NEXT:   [[COPY14:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_D16_XYZW_BOTHEN]].sub1
  ; PACKED-NEXT:   $vgpr0 = COPY [[COPY13]]
  ; PACKED-NEXT:   $vgpr1 = COPY [[COPY14]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %val = call <4 x half> @llvm.amdgcn.struct.buffer.load.format.v4f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <4 x half> %val
}

define amdgpu_ps half @struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset_voffsset_add_4095(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset.base, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset_voffsset_add_4095
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 4095, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  ; PACKED-LABEL: name: struct_buffer_load_format_f16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset_voffsset_add_4095
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 4095, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; PACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %voffset = add i32 %voffset.base, 4095
  %val = call half @llvm.amdgcn.struct.buffer.load.format.f16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret half %val
}

define amdgpu_ps half @struct_buffer_load_format_i16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: struct_buffer_load_format_i16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED-NEXT: {{  $}}
  ; UNPACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; UNPACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; UNPACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; UNPACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_gfx80_BOTHEN]]
  ; UNPACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  ; PACKED-LABEL: name: struct_buffer_load_format_i16__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED-NEXT: {{  $}}
  ; PACKED-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; PACKED-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; PACKED-NEXT:   [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_D16_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, implicit $exec :: (dereferenceable load (s16), align 1, addrspace 7)
  ; PACKED-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_D16_X_BOTHEN]]
  ; PACKED-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call i16 @llvm.amdgcn.struct.buffer.load.format.i16(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %fval = bitcast i16 %val to half
  ret half %fval
}

declare half @llvm.amdgcn.struct.buffer.load.format.f16(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <2 x half> @llvm.amdgcn.struct.buffer.load.format.v2f16(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <3 x half> @llvm.amdgcn.struct.buffer.load.format.v3f16(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <4 x half> @llvm.amdgcn.struct.buffer.load.format.v4f16(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare i16 @llvm.amdgcn.struct.buffer.load.format.i16(<4 x i32>, i32, i32, i32, i32 immarg) #0

attributes #0 = { nounwind readonly }
