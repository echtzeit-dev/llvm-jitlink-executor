; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -passes=slp-vectorizer -S | FileCheck %s
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -passes=slp-vectorizer -S | FileCheck %s
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -passes=slp-vectorizer -S | FileCheck %s

%struct.ray = type { %struct.vec3, %struct.vec3 }
%struct.vec3 = type { double, double, double }
%struct.sphere = type { %struct.vec3, double, %struct.material, ptr }
%struct.material = type { %struct.vec3, double, double }

define i32 @ray_sphere(ptr nocapture noundef readonly %sph, ptr nocapture noundef readonly byval(%struct.ray) align 8 %ray, ptr nocapture noundef readnone %sp) {
; CHECK-LABEL: @ray_sphere(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIR:%.*]] = getelementptr inbounds [[STRUCT_RAY:%.*]], ptr [[RAY:%.*]], i64 0, i32 1
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[DIR]], align 8
; CHECK-NEXT:    [[Y:%.*]] = getelementptr inbounds [[STRUCT_RAY]], ptr [[RAY]], i64 0, i32 1, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = load double, ptr [[Y]], align 8
; CHECK-NEXT:    [[MUL6:%.*]] = fmul double [[TMP1]], [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP0]], double [[TMP0]], double [[MUL6]])
; CHECK-NEXT:    [[Z:%.*]] = getelementptr inbounds [[STRUCT_RAY]], ptr [[RAY]], i64 0, i32 1, i32 2
; CHECK-NEXT:    [[TMP3:%.*]] = load double, ptr [[Z]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP3]], double [[TMP3]], double [[TMP2]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[TMP0]], 2.000000e+00
; CHECK-NEXT:    [[TMP5:%.*]] = load double, ptr [[RAY]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = load double, ptr [[SPH:%.*]], align 8
; CHECK-NEXT:    [[SUB:%.*]] = fsub double [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[MUL17:%.*]] = fmul double [[TMP1]], 2.000000e+00
; CHECK-NEXT:    [[Y19:%.*]] = getelementptr inbounds [[STRUCT_VEC3:%.*]], ptr [[RAY]], i64 0, i32 1
; CHECK-NEXT:    [[TMP7:%.*]] = load double, ptr [[Y19]], align 8
; CHECK-NEXT:    [[Y21:%.*]] = getelementptr inbounds [[STRUCT_VEC3]], ptr [[SPH]], i64 0, i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = load double, ptr [[Y21]], align 8
; CHECK-NEXT:    [[SUB22:%.*]] = fsub double [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[MUL23:%.*]] = fmul double [[MUL17]], [[SUB22]]
; CHECK-NEXT:    [[TMP9:%.*]] = tail call double @llvm.fmuladd.f64(double [[MUL]], double [[SUB]], double [[MUL23]])
; CHECK-NEXT:    [[MUL26:%.*]] = fmul double [[TMP3]], 2.000000e+00
; CHECK-NEXT:    [[Z28:%.*]] = getelementptr inbounds [[STRUCT_VEC3]], ptr [[RAY]], i64 0, i32 2
; CHECK-NEXT:    [[TMP10:%.*]] = load double, ptr [[Z28]], align 8
; CHECK-NEXT:    [[Z30:%.*]] = getelementptr inbounds [[STRUCT_VEC3]], ptr [[SPH]], i64 0, i32 2
; CHECK-NEXT:    [[TMP11:%.*]] = load double, ptr [[Z30]], align 8
; CHECK-NEXT:    [[SUB31:%.*]] = fsub double [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[TMP12:%.*]] = tail call double @llvm.fmuladd.f64(double [[MUL26]], double [[SUB31]], double [[TMP9]])
; CHECK-NEXT:    [[MUL42:%.*]] = fmul double [[TMP8]], [[TMP8]]
; CHECK-NEXT:    [[TMP13:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP6]], double [[TMP6]], double [[MUL42]])
; CHECK-NEXT:    [[TMP14:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP11]], double [[TMP11]], double [[TMP13]])
; CHECK-NEXT:    [[TMP15:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP5]], double [[TMP5]], double [[TMP14]])
; CHECK-NEXT:    [[TMP16:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP7]], double [[TMP7]], double [[TMP15]])
; CHECK-NEXT:    [[TMP17:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP10]], double [[TMP10]], double [[TMP16]])
; CHECK-NEXT:    [[FNEG:%.*]] = fneg double [[TMP6]]
; CHECK-NEXT:    [[TMP18:%.*]] = fneg double [[TMP8]]
; CHECK-NEXT:    [[NEG:%.*]] = fmul double [[TMP7]], [[TMP18]]
; CHECK-NEXT:    [[TMP19:%.*]] = tail call double @llvm.fmuladd.f64(double [[FNEG]], double [[TMP5]], double [[NEG]])
; CHECK-NEXT:    [[NEG78:%.*]] = fneg double [[TMP11]]
; CHECK-NEXT:    [[TMP20:%.*]] = tail call double @llvm.fmuladd.f64(double [[NEG78]], double [[TMP10]], double [[TMP19]])
; CHECK-NEXT:    [[TMP21:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP20]], double 2.000000e+00, double [[TMP17]])
; CHECK-NEXT:    [[RAD:%.*]] = getelementptr inbounds [[STRUCT_SPHERE:%.*]], ptr [[SPH]], i64 0, i32 1
; CHECK-NEXT:    [[TMP22:%.*]] = load double, ptr [[RAD]], align 8
; CHECK-NEXT:    [[NEG82:%.*]] = fneg double [[TMP22]]
; CHECK-NEXT:    [[TMP23:%.*]] = tail call double @llvm.fmuladd.f64(double [[NEG82]], double [[TMP22]], double [[TMP21]])
; CHECK-NEXT:    [[TMP24:%.*]] = fmul double [[TMP4]], -4.000000e+00
; CHECK-NEXT:    [[NEG86:%.*]] = fmul double [[TMP24]], [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = tail call double @llvm.fmuladd.f64(double [[TMP12]], double [[TMP12]], double [[NEG86]])
; CHECK-NEXT:    [[CMP:%.*]] = fcmp olt double [[TMP25]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP]], label [[CLEANUP:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @sqrt(double noundef [[TMP25]])
; CHECK-NEXT:    [[FNEG87:%.*]] = fneg double [[TMP12]]
; CHECK-NEXT:    [[MUL88:%.*]] = fmul double [[TMP4]], 2.000000e+00
; CHECK-NEXT:    [[TMP26:%.*]] = insertelement <2 x double> poison, double [[FNEG87]], i32 0
; CHECK-NEXT:    [[TMP27:%.*]] = insertelement <2 x double> [[TMP26]], double [[CALL]], i32 1
; CHECK-NEXT:    [[TMP28:%.*]] = shufflevector <2 x double> [[TMP27]], <2 x double> poison, <2 x i32> <i32 1, i32 undef>
; CHECK-NEXT:    [[TMP29:%.*]] = insertelement <2 x double> [[TMP28]], double [[TMP12]], i32 1
; CHECK-NEXT:    [[TMP30:%.*]] = fsub <2 x double> [[TMP27]], [[TMP29]]
; CHECK-NEXT:    [[TMP31:%.*]] = insertelement <2 x double> poison, double [[MUL88]], i32 0
; CHECK-NEXT:    [[TMP32:%.*]] = shufflevector <2 x double> [[TMP31]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP33:%.*]] = fdiv <2 x double> [[TMP30]], [[TMP32]]
; CHECK-NEXT:    [[TMP34:%.*]] = extractelement <2 x double> [[TMP33]], i32 1
; CHECK-NEXT:    [[CMP93:%.*]] = fcmp olt double [[TMP34]], 0x3EB0C6F7A0B5ED8D
; CHECK-NEXT:    [[TMP35:%.*]] = extractelement <2 x double> [[TMP33]], i32 0
; CHECK-NEXT:    [[CMP94:%.*]] = fcmp olt double [[TMP35]], 0x3EB0C6F7A0B5ED8D
; CHECK-NEXT:    [[OR_COND:%.*]] = select i1 [[CMP93]], i1 [[CMP94]], i1 false
; CHECK-NEXT:    br i1 [[OR_COND]], label [[CLEANUP]], label [[LOR_LHS_FALSE:%.*]]
; CHECK:       lor.lhs.false:
; CHECK-NEXT:    [[TMP36:%.*]] = fcmp ule <2 x double> [[TMP33]], <double 1.000000e+00, double 1.000000e+00>
; CHECK-NEXT:    [[TMP37:%.*]] = extractelement <2 x i1> [[TMP36]], i32 0
; CHECK-NEXT:    [[TMP38:%.*]] = extractelement <2 x i1> [[TMP36]], i32 1
; CHECK-NEXT:    [[OR_COND106:%.*]] = select i1 [[TMP38]], i1 true, i1 [[TMP37]]
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = zext i1 [[OR_COND106]] to i32
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 0, [[IF_END]] ], [ [[SPEC_SELECT]], [[LOR_LHS_FALSE]] ]
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  %dir = getelementptr inbounds %struct.ray, ptr %ray, i64 0, i32 1
  %0 = load double, ptr %dir, align 8
  %y = getelementptr inbounds %struct.ray, ptr %ray, i64 0, i32 1, i32 1
  %1 = load double, ptr %y, align 8
  %mul6 = fmul double %1, %1
  %2 = tail call double @llvm.fmuladd.f64(double %0, double %0, double %mul6)
  %z = getelementptr inbounds %struct.ray, ptr %ray, i64 0, i32 1, i32 2
  %3 = load double, ptr %z, align 8
  %4 = tail call double @llvm.fmuladd.f64(double %3, double %3, double %2)
  %mul = fmul double %0, 2.000000e+00
  %5 = load double, ptr %ray, align 8
  %6 = load double, ptr %sph, align 8
  %sub = fsub double %5, %6
  %mul17 = fmul double %1, 2.000000e+00
  %y19 = getelementptr inbounds %struct.vec3, ptr %ray, i64 0, i32 1
  %7 = load double, ptr %y19, align 8
  %y21 = getelementptr inbounds %struct.vec3, ptr %sph, i64 0, i32 1
  %8 = load double, ptr %y21, align 8
  %sub22 = fsub double %7, %8
  %mul23 = fmul double %mul17, %sub22
  %9 = tail call double @llvm.fmuladd.f64(double %mul, double %sub, double %mul23)
  %mul26 = fmul double %3, 2.000000e+00
  %z28 = getelementptr inbounds %struct.vec3, ptr %ray, i64 0, i32 2
  %10 = load double, ptr %z28, align 8
  %z30 = getelementptr inbounds %struct.vec3, ptr %sph, i64 0, i32 2
  %11 = load double, ptr %z30, align 8
  %sub31 = fsub double %10, %11
  %12 = tail call double @llvm.fmuladd.f64(double %mul26, double %sub31, double %9)
  %mul42 = fmul double %8, %8
  %13 = tail call double @llvm.fmuladd.f64(double %6, double %6, double %mul42)
  %14 = tail call double @llvm.fmuladd.f64(double %11, double %11, double %13)
  %15 = tail call double @llvm.fmuladd.f64(double %5, double %5, double %14)
  %16 = tail call double @llvm.fmuladd.f64(double %7, double %7, double %15)
  %17 = tail call double @llvm.fmuladd.f64(double %10, double %10, double %16)
  %fneg = fneg double %6
  %18 = fneg double %8
  %neg = fmul double %7, %18
  %19 = tail call double @llvm.fmuladd.f64(double %fneg, double %5, double %neg)
  %neg78 = fneg double %11
  %20 = tail call double @llvm.fmuladd.f64(double %neg78, double %10, double %19)
  %21 = tail call double @llvm.fmuladd.f64(double %20, double 2.000000e+00, double %17)
  %rad = getelementptr inbounds %struct.sphere, ptr %sph, i64 0, i32 1
  %22 = load double, ptr %rad, align 8
  %neg82 = fneg double %22
  %23 = tail call double @llvm.fmuladd.f64(double %neg82, double %22, double %21)
  %24 = fmul double %4, -4.000000e+00
  %neg86 = fmul double %24, %23
  %25 = tail call double @llvm.fmuladd.f64(double %12, double %12, double %neg86)
  %cmp = fcmp olt double %25, 0.000000e+00
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %call = tail call double @sqrt(double noundef %25) #3
  %fneg87 = fneg double %12
  %add = fsub double %call, %12
  %mul88 = fmul double %4, 2.000000e+00
  %div = fdiv double %add, %mul88
  %sub90 = fsub double %fneg87, %call
  %div92 = fdiv double %sub90, %mul88
  %cmp93 = fcmp olt double %div, 0x3EB0C6F7A0B5ED8D
  %cmp94 = fcmp olt double %div92, 0x3EB0C6F7A0B5ED8D
  %or.cond = select i1 %cmp93, i1 %cmp94, i1 false
  br i1 %or.cond, label %cleanup, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %cmp95 = fcmp ule double %div, 1.000000e+00
  %cmp97 = fcmp ule double %div92, 1.000000e+00
  %or.cond106 = select i1 %cmp95, i1 true, i1 %cmp97
  %spec.select = zext i1 %or.cond106 to i32
  br label %cleanup

cleanup:                                          ; preds = %lor.lhs.false, %if.end, %entry
  %retval.0 = phi i32 [ 0, %entry ], [ 0, %if.end ], [ %spec.select, %lor.lhs.false ]
  ret i32 %retval.0
}
declare double @sqrt(double)
declare double @llvm.fmuladd.f64(double, double, double)
