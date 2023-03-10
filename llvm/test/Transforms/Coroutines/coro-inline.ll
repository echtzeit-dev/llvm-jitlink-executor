; RUN: opt < %s -passes='always-inline,cgscc(coro-split)' -S | FileCheck %s
; RUN: opt < %s -sample-profile-file=%S/Inputs/sample.text.prof -pgo-kind=pgo-sample-use-pipeline -passes='sample-profile,cgscc(coro-split)' -S | FileCheck %s

; Function Attrs: alwaysinline ssp uwtable
define void @ff() #0 {
entry:
  %id = call token @llvm.coro.id(i32 16, ptr null, ptr null, ptr null)
  %begin = call ptr @llvm.coro.begin(token %id, ptr null)
  ret void
}

; Function Attrs: alwaysinline ssp uwtable
define void @foo() #0 {
entry:
  %id1 = call token @llvm.coro.id(i32 16, ptr null, ptr null, ptr null)
  %begin = call ptr @llvm.coro.begin(token %id1, ptr null)
  call void @ff()
  ret void
}
; CHECK-LABEL: define void @foo()
; CHECK:         call void @ff()


declare token @llvm.coro.id(i32, ptr readnone, ptr nocapture readonly, ptr)
declare ptr @llvm.coro.begin(token, ptr writeonly)

attributes #0 = { alwaysinline ssp uwtable presplitcoroutine "use-sample-profile" }

!llvm.dbg.cu = !{}
!llvm.module.flags = !{!1, !2, !3, !4}

!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"PIC Level", i32 2}
