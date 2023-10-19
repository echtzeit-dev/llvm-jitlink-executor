; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown    | FileCheck %s --check-prefix=CHECK
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx2    | FileCheck %s --check-prefix=CHECK-AVX2

%"class.failing::DataBuffer.2.12.22.41.65.87.96.105.114.123.132.141.186.204.213.222.330.429.438.447.718" = type {
  ptr, %"class.failing::TrackedAllocation.1.11.21.40.64.86.95.104.113.122.131.140.185.203.212.221.329.428.437.446.717", i64
}

%"class.failing::TrackedAllocation.1.11.21.40.64.86.95.104.113.122.131.140.185.203.212.221.329.428.437.446.717" = type <{
  ptr, i64, %"union.failing::RefcountOrTracker.0.10.20.39.63.85.94.103.112.121.130.139.184.202.211.220.328.427.436.445.716", i8, [7 x i8]
}

>
%"union.failing::RefcountOrTracker.0.10.20.39.63.85.94.103.112.121.130.139.184.202.211.220.328.427.436.445.716" = type {
  ptr
}

%"class.failingel::standard_function_call_evaluator_internal::ComputeFnDispatcher.1964.9.19.29.47.71.93.102.111.120.129.138.147.192.210.219.228.336.435.444.453.724" = type {
  %"class.failingel::builtin_registry::(anonymous namespace)::Between.1939.5.15.25.43.67.89.98.107.116.125.134.143.188.206.215.224.332.431.440.449.720", %"class.std::__u::tuple.1961.8.18.28.46.70.92.101.110.119.128.137.146.191.209.218.227.335.434.443.452.723", ptr
}

%"class.failingel::builtin_registry::(anonymous namespace)::Between.1939.5.15.25.43.67.89.98.107.116.125.134.143.188.206.215.224.332.431.440.449.720" = type {
  %"class.absl::int128.4.14.24.42.66.88.97.106.115.124.133.142.187.205.214.223.331.430.439.448.719", %"class.absl::int128.4.14.24.42.66.88.97.106.115.124.133.142.187.205.214.223.331.430.439.448.719"
}

%"class.absl::int128.4.14.24.42.66.88.97.106.115.124.133.142.187.205.214.223.331.430.439.448.719" = type {
  i128
}

%"class.std::__u::tuple.1961.8.18.28.46.70.92.101.110.119.128.137.146.191.209.218.227.335.434.443.452.723" = type {
  %"struct.std::__u::__tuple_impl.1962.7.17.27.45.69.91.100.109.118.127.136.145.190.208.217.226.334.433.442.451.722"
}

%"struct.std::__u::__tuple_impl.1962.7.17.27.45.69.91.100.109.118.127.136.145.190.208.217.226.334.433.442.451.722" = type {
  %"class.std::__u::__tuple_leaf.1963.6.16.26.44.68.90.99.108.117.126.135.144.189.207.216.225.333.432.441.450.721"
}

%"class.std::__u::__tuple_leaf.1963.6.16.26.44.68.90.99.108.117.126.135.144.189.207.216.225.333.432.441.450.721" = type {
  ptr
}

