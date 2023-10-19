; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx908 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX908_GFX11 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX908_GFX11 %s

define amdgpu_ps void @buffer_atomic_fadd_f32_offset_no_rtn(float %val, <4 x i32> inreg %rsrc, i32 inreg %soffset) {
  ; GFX908_GFX11-LABEL: name: buffer_atomic_fadd_f32_offset_no_rtn
  ; GFX908_GFX11: bb.1 (%ir-block.0):
  ; GFX908_GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0
  ; GFX908_GFX11-NEXT: {{  $}}
  ; GFX908_GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908_GFX11-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908_GFX11-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908_GFX11-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX908_GFX11-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX908_GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX908_GFX11-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX908_GFX11-NEXT:   BUFFER_ATOMIC_ADD_F32_OFFSET [[COPY]], [[REG_SEQUENCE]], [[COPY5]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX908_GFX11-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_f32_offset_no_rtn
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   BUFFER_ATOMIC_ADD_F32_OFFSET [[COPY]], [[REG_SEQUENCE]], [[COPY5]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fadd.f32(float %val, <4 x i32> %rsrc, i32 0, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @buffer_atomic_fadd_f32_offen_no_rtn(float %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; GFX908_GFX11-LABEL: name: buffer_atomic_fadd_f32_offen_no_rtn
  ; GFX908_GFX11: bb.1 (%ir-block.0):
  ; GFX908_GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1
  ; GFX908_GFX11-NEXT: {{  $}}
  ; GFX908_GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908_GFX11-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908_GFX11-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908_GFX11-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX908_GFX11-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX908_GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX908_GFX11-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX908_GFX11-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX908_GFX11-NEXT:   BUFFER_ATOMIC_ADD_F32_OFFEN [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX908_GFX11-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_f32_offen_no_rtn
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   BUFFER_ATOMIC_ADD_F32_OFFEN [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call float @llvm.amdgcn.raw.buffer.atomic.fadd.f32(float %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @buffer_atomic_fadd_f32_idxen_no_rtn(float %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 inreg %soffset) {
  ; GFX908_GFX11-LABEL: name: buffer_atomic_fadd_f32_idxen_no_rtn
  ; GFX908_GFX11: bb.1 (%ir-block.0):
  ; GFX908_GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1
  ; GFX908_GFX11-NEXT: {{  $}}
  ; GFX908_GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908_GFX11-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908_GFX11-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908_GFX11-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX908_GFX11-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX908_GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX908_GFX11-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX908_GFX11-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX908_GFX11-NEXT:   BUFFER_ATOMIC_ADD_F32_IDXEN [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX908_GFX11-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_f32_idxen_no_rtn
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   BUFFER_ATOMIC_ADD_F32_IDXEN [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call float @llvm.amdgcn.struct.buffer.atomic.fadd.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @buffer_atomic_fadd_f32_bothen_no_rtn(float %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; GFX908_GFX11-LABEL: name: buffer_atomic_fadd_f32_bothen_no_rtn
  ; GFX908_GFX11: bb.1 (%ir-block.0):
  ; GFX908_GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1, $vgpr2
  ; GFX908_GFX11-NEXT: {{  $}}
  ; GFX908_GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908_GFX11-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908_GFX11-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908_GFX11-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX908_GFX11-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX908_GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX908_GFX11-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX908_GFX11-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX908_GFX11-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX908_GFX11-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; GFX908_GFX11-NEXT:   BUFFER_ATOMIC_ADD_F32_BOTHEN [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 2, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX908_GFX11-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_f32_bothen_no_rtn
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4, $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY6]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   BUFFER_ATOMIC_ADD_F32_BOTHEN [[COPY]], [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY7]], 0, 2, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call float @llvm.amdgcn.struct.buffer.atomic.fadd.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 2)
  ret void
}

declare float @llvm.amdgcn.raw.buffer.atomic.fadd.f32(float, <4 x i32>, i32, i32, i32 immarg)
declare float @llvm.amdgcn.struct.buffer.atomic.fadd.f32(float, <4 x i32>, i32, i32, i32, i32 immarg)
