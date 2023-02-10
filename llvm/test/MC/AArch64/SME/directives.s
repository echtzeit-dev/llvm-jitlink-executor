// RUN: llvm-mc -triple aarch64 -o - %s 2>&1 | FileCheck %s

.arch_extension sme
smstart
// CHECK: smstart

.arch_extension nosme

.arch_extension sme-f64f64
fmopa za0.d, p0/m, p0/m, z0.d, z0.d
// CHECK: fmopa za0.d, p0/m, p0/m, z0.d, z0.d

.arch_extension nosme-f64f64

.arch_extension sme-i16i64
addha za0.d, p0/m, p0/m, z0.d
// CHECK: addha za0.d, p0/m, p0/m, z0.d

.arch_extension nosme-i16i64

.arch armv9-a+sme
smstart
// CHECK: smstart

.arch armv9-a+nosme

.arch armv9-a+sme-f64f64
fmopa za0.d, p0/m, p0/m, z0.d, z0.d
// CHECK: fmopa za0.d, p0/m, p0/m, z0.d, z0.d

.arch armv9-a+nosme-f64f64

.arch armv9-a+sme-i16i64
addha za0.d, p0/m, p0/m, z0.d
// CHECK: addha za0.d, p0/m, p0/m, z0.d