define void @failing(ptr %0, ptr %1) nounwind {
; CHECK-LABEL: failing:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq 8(%rdi), %rax
; CHECK-NEXT:    movq 24(%rsi), %rcx
; CHECK-NEXT:    movq 32(%rsi), %rdx
; CHECK-NEXT:    movdqa {{.*#+}} xmm0 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    movdqa {{.*#+}} xmm1 = [1,1]
; CHECK-NEXT:    movdqa {{.*#+}} xmm2 = [2,2]
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_1: # %vector.ph
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB0_2 Depth 2
; CHECK-NEXT:    xorpd %xmm3, %xmm3
; CHECK-NEXT:    movq $-1024, %rdi # imm = 0xFC00
; CHECK-NEXT:    movdqa %xmm0, %xmm4
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_2: # %vector.body
; CHECK-NEXT:    # Parent Loop BB0_1 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    movdqu 1024(%rdx,%rdi), %xmm5
; CHECK-NEXT:    movdqu 1040(%rdx,%rdi), %xmm6
; CHECK-NEXT:    pshufd {{.*#+}} xmm5 = xmm5[2,3,2,3]
; CHECK-NEXT:    movq %xmm5, %r8
; CHECK-NEXT:    pshufd {{.*#+}} xmm5 = xmm6[2,3,2,3]
; CHECK-NEXT:    movq %xmm5, %r9
; CHECK-NEXT:    cmpq 1040(%rdx,%rdi), %rsi
; CHECK-NEXT:    movq %rcx, %r10
; CHECK-NEXT:    sbbq %r9, %r10
; CHECK-NEXT:    setge %r9b
; CHECK-NEXT:    movzbl %r9b, %r9d
; CHECK-NEXT:    andl $1, %r9d
; CHECK-NEXT:    negq %r9
; CHECK-NEXT:    movq %r9, %xmm5
; CHECK-NEXT:    cmpq 1024(%rdx,%rdi), %rsi
; CHECK-NEXT:    movq %rcx, %r9
; CHECK-NEXT:    sbbq %r8, %r9
; CHECK-NEXT:    setge %r8b
; CHECK-NEXT:    movzbl %r8b, %r8d
; CHECK-NEXT:    andl $1, %r8d
; CHECK-NEXT:    negq %r8
; CHECK-NEXT:    movq %r8, %xmm6
; CHECK-NEXT:    punpcklqdq {{.*#+}} xmm6 = xmm6[0],xmm5[0]
; CHECK-NEXT:    movdqa %xmm1, %xmm5
; CHECK-NEXT:    psllq %xmm4, %xmm5
; CHECK-NEXT:    pshufd {{.*#+}} xmm7 = xmm4[2,3,2,3]
; CHECK-NEXT:    movdqa %xmm1, %xmm8
; CHECK-NEXT:    psllq %xmm7, %xmm8
; CHECK-NEXT:    movsd {{.*#+}} xmm8 = xmm5[0],xmm8[1]
; CHECK-NEXT:    andpd %xmm6, %xmm8
; CHECK-NEXT:    orpd %xmm8, %xmm3
; CHECK-NEXT:    paddq %xmm2, %xmm4
; CHECK-NEXT:    addq $32, %rdi
; CHECK-NEXT:    jne .LBB0_2
; CHECK-NEXT:  # %bb.3: # %middle.block
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    pshufd {{.*#+}} xmm4 = xmm3[2,3,2,3]
; CHECK-NEXT:    por %xmm3, %xmm4
; CHECK-NEXT:    movq %xmm4, (%rax)
; CHECK-NEXT:    jmp .LBB0_1
;
; CHECK-AVX2-LABEL: failing:
; CHECK-AVX2:       # %bb.0:
; CHECK-AVX2-NEXT:    movq 8(%rdi), %rax
; CHECK-AVX2-NEXT:    movq 24(%rsi), %rcx
; CHECK-AVX2-NEXT:    movq 32(%rsi), %rdx
; CHECK-AVX2-NEXT:    vmovdqa {{.*#+}} xmm0 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
; CHECK-AVX2-NEXT:    xorl %esi, %esi
; CHECK-AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = [1,1]
; CHECK-AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = [2,2]
; CHECK-AVX2-NEXT:    .p2align 4, 0x90
; CHECK-AVX2-NEXT:  .LBB0_1: # %vector.ph
; CHECK-AVX2-NEXT:    # =>This Loop Header: Depth=1
; CHECK-AVX2-NEXT:    # Child Loop BB0_2 Depth 2
; CHECK-AVX2-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; CHECK-AVX2-NEXT:    movq $-1024, %rdi # imm = 0xFC00
; CHECK-AVX2-NEXT:    vmovdqa %xmm0, %xmm4
; CHECK-AVX2-NEXT:    .p2align 4, 0x90
; CHECK-AVX2-NEXT:  .LBB0_2: # %vector.body
; CHECK-AVX2-NEXT:    # Parent Loop BB0_1 Depth=1
; CHECK-AVX2-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-AVX2-NEXT:    cmpq 1024(%rdx,%rdi), %rsi
; CHECK-AVX2-NEXT:    movq %rcx, %r8
; CHECK-AVX2-NEXT:    sbbq 1032(%rdx,%rdi), %r8
; CHECK-AVX2-NEXT:    setge %r8b
; CHECK-AVX2-NEXT:    movzbl %r8b, %r8d
; CHECK-AVX2-NEXT:    andl $1, %r8d
; CHECK-AVX2-NEXT:    negq %r8
; CHECK-AVX2-NEXT:    vmovq %r8, %xmm5
; CHECK-AVX2-NEXT:    cmpq 1040(%rdx,%rdi), %rsi
; CHECK-AVX2-NEXT:    movq %rcx, %r8
; CHECK-AVX2-NEXT:    sbbq 1048(%rdx,%rdi), %r8
; CHECK-AVX2-NEXT:    setge %r8b
; CHECK-AVX2-NEXT:    movzbl %r8b, %r8d
; CHECK-AVX2-NEXT:    andl $1, %r8d
; CHECK-AVX2-NEXT:    negq %r8
; CHECK-AVX2-NEXT:    vmovq %r8, %xmm6
; CHECK-AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm5 = xmm5[0],xmm6[0]
; CHECK-AVX2-NEXT:    vpsllvq %xmm4, %xmm1, %xmm6
; CHECK-AVX2-NEXT:    vpand %xmm6, %xmm5, %xmm5
; CHECK-AVX2-NEXT:    vpor %xmm3, %xmm5, %xmm3
; CHECK-AVX2-NEXT:    vpaddq %xmm2, %xmm4, %xmm4
; CHECK-AVX2-NEXT:    addq $32, %rdi
; CHECK-AVX2-NEXT:    jne .LBB0_2
; CHECK-AVX2-NEXT:  # %bb.3: # %middle.block
; CHECK-AVX2-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-AVX2-NEXT:    vpshufd {{.*#+}} xmm4 = xmm3[2,3,2,3]
; CHECK-AVX2-NEXT:    vpor %xmm4, %xmm3, %xmm3
; CHECK-AVX2-NEXT:    vmovq %xmm3, (%rax)
; CHECK-AVX2-NEXT:    jmp .LBB0_1
  %3 = getelementptr inbounds %"class.failing::DataBuffer.2.12.22.41.65.87.96.105.114.123.132.141.186.204.213.222.330.429.438.447.718", ptr %0, i64 0, i32 1
  %4 = load ptr, ptr %3, align 8
  %5 = getelementptr inbounds %"class.failingel::standard_function_call_evaluator_internal::ComputeFnDispatcher.1964.9.19.29.47.71.93.102.111.120.129.138.147.192.210.219.228.336.435.444.453.724", ptr %1, i64 0, i32 1
  %6 = load ptr, ptr %5, align 16
  %7 = getelementptr inbounds i8, ptr %1, i64 24
  %8 = load i64, ptr %7, align 8
  %9 = zext i64 %8 to i128
  %10 = shl nuw i128 %9, 64
  %broadcast.splatinsert = insertelement <2 x i128> poison, i128 %10, i64 0
  %broadcast.splat = shufflevector <2 x i128> %broadcast.splatinsert, <2 x i128> poison, <2 x i32> zeroinitializer
  br label %vector.ph
vector.ph:
  br label %vector.body
vector.body:
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <2 x i64> [ <i64 0, i64 1>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <2 x i64> [ zeroinitializer, %vector.ph ], [ %20, %vector.body ]
  %11 = getelementptr inbounds %"class.absl::int128.4.14.24.42.66.88.97.106.115.124.133.142.187.205.214.223.331.430.439.448.719", ptr %6, i64 %index
  %wide.vec = load <4 x i64>, ptr %11, align 8
  %strided.vec = shufflevector <4 x i64> %wide.vec, <4 x i64> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec1 = shufflevector <4 x i64> %wide.vec, <4 x i64> poison, <2 x i32> <i32 1, i32 3>
  %12 = zext <2 x i64> %strided.vec1 to <2 x i128>
  %13 = shl nuw <2 x i128> %12, <i128 64, i128 64>
  %14 = zext <2 x i64> %strided.vec to <2 x i128>
  %15 = or <2 x i128> %13, %14
  %16 = icmp sle <2 x i128> %15, %broadcast.splat
  %17 = shl nuw <2 x i64> <i64 1, i64 1>, %vec.ind
  %18 = freeze <2 x i1> %16
  %19 = select <2 x i1> %18, <2 x i64> %17, <2 x i64> zeroinitializer
  %20 = or <2 x i64> %19, %vec.phi
  %index.next = add nuw i64 %index, 2
  %vec.ind.next = add <2 x i64> %vec.ind, <i64 2, i64 2>
  %21 = icmp eq i64 %index.next, 64
  br i1 %21, label %middle.block, label %vector.body
middle.block:  ; preds = %vector.body
  %22 = tail call i64 @llvm.vector.reduce.or.v2i64(<2 x i64> %20)
  store i64 %22, ptr %4, align 8
  br label %vector.ph
}

declare i64 @llvm.vector.reduce.or.v2i64(<2 x i64>) #1
