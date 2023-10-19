; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -mtriple=x86_64-apple-macosx10.9.0 -S -o - | FileCheck %s

target datalayout = "f64:64:64-v64:64:64"

define void @test_phi_in_landingpad() personality ptr
; CHECK-LABEL: @test_phi_in_landingpad(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @foo()
; CHECK-NEXT:    to label [[INNER:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    invoke void @foo()
; CHECK-NEXT:    to label [[DONE:%.*]] unwind label [[LPAD]]
; CHECK:       lpad:
; CHECK-NEXT:    [[TMP0:%.*]] = phi <2 x double> [ undef, [[ENTRY:%.*]] ], [ undef, [[INNER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    br label [[DONE]]
; CHECK:       done:
; CHECK-NEXT:    [[TMP2:%.*]] = phi <2 x double> [ undef, [[INNER]] ], [ [[TMP0]], [[LPAD]] ]
; CHECK-NEXT:    ret void
;
  @__gxx_personality_v0 {
entry:
  invoke void @foo()
  to label %inner unwind label %lpad

inner:
  %x0 = fsub double undef, undef
  %y0 = fsub double undef, undef
  invoke void @foo()
  to label %done unwind label %lpad

lpad:
  %x1 = phi double [ undef, %entry ], [ undef, %inner ]
  %y1 = phi double [ undef, %entry ], [ undef, %inner ]
  landingpad { ptr, i32 } catch ptr null
  br label %done

done:
  phi double [ %x0, %inner ], [ %x1, %lpad ]
  phi double [ %y0, %inner ], [ %y1, %lpad ]
  ret void
}

declare void @foo()

declare i32 @__gxx_personality_v0(...)
