; RUN: llc < %s -mtriple=amdgcn-- -mcpu=gfx600 | FileCheck --check-prefixes=NONHSA-SI600 %s
; RUN: llc < %s -mtriple=amdgcn-- -mcpu=gfx601 | FileCheck --check-prefixes=NONHSA-SI601 %s
; RUN: llc < %s -mtriple=amdgcn-- -mcpu=gfx602 | FileCheck --check-prefixes=NONHSA-SI602 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx700 | FileCheck --check-prefixes=HSA,HSA-CI700 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=kaveri | FileCheck --check-prefixes=HSA,HSA-CI700 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx701 | FileCheck --check-prefixes=HSA,HSA-CI701 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=hawaii | FileCheck --check-prefixes=HSA,HSA-CI701 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx702 | FileCheck --check-prefixes=HSA,HSA-CI702 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx703 | FileCheck --check-prefixes=HSA,HSA-CI703 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=kabini | FileCheck --check-prefixes=HSA,HSA-CI703 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=mullins | FileCheck --check-prefixes=HSA,HSA-CI703 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx704 | FileCheck --check-prefixes=HSA,HSA-CI704 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=bonaire | FileCheck --check-prefixes=HSA,HSA-CI704 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx705 | FileCheck --check-prefixes=HSA,HSA-CI705 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx801 | FileCheck --check-prefixes=HSA,HSA-VI801 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=carrizo -mattr=-flat-for-global | FileCheck --check-prefixes=HSA,HSA-VI801 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx802 | FileCheck --check-prefixes=HSA,HSA-VI802 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=iceland -mattr=-flat-for-global | FileCheck --check-prefixes=HSA,HSA-VI802 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=tonga -mattr=-flat-for-global | FileCheck --check-prefixes=HSA,HSA-VI802 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx803 | FileCheck --check-prefixes=HSA,HSA-VI803 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=fiji -mattr=-flat-for-global | FileCheck --check-prefixes=HSA,HSA-VI803 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=polaris10 | FileCheck --check-prefixes=HSA,HSA-VI803 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=polaris11 | FileCheck --check-prefixes=HSA,HSA-VI803 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx805 | FileCheck --check-prefixes=HSA,HSA-VI805 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=tongapro | FileCheck --check-prefixes=HSA,HSA-VI805 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx810 | FileCheck --check-prefixes=HSA,HSA-VI810 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=stoney | FileCheck --check-prefixes=HSA,HSA-VI810 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx900 -mattr=-xnack | FileCheck --check-prefixes=HSA,HSA-GFX900 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx900 | FileCheck --check-prefixes=HSA,HSA-GFX901 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx902 -mattr=-xnack | FileCheck --check-prefixes=HSA,HSA-GFX902 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx902 | FileCheck --check-prefixes=HSA,HSA-GFX903 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx904 -mattr=-xnack | FileCheck --check-prefixes=HSA,HSA-GFX904 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx904 | FileCheck --check-prefixes=HSA,HSA-GFX905 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx906 -mattr=-xnack | FileCheck --check-prefixes=HSA,HSA-GFX906 %s
; RUN: llc < %s -mtriple=amdgcn--amdhsa -mcpu=gfx906 | FileCheck --check-prefixes=HSA,HSA-GFX907 %s

; HSA: .hsa_code_object_version 2,1
; NONHSA-SI600: .amd_amdgpu_isa "amdgcn-unknown-unknown--gfx600"
; NONHSA-SI601: .amd_amdgpu_isa "amdgcn-unknown-unknown--gfx601"
; NONHSA-SI602: .amd_amdgpu_isa "amdgcn-unknown-unknown--gfx602"
; HSA-CI700: .hsa_code_object_isa 7,0,0,"AMD","AMDGPU"
; HSA-CI701: .hsa_code_object_isa 7,0,1,"AMD","AMDGPU"
; HSA-CI702: .hsa_code_object_isa 7,0,2,"AMD","AMDGPU"
; HSA-CI703: .hsa_code_object_isa 7,0,3,"AMD","AMDGPU"
; HSA-CI704: .hsa_code_object_isa 7,0,4,"AMD","AMDGPU"
; HSA-CI705: .hsa_code_object_isa 7,0,5,"AMD","AMDGPU"
; HSA-VI801: .hsa_code_object_isa 8,0,1,"AMD","AMDGPU"
; HSA-VI802: .hsa_code_object_isa 8,0,2,"AMD","AMDGPU"
; HSA-VI803: .hsa_code_object_isa 8,0,3,"AMD","AMDGPU"
; HSA-VI805: .hsa_code_object_isa 8,0,5,"AMD","AMDGPU"
; HSA-VI810: .hsa_code_object_isa 8,1,0,"AMD","AMDGPU"
; HSA-GFX900: .hsa_code_object_isa 9,0,0,"AMD","AMDGPU"
; HSA-GFX901: .hsa_code_object_isa 9,0,1,"AMD","AMDGPU"
; HSA-GFX902: .hsa_code_object_isa 9,0,2,"AMD","AMDGPU"
; HSA-GFX903: .hsa_code_object_isa 9,0,3,"AMD","AMDGPU"
; HSA-GFX904: .hsa_code_object_isa 9,0,4,"AMD","AMDGPU"
; HSA-GFX905: .hsa_code_object_isa 9,0,5,"AMD","AMDGPU"
; HSA-GFX906: .hsa_code_object_isa 9,0,6,"AMD","AMDGPU"
; HSA-GFX907: .hsa_code_object_isa 9,0,7,"AMD","AMDGPU"

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdgpu_code_object_version", i32 200}
