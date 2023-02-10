//===- CoverageMapping.h - Code coverage mapping support --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Code coverage mapping data is generated by clang and read by
// llvm-cov to show code coverage statistics for a file.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_PROFILEDATA_COVERAGE_COVERAGEMAPPING_H
#define LLVM_PROFILEDATA_COVERAGE_COVERAGEMAPPING_H

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/Hashing.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/iterator.h"
#include "llvm/ADT/iterator_range.h"
#include "llvm/Object/BuildID.h"
#include "llvm/ProfileData/InstrProf.h"
#include "llvm/Support/Alignment.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Endian.h"
#include "llvm/Support/Error.h"
#include "llvm/Support/raw_ostream.h"
#include <cassert>
#include <cstdint>
#include <iterator>
#include <memory>
#include <string>
#include <system_error>
#include <tuple>
#include <utility>
#include <vector>

namespace llvm {

class IndexedInstrProfReader;

namespace object {
class BuildIDFetcher;
} // namespace object

namespace vfs {
class FileSystem;
} // namespace vfs

namespace coverage {

class CoverageMappingReader;
struct CoverageMappingRecord;

enum class coveragemap_error {
  success = 0,
  eof,
  no_data_found,
  unsupported_version,
  truncated,
  malformed,
  decompression_failed,
  invalid_or_missing_arch_specifier
};

const std::error_category &coveragemap_category();

inline std::error_code make_error_code(coveragemap_error E) {
  return std::error_code(static_cast<int>(E), coveragemap_category());
}

class CoverageMapError : public ErrorInfo<CoverageMapError> {
public:
  CoverageMapError(coveragemap_error Err) : Err(Err) {
    assert(Err != coveragemap_error::success && "Not an error");
  }

  std::string message() const override;

  void log(raw_ostream &OS) const override { OS << message(); }

  std::error_code convertToErrorCode() const override {
    return make_error_code(Err);
  }

  coveragemap_error get() const { return Err; }

  static char ID;

private:
  coveragemap_error Err;
};

/// A Counter is an abstract value that describes how to compute the
/// execution count for a region of code using the collected profile count data.
struct Counter {
  /// The CounterExpression kind (Add or Subtract) is encoded in bit 0 next to
  /// the CounterKind. This means CounterKind has to leave bit 0 free.
  enum CounterKind { Zero, CounterValueReference, Expression };
  static const unsigned EncodingTagBits = 2;
  static const unsigned EncodingTagMask = 0x3;
  static const unsigned EncodingCounterTagAndExpansionRegionTagBits =
      EncodingTagBits + 1;

private:
  CounterKind Kind = Zero;
  unsigned ID = 0;

  Counter(CounterKind Kind, unsigned ID) : Kind(Kind), ID(ID) {}

public:
  Counter() = default;

  CounterKind getKind() const { return Kind; }

  bool isZero() const { return Kind == Zero; }

  bool isExpression() const { return Kind == Expression; }

  unsigned getCounterID() const { return ID; }

  unsigned getExpressionID() const { return ID; }

  friend bool operator==(const Counter &LHS, const Counter &RHS) {
    return LHS.Kind == RHS.Kind && LHS.ID == RHS.ID;
  }

  friend bool operator!=(const Counter &LHS, const Counter &RHS) {
    return !(LHS == RHS);
  }

  friend bool operator<(const Counter &LHS, const Counter &RHS) {
    return std::tie(LHS.Kind, LHS.ID) < std::tie(RHS.Kind, RHS.ID);
  }

  /// Return the counter that represents the number zero.
  static Counter getZero() { return Counter(); }

  /// Return the counter that corresponds to a specific profile counter.
  static Counter getCounter(unsigned CounterId) {
    return Counter(CounterValueReference, CounterId);
  }

  /// Return the counter that corresponds to a specific addition counter
  /// expression.
  static Counter getExpression(unsigned ExpressionId) {
    return Counter(Expression, ExpressionId);
  }
};

/// A Counter expression is a value that represents an arithmetic operation
/// with two counters.
struct CounterExpression {
  enum ExprKind { Subtract, Add };
  ExprKind Kind;
  Counter LHS, RHS;

  CounterExpression(ExprKind Kind, Counter LHS, Counter RHS)
      : Kind(Kind), LHS(LHS), RHS(RHS) {}
};

/// A Counter expression builder is used to construct the counter expressions.
/// It avoids unnecessary duplication and simplifies algebraic expressions.
class CounterExpressionBuilder {
  /// A list of all the counter expressions
  std::vector<CounterExpression> Expressions;

  /// A lookup table for the index of a given expression.
  DenseMap<CounterExpression, unsigned> ExpressionIndices;

  /// Return the counter which corresponds to the given expression.
  ///
  /// If the given expression is already stored in the builder, a counter
  /// that references that expression is returned. Otherwise, the given
  /// expression is added to the builder's collection of expressions.
  Counter get(const CounterExpression &E);

  /// Represents a term in a counter expression tree.
  struct Term {
    unsigned CounterID;
    int Factor;

    Term(unsigned CounterID, int Factor)
        : CounterID(CounterID), Factor(Factor) {}
  };

  /// Gather the terms of the expression tree for processing.
  ///
  /// This collects each addition and subtraction referenced by the counter into
  /// a sequence that can be sorted and combined to build a simplified counter
  /// expression.
  void extractTerms(Counter C, int Sign, SmallVectorImpl<Term> &Terms);

  /// Simplifies the given expression tree
  /// by getting rid of algebraically redundant operations.
  Counter simplify(Counter ExpressionTree);

public:
  ArrayRef<CounterExpression> getExpressions() const { return Expressions; }

  /// Return a counter that represents the expression that adds LHS and RHS.
  Counter add(Counter LHS, Counter RHS, bool Simplify = true);

  /// Return a counter that represents the expression that subtracts RHS from
  /// LHS.
  Counter subtract(Counter LHS, Counter RHS, bool Simplify = true);
};

using LineColPair = std::pair<unsigned, unsigned>;

/// A Counter mapping region associates a source range with a specific counter.
struct CounterMappingRegion {
  enum RegionKind {
    /// A CodeRegion associates some code with a counter
    CodeRegion,

    /// An ExpansionRegion represents a file expansion region that associates
    /// a source range with the expansion of a virtual source file, such as
    /// for a macro instantiation or #include file.
    ExpansionRegion,

    /// A SkippedRegion represents a source range with code that was skipped
    /// by a preprocessor or similar means.
    SkippedRegion,

    /// A GapRegion is like a CodeRegion, but its count is only set as the
    /// line execution count when its the only region in the line.
    GapRegion,

    /// A BranchRegion represents leaf-level boolean expressions and is
    /// associated with two counters, each representing the number of times the
    /// expression evaluates to true or false.
    BranchRegion
  };

  /// Primary Counter that is also used for Branch Regions (TrueCount).
  Counter Count;

  /// Secondary Counter used for Branch Regions (FalseCount).
  Counter FalseCount;

  unsigned FileID, ExpandedFileID;
  unsigned LineStart, ColumnStart, LineEnd, ColumnEnd;
  RegionKind Kind;

  CounterMappingRegion(Counter Count, unsigned FileID, unsigned ExpandedFileID,
                       unsigned LineStart, unsigned ColumnStart,
                       unsigned LineEnd, unsigned ColumnEnd, RegionKind Kind)
      : Count(Count), FileID(FileID), ExpandedFileID(ExpandedFileID),
        LineStart(LineStart), ColumnStart(ColumnStart), LineEnd(LineEnd),
        ColumnEnd(ColumnEnd), Kind(Kind) {}

  CounterMappingRegion(Counter Count, Counter FalseCount, unsigned FileID,
                       unsigned ExpandedFileID, unsigned LineStart,
                       unsigned ColumnStart, unsigned LineEnd,
                       unsigned ColumnEnd, RegionKind Kind)
      : Count(Count), FalseCount(FalseCount), FileID(FileID),
        ExpandedFileID(ExpandedFileID), LineStart(LineStart),
        ColumnStart(ColumnStart), LineEnd(LineEnd), ColumnEnd(ColumnEnd),
        Kind(Kind) {}

  static CounterMappingRegion
  makeRegion(Counter Count, unsigned FileID, unsigned LineStart,
             unsigned ColumnStart, unsigned LineEnd, unsigned ColumnEnd) {
    return CounterMappingRegion(Count, FileID, 0, LineStart, ColumnStart,
                                LineEnd, ColumnEnd, CodeRegion);
  }

  static CounterMappingRegion
  makeExpansion(unsigned FileID, unsigned ExpandedFileID, unsigned LineStart,
                unsigned ColumnStart, unsigned LineEnd, unsigned ColumnEnd) {
    return CounterMappingRegion(Counter(), FileID, ExpandedFileID, LineStart,
                                ColumnStart, LineEnd, ColumnEnd,
                                ExpansionRegion);
  }

  static CounterMappingRegion
  makeSkipped(unsigned FileID, unsigned LineStart, unsigned ColumnStart,
              unsigned LineEnd, unsigned ColumnEnd) {
    return CounterMappingRegion(Counter(), FileID, 0, LineStart, ColumnStart,
                                LineEnd, ColumnEnd, SkippedRegion);
  }

  static CounterMappingRegion
  makeGapRegion(Counter Count, unsigned FileID, unsigned LineStart,
                unsigned ColumnStart, unsigned LineEnd, unsigned ColumnEnd) {
    return CounterMappingRegion(Count, FileID, 0, LineStart, ColumnStart,
                                LineEnd, (1U << 31) | ColumnEnd, GapRegion);
  }

  static CounterMappingRegion
  makeBranchRegion(Counter Count, Counter FalseCount, unsigned FileID,
                   unsigned LineStart, unsigned ColumnStart, unsigned LineEnd,
                   unsigned ColumnEnd) {
    return CounterMappingRegion(Count, FalseCount, FileID, 0, LineStart,
                                ColumnStart, LineEnd, ColumnEnd, BranchRegion);
  }

  inline LineColPair startLoc() const {
    return LineColPair(LineStart, ColumnStart);
  }

  inline LineColPair endLoc() const { return LineColPair(LineEnd, ColumnEnd); }
};

/// Associates a source range with an execution count.
struct CountedRegion : public CounterMappingRegion {
  uint64_t ExecutionCount;
  uint64_t FalseExecutionCount;
  bool Folded;

  CountedRegion(const CounterMappingRegion &R, uint64_t ExecutionCount)
      : CounterMappingRegion(R), ExecutionCount(ExecutionCount),
        FalseExecutionCount(0), Folded(false) {}

  CountedRegion(const CounterMappingRegion &R, uint64_t ExecutionCount,
                uint64_t FalseExecutionCount)
      : CounterMappingRegion(R), ExecutionCount(ExecutionCount),
        FalseExecutionCount(FalseExecutionCount), Folded(false) {}
};

/// A Counter mapping context is used to connect the counters, expressions
/// and the obtained counter values.
class CounterMappingContext {
  ArrayRef<CounterExpression> Expressions;
  ArrayRef<uint64_t> CounterValues;

public:
  CounterMappingContext(ArrayRef<CounterExpression> Expressions,
                        ArrayRef<uint64_t> CounterValues = std::nullopt)
      : Expressions(Expressions), CounterValues(CounterValues) {}

  void setCounts(ArrayRef<uint64_t> Counts) { CounterValues = Counts; }

  void dump(const Counter &C, raw_ostream &OS) const;
  void dump(const Counter &C) const { dump(C, dbgs()); }

  /// Return the number of times that a region of code associated with this
  /// counter was executed.
  Expected<int64_t> evaluate(const Counter &C) const;

  unsigned getMaxCounterID(const Counter &C) const;
};

/// Code coverage information for a single function.
struct FunctionRecord {
  /// Raw function name.
  std::string Name;
  /// Mapping from FileID (i.e. vector index) to filename. Used to support
  /// macro expansions within a function in which the macro and function are
  /// defined in separate files.
  ///
  /// TODO: Uniquing filenames across all function records may be a performance
  /// optimization.
  std::vector<std::string> Filenames;
  /// Regions in the function along with their counts.
  std::vector<CountedRegion> CountedRegions;
  /// Branch Regions in the function along with their counts.
  std::vector<CountedRegion> CountedBranchRegions;
  /// The number of times this function was executed.
  uint64_t ExecutionCount = 0;

  FunctionRecord(StringRef Name, ArrayRef<StringRef> Filenames)
      : Name(Name), Filenames(Filenames.begin(), Filenames.end()) {}

  FunctionRecord(FunctionRecord &&FR) = default;
  FunctionRecord &operator=(FunctionRecord &&) = default;

  void pushRegion(CounterMappingRegion Region, uint64_t Count,
                  uint64_t FalseCount) {
    if (Region.Kind == CounterMappingRegion::BranchRegion) {
      CountedBranchRegions.emplace_back(Region, Count, FalseCount);
      // If both counters are hard-coded to zero, then this region represents a
      // constant-folded branch.
      if (Region.Count.isZero() && Region.FalseCount.isZero())
        CountedBranchRegions.back().Folded = true;
      return;
    }
    if (CountedRegions.empty())
      ExecutionCount = Count;
    CountedRegions.emplace_back(Region, Count, FalseCount);
  }
};

/// Iterator over Functions, optionally filtered to a single file.
class FunctionRecordIterator
    : public iterator_facade_base<FunctionRecordIterator,
                                  std::forward_iterator_tag, FunctionRecord> {
  ArrayRef<FunctionRecord> Records;
  ArrayRef<FunctionRecord>::iterator Current;
  StringRef Filename;

  /// Skip records whose primary file is not \c Filename.
  void skipOtherFiles();

public:
  FunctionRecordIterator(ArrayRef<FunctionRecord> Records_,
                         StringRef Filename = "")
      : Records(Records_), Current(Records.begin()), Filename(Filename) {
    skipOtherFiles();
  }

  FunctionRecordIterator() : Current(Records.begin()) {}

  bool operator==(const FunctionRecordIterator &RHS) const {
    return Current == RHS.Current && Filename == RHS.Filename;
  }

  const FunctionRecord &operator*() const { return *Current; }

  FunctionRecordIterator &operator++() {
    assert(Current != Records.end() && "incremented past end");
    ++Current;
    skipOtherFiles();
    return *this;
  }
};

/// Coverage information for a macro expansion or #included file.
///
/// When covered code has pieces that can be expanded for more detail, such as a
/// preprocessor macro use and its definition, these are represented as
/// expansions whose coverage can be looked up independently.
struct ExpansionRecord {
  /// The abstract file this expansion covers.
  unsigned FileID;
  /// The region that expands to this record.
  const CountedRegion &Region;
  /// Coverage for the expansion.
  const FunctionRecord &Function;

  ExpansionRecord(const CountedRegion &Region,
                  const FunctionRecord &Function)
      : FileID(Region.ExpandedFileID), Region(Region), Function(Function) {}
};

/// The execution count information starting at a point in a file.
///
/// A sequence of CoverageSegments gives execution counts for a file in format
/// that's simple to iterate through for processing.
struct CoverageSegment {
  /// The line where this segment begins.
  unsigned Line;
  /// The column where this segment begins.
  unsigned Col;
  /// The execution count, or zero if no count was recorded.
  uint64_t Count;
  /// When false, the segment was uninstrumented or skipped.
  bool HasCount;
  /// Whether this enters a new region or returns to a previous count.
  bool IsRegionEntry;
  /// Whether this enters a gap region.
  bool IsGapRegion;

  CoverageSegment(unsigned Line, unsigned Col, bool IsRegionEntry)
      : Line(Line), Col(Col), Count(0), HasCount(false),
        IsRegionEntry(IsRegionEntry), IsGapRegion(false) {}

  CoverageSegment(unsigned Line, unsigned Col, uint64_t Count,
                  bool IsRegionEntry, bool IsGapRegion = false,
                  bool IsBranchRegion = false)
      : Line(Line), Col(Col), Count(Count), HasCount(true),
        IsRegionEntry(IsRegionEntry), IsGapRegion(IsGapRegion) {}

  friend bool operator==(const CoverageSegment &L, const CoverageSegment &R) {
    return std::tie(L.Line, L.Col, L.Count, L.HasCount, L.IsRegionEntry,
                    L.IsGapRegion) == std::tie(R.Line, R.Col, R.Count,
                                               R.HasCount, R.IsRegionEntry,
                                               R.IsGapRegion);
  }
};

/// An instantiation group contains a \c FunctionRecord list, such that each
/// record corresponds to a distinct instantiation of the same function.
///
/// Note that it's possible for a function to have more than one instantiation
/// (consider C++ template specializations or static inline functions).
class InstantiationGroup {
  friend class CoverageMapping;

  unsigned Line;
  unsigned Col;
  std::vector<const FunctionRecord *> Instantiations;

  InstantiationGroup(unsigned Line, unsigned Col,
                     std::vector<const FunctionRecord *> Instantiations)
      : Line(Line), Col(Col), Instantiations(std::move(Instantiations)) {}

public:
  InstantiationGroup(const InstantiationGroup &) = delete;
  InstantiationGroup(InstantiationGroup &&) = default;

  /// Get the number of instantiations in this group.
  size_t size() const { return Instantiations.size(); }

  /// Get the line where the common function was defined.
  unsigned getLine() const { return Line; }

  /// Get the column where the common function was defined.
  unsigned getColumn() const { return Col; }

  /// Check if the instantiations in this group have a common mangled name.
  bool hasName() const {
    for (unsigned I = 1, E = Instantiations.size(); I < E; ++I)
      if (Instantiations[I]->Name != Instantiations[0]->Name)
        return false;
    return true;
  }

  /// Get the common mangled name for instantiations in this group.
  StringRef getName() const {
    assert(hasName() && "Instantiations don't have a shared name");
    return Instantiations[0]->Name;
  }

  /// Get the total execution count of all instantiations in this group.
  uint64_t getTotalExecutionCount() const {
    uint64_t Count = 0;
    for (const FunctionRecord *F : Instantiations)
      Count += F->ExecutionCount;
    return Count;
  }

  /// Get the instantiations in this group.
  ArrayRef<const FunctionRecord *> getInstantiations() const {
    return Instantiations;
  }
};

/// Coverage information to be processed or displayed.
///
/// This represents the coverage of an entire file, expansion, or function. It
/// provides a sequence of CoverageSegments to iterate through, as well as the
/// list of expansions that can be further processed.
class CoverageData {
  friend class CoverageMapping;

  std::string Filename;
  std::vector<CoverageSegment> Segments;
  std::vector<ExpansionRecord> Expansions;
  std::vector<CountedRegion> BranchRegions;

public:
  CoverageData() = default;

  CoverageData(StringRef Filename) : Filename(Filename) {}

  /// Get the name of the file this data covers.
  StringRef getFilename() const { return Filename; }

  /// Get an iterator over the coverage segments for this object. The segments
  /// are guaranteed to be uniqued and sorted by location.
  std::vector<CoverageSegment>::const_iterator begin() const {
    return Segments.begin();
  }

  std::vector<CoverageSegment>::const_iterator end() const {
    return Segments.end();
  }

  bool empty() const { return Segments.empty(); }

  /// Expansions that can be further processed.
  ArrayRef<ExpansionRecord> getExpansions() const { return Expansions; }

  /// Branches that can be further processed.
  ArrayRef<CountedRegion> getBranches() const { return BranchRegions; }
};

/// The mapping of profile information to coverage data.
///
/// This is the main interface to get coverage information, using a profile to
/// fill out execution counts.
class CoverageMapping {
  DenseMap<size_t, DenseSet<size_t>> RecordProvenance;
  std::vector<FunctionRecord> Functions;
  DenseMap<size_t, SmallVector<unsigned, 0>> FilenameHash2RecordIndices;
  std::vector<std::pair<std::string, uint64_t>> FuncHashMismatches;

  CoverageMapping() = default;

  // Load coverage records from readers.
  static Error loadFromReaders(
      ArrayRef<std::unique_ptr<CoverageMappingReader>> CoverageReaders,
      IndexedInstrProfReader &ProfileReader, CoverageMapping &Coverage);

  // Load coverage records from file.
  static Error
  loadFromFile(StringRef Filename, StringRef Arch, StringRef CompilationDir,
               IndexedInstrProfReader &ProfileReader, CoverageMapping &Coverage,
               bool &DataFound,
               SmallVectorImpl<object::BuildID> *FoundBinaryIDs = nullptr);

  /// Add a function record corresponding to \p Record.
  Error loadFunctionRecord(const CoverageMappingRecord &Record,
                           IndexedInstrProfReader &ProfileReader);

  /// Look up the indices for function records which are at least partially
  /// defined in the specified file. This is guaranteed to return a superset of
  /// such records: extra records not in the file may be included if there is
  /// a hash collision on the filename. Clients must be robust to collisions.
  ArrayRef<unsigned>
  getImpreciseRecordIndicesForFilename(StringRef Filename) const;

public:
  CoverageMapping(const CoverageMapping &) = delete;
  CoverageMapping &operator=(const CoverageMapping &) = delete;

  /// Load the coverage mapping using the given readers.
  static Expected<std::unique_ptr<CoverageMapping>>
  load(ArrayRef<std::unique_ptr<CoverageMappingReader>> CoverageReaders,
       IndexedInstrProfReader &ProfileReader);

  /// Load the coverage mapping from the given object files and profile. If
  /// \p Arches is non-empty, it must specify an architecture for each object.
  /// Ignores non-instrumented object files unless all are not instrumented.
  static Expected<std::unique_ptr<CoverageMapping>>
  load(ArrayRef<StringRef> ObjectFilenames, StringRef ProfileFilename,
       vfs::FileSystem &FS, ArrayRef<StringRef> Arches = std::nullopt,
       StringRef CompilationDir = "",
       const object::BuildIDFetcher *BIDFetcher = nullptr);

  /// The number of functions that couldn't have their profiles mapped.
  ///
  /// This is a count of functions whose profile is out of date or otherwise
  /// can't be associated with any coverage information.
  unsigned getMismatchedCount() const { return FuncHashMismatches.size(); }

  /// A hash mismatch occurs when a profile record for a symbol does not have
  /// the same hash as a coverage mapping record for the same symbol. This
  /// returns a list of hash mismatches, where each mismatch is a pair of the
  /// symbol name and its coverage mapping hash.
  ArrayRef<std::pair<std::string, uint64_t>> getHashMismatches() const {
    return FuncHashMismatches;
  }

  /// Returns a lexicographically sorted, unique list of files that are
  /// covered.
  std::vector<StringRef> getUniqueSourceFiles() const;

  /// Get the coverage for a particular file.
  ///
  /// The given filename must be the name as recorded in the coverage
  /// information. That is, only names returned from getUniqueSourceFiles will
  /// yield a result.
  CoverageData getCoverageForFile(StringRef Filename) const;

  /// Get the coverage for a particular function.
  CoverageData getCoverageForFunction(const FunctionRecord &Function) const;

  /// Get the coverage for an expansion within a coverage set.
  CoverageData getCoverageForExpansion(const ExpansionRecord &Expansion) const;

  /// Gets all of the functions covered by this profile.
  iterator_range<FunctionRecordIterator> getCoveredFunctions() const {
    return make_range(FunctionRecordIterator(Functions),
                      FunctionRecordIterator());
  }

  /// Gets all of the functions in a particular file.
  iterator_range<FunctionRecordIterator>
  getCoveredFunctions(StringRef Filename) const {
    return make_range(FunctionRecordIterator(Functions, Filename),
                      FunctionRecordIterator());
  }

  /// Get the list of function instantiation groups in a particular file.
  ///
  /// Every instantiation group in a program is attributed to exactly one file:
  /// the file in which the definition for the common function begins.
  std::vector<InstantiationGroup>
  getInstantiationGroups(StringRef Filename) const;
};

/// Coverage statistics for a single line.
class LineCoverageStats {
  uint64_t ExecutionCount;
  bool HasMultipleRegions;
  bool Mapped;
  unsigned Line;
  ArrayRef<const CoverageSegment *> LineSegments;
  const CoverageSegment *WrappedSegment;

  friend class LineCoverageIterator;
  LineCoverageStats() = default;

public:
  LineCoverageStats(ArrayRef<const CoverageSegment *> LineSegments,
                    const CoverageSegment *WrappedSegment, unsigned Line);

  uint64_t getExecutionCount() const { return ExecutionCount; }

  bool hasMultipleRegions() const { return HasMultipleRegions; }

  bool isMapped() const { return Mapped; }

  unsigned getLine() const { return Line; }

  ArrayRef<const CoverageSegment *> getLineSegments() const {
    return LineSegments;
  }

  const CoverageSegment *getWrappedSegment() const { return WrappedSegment; }
};

/// An iterator over the \c LineCoverageStats objects for lines described by
/// a \c CoverageData instance.
class LineCoverageIterator
    : public iterator_facade_base<LineCoverageIterator,
                                  std::forward_iterator_tag,
                                  const LineCoverageStats> {
public:
  LineCoverageIterator(const CoverageData &CD)
      : LineCoverageIterator(CD, CD.begin()->Line) {}

  LineCoverageIterator(const CoverageData &CD, unsigned Line)
      : CD(CD), WrappedSegment(nullptr), Next(CD.begin()), Ended(false),
        Line(Line) {
    this->operator++();
  }

  bool operator==(const LineCoverageIterator &R) const {
    return &CD == &R.CD && Next == R.Next && Ended == R.Ended;
  }

  const LineCoverageStats &operator*() const { return Stats; }

  LineCoverageIterator &operator++();

  LineCoverageIterator getEnd() const {
    auto EndIt = *this;
    EndIt.Next = CD.end();
    EndIt.Ended = true;
    return EndIt;
  }

private:
  const CoverageData &CD;
  const CoverageSegment *WrappedSegment;
  std::vector<CoverageSegment>::const_iterator Next;
  bool Ended;
  unsigned Line;
  SmallVector<const CoverageSegment *, 4> Segments;
  LineCoverageStats Stats;
};

/// Get a \c LineCoverageIterator range for the lines described by \p CD.
static inline iterator_range<LineCoverageIterator>
getLineCoverageStats(const coverage::CoverageData &CD) {
  auto Begin = LineCoverageIterator(CD);
  auto End = Begin.getEnd();
  return make_range(Begin, End);
}

// Coverage mappping data (V2) has the following layout:
// IPSK_covmap:
//   [CoverageMapFileHeader]
//   [ArrayStart]
//    [CovMapFunctionRecordV2]
//    [CovMapFunctionRecordV2]
//    ...
//   [ArrayEnd]
//   [Encoded Filenames and Region Mapping Data]
//
// Coverage mappping data (V3) has the following layout:
// IPSK_covmap:
//   [CoverageMapFileHeader]
//   [Encoded Filenames]
// IPSK_covfun:
//   [ArrayStart]
//     odr_name_1: [CovMapFunctionRecordV3]
//     odr_name_2: [CovMapFunctionRecordV3]
//     ...
//   [ArrayEnd]
//
// Both versions of the coverage mapping format encode the same information,
// but the V3 format does so more compactly by taking advantage of linkonce_odr
// semantics (it allows exactly 1 function record per name reference).

/// This namespace defines accessors shared by different versions of coverage
/// mapping records.
namespace accessors {

/// Return the structural hash associated with the function.
template <class FuncRecordTy, support::endianness Endian>
uint64_t getFuncHash(const FuncRecordTy *Record) {
  return support::endian::byte_swap<uint64_t, Endian>(Record->FuncHash);
}

/// Return the coverage map data size for the function.
template <class FuncRecordTy, support::endianness Endian>
uint64_t getDataSize(const FuncRecordTy *Record) {
  return support::endian::byte_swap<uint32_t, Endian>(Record->DataSize);
}

/// Return the function lookup key. The value is considered opaque.
template <class FuncRecordTy, support::endianness Endian>
uint64_t getFuncNameRef(const FuncRecordTy *Record) {
  return support::endian::byte_swap<uint64_t, Endian>(Record->NameRef);
}

/// Return the PGO name of the function. Used for formats in which the name is
/// a hash.
template <class FuncRecordTy, support::endianness Endian>
Error getFuncNameViaRef(const FuncRecordTy *Record,
                        InstrProfSymtab &ProfileNames, StringRef &FuncName) {
  uint64_t NameRef = getFuncNameRef<FuncRecordTy, Endian>(Record);
  FuncName = ProfileNames.getFuncName(NameRef);
  return Error::success();
}

/// Read coverage mapping out-of-line, from \p MappingBuf. This is used when the
/// coverage mapping is attached to the file header, instead of to the function
/// record.
template <class FuncRecordTy, support::endianness Endian>
StringRef getCoverageMappingOutOfLine(const FuncRecordTy *Record,
                                      const char *MappingBuf) {
  return {MappingBuf, size_t(getDataSize<FuncRecordTy, Endian>(Record))};
}

/// Advance to the next out-of-line coverage mapping and its associated
/// function record.
template <class FuncRecordTy, support::endianness Endian>
std::pair<const char *, const FuncRecordTy *>
advanceByOneOutOfLine(const FuncRecordTy *Record, const char *MappingBuf) {
  return {MappingBuf + getDataSize<FuncRecordTy, Endian>(Record), Record + 1};
}

} // end namespace accessors

LLVM_PACKED_START
template <class IntPtrT>
struct CovMapFunctionRecordV1 {
  using ThisT = CovMapFunctionRecordV1<IntPtrT>;

#define COVMAP_V1
#define COVMAP_FUNC_RECORD(Type, LLVMType, Name, Init) Type Name;
#include "llvm/ProfileData/InstrProfData.inc"
#undef COVMAP_V1
  CovMapFunctionRecordV1() = delete;

  template <support::endianness Endian> uint64_t getFuncHash() const {
    return accessors::getFuncHash<ThisT, Endian>(this);
  }

  template <support::endianness Endian> uint64_t getDataSize() const {
    return accessors::getDataSize<ThisT, Endian>(this);
  }

  /// Return function lookup key. The value is consider opaque.
  template <support::endianness Endian> IntPtrT getFuncNameRef() const {
    return support::endian::byte_swap<IntPtrT, Endian>(NamePtr);
  }

  /// Return the PGO name of the function.
  template <support::endianness Endian>
  Error getFuncName(InstrProfSymtab &ProfileNames, StringRef &FuncName) const {
    IntPtrT NameRef = getFuncNameRef<Endian>();
    uint32_t NameS = support::endian::byte_swap<uint32_t, Endian>(NameSize);
    FuncName = ProfileNames.getFuncName(NameRef, NameS);
    if (NameS && FuncName.empty())
      return make_error<CoverageMapError>(coveragemap_error::malformed);
    return Error::success();
  }

  template <support::endianness Endian>
  std::pair<const char *, const ThisT *>
  advanceByOne(const char *MappingBuf) const {
    return accessors::advanceByOneOutOfLine<ThisT, Endian>(this, MappingBuf);
  }

  template <support::endianness Endian> uint64_t getFilenamesRef() const {
    llvm_unreachable("V1 function format does not contain a filenames ref");
  }

  template <support::endianness Endian>
  StringRef getCoverageMapping(const char *MappingBuf) const {
    return accessors::getCoverageMappingOutOfLine<ThisT, Endian>(this,
                                                                 MappingBuf);
  }
};

struct CovMapFunctionRecordV2 {
  using ThisT = CovMapFunctionRecordV2;

#define COVMAP_V2
#define COVMAP_FUNC_RECORD(Type, LLVMType, Name, Init) Type Name;
#include "llvm/ProfileData/InstrProfData.inc"
#undef COVMAP_V2
  CovMapFunctionRecordV2() = delete;

  template <support::endianness Endian> uint64_t getFuncHash() const {
    return accessors::getFuncHash<ThisT, Endian>(this);
  }

  template <support::endianness Endian> uint64_t getDataSize() const {
    return accessors::getDataSize<ThisT, Endian>(this);
  }

  template <support::endianness Endian> uint64_t getFuncNameRef() const {
    return accessors::getFuncNameRef<ThisT, Endian>(this);
  }

  template <support::endianness Endian>
  Error getFuncName(InstrProfSymtab &ProfileNames, StringRef &FuncName) const {
    return accessors::getFuncNameViaRef<ThisT, Endian>(this, ProfileNames,
                                                       FuncName);
  }

  template <support::endianness Endian>
  std::pair<const char *, const ThisT *>
  advanceByOne(const char *MappingBuf) const {
    return accessors::advanceByOneOutOfLine<ThisT, Endian>(this, MappingBuf);
  }

  template <support::endianness Endian> uint64_t getFilenamesRef() const {
    llvm_unreachable("V2 function format does not contain a filenames ref");
  }

  template <support::endianness Endian>
  StringRef getCoverageMapping(const char *MappingBuf) const {
    return accessors::getCoverageMappingOutOfLine<ThisT, Endian>(this,
                                                                 MappingBuf);
  }
};

struct CovMapFunctionRecordV3 {
  using ThisT = CovMapFunctionRecordV3;

#define COVMAP_V3
#define COVMAP_FUNC_RECORD(Type, LLVMType, Name, Init) Type Name;
#include "llvm/ProfileData/InstrProfData.inc"
#undef COVMAP_V3
  CovMapFunctionRecordV3() = delete;

  template <support::endianness Endian> uint64_t getFuncHash() const {
    return accessors::getFuncHash<ThisT, Endian>(this);
  }

  template <support::endianness Endian> uint64_t getDataSize() const {
    return accessors::getDataSize<ThisT, Endian>(this);
  }

  template <support::endianness Endian> uint64_t getFuncNameRef() const {
    return accessors::getFuncNameRef<ThisT, Endian>(this);
  }

  template <support::endianness Endian>
  Error getFuncName(InstrProfSymtab &ProfileNames, StringRef &FuncName) const {
    return accessors::getFuncNameViaRef<ThisT, Endian>(this, ProfileNames,
                                                       FuncName);
  }

  /// Get the filename set reference.
  template <support::endianness Endian> uint64_t getFilenamesRef() const {
    return support::endian::byte_swap<uint64_t, Endian>(FilenamesRef);
  }

  /// Read the inline coverage mapping. Ignore the buffer parameter, it is for
  /// out-of-line coverage mapping data only.
  template <support::endianness Endian>
  StringRef getCoverageMapping(const char *) const {
    return StringRef(&CoverageMapping, getDataSize<Endian>());
  }

  // Advance to the next inline coverage mapping and its associated function
  // record. Ignore the out-of-line coverage mapping buffer.
  template <support::endianness Endian>
  std::pair<const char *, const CovMapFunctionRecordV3 *>
  advanceByOne(const char *) const {
    assert(isAddrAligned(Align(8), this) && "Function record not aligned");
    const char *Next = ((const char *)this) + sizeof(CovMapFunctionRecordV3) -
                       sizeof(char) + getDataSize<Endian>();
    // Each function record has an alignment of 8, so we need to adjust
    // alignment before reading the next record.
    Next += offsetToAlignedAddr(Next, Align(8));
    return {nullptr, reinterpret_cast<const CovMapFunctionRecordV3 *>(Next)};
  }
};

// Per module coverage mapping data header, i.e. CoverageMapFileHeader
// documented above.
struct CovMapHeader {
#define COVMAP_HEADER(Type, LLVMType, Name, Init) Type Name;
#include "llvm/ProfileData/InstrProfData.inc"
  template <support::endianness Endian> uint32_t getNRecords() const {
    return support::endian::byte_swap<uint32_t, Endian>(NRecords);
  }

  template <support::endianness Endian> uint32_t getFilenamesSize() const {
    return support::endian::byte_swap<uint32_t, Endian>(FilenamesSize);
  }

  template <support::endianness Endian> uint32_t getCoverageSize() const {
    return support::endian::byte_swap<uint32_t, Endian>(CoverageSize);
  }

  template <support::endianness Endian> uint32_t getVersion() const {
    return support::endian::byte_swap<uint32_t, Endian>(Version);
  }
};

LLVM_PACKED_END

enum CovMapVersion {
  Version1 = 0,
  // Function's name reference from CovMapFuncRecord is changed from raw
  // name string pointer to MD5 to support name section compression. Name
  // section is also compressed.
  Version2 = 1,
  // A new interpretation of the columnEnd field is added in order to mark
  // regions as gap areas.
  Version3 = 2,
  // Function records are named, uniqued, and moved to a dedicated section.
  Version4 = 3,
  // Branch regions referring to two counters are added
  Version5 = 4,
  // Compilation directory is stored separately and combined with relative
  // filenames to produce an absolute file path.
  Version6 = 5,
  // The current version is Version6.
  CurrentVersion = INSTR_PROF_COVMAP_VERSION
};

template <int CovMapVersion, class IntPtrT> struct CovMapTraits {
  using CovMapFuncRecordType = CovMapFunctionRecordV3;
  using NameRefType = uint64_t;
};

template <class IntPtrT> struct CovMapTraits<CovMapVersion::Version3, IntPtrT> {
  using CovMapFuncRecordType = CovMapFunctionRecordV2;
  using NameRefType = uint64_t;
};

template <class IntPtrT> struct CovMapTraits<CovMapVersion::Version2, IntPtrT> {
  using CovMapFuncRecordType = CovMapFunctionRecordV2;
  using NameRefType = uint64_t;
};

template <class IntPtrT> struct CovMapTraits<CovMapVersion::Version1, IntPtrT> {
  using CovMapFuncRecordType = CovMapFunctionRecordV1<IntPtrT>;
  using NameRefType = IntPtrT;
};

} // end namespace coverage

/// Provide DenseMapInfo for CounterExpression
template<> struct DenseMapInfo<coverage::CounterExpression> {
  static inline coverage::CounterExpression getEmptyKey() {
    using namespace coverage;

    return CounterExpression(CounterExpression::ExprKind::Subtract,
                             Counter::getCounter(~0U),
                             Counter::getCounter(~0U));
  }

  static inline coverage::CounterExpression getTombstoneKey() {
    using namespace coverage;

    return CounterExpression(CounterExpression::ExprKind::Add,
                             Counter::getCounter(~0U),
                             Counter::getCounter(~0U));
  }

  static unsigned getHashValue(const coverage::CounterExpression &V) {
    return static_cast<unsigned>(
        hash_combine(V.Kind, V.LHS.getKind(), V.LHS.getCounterID(),
                     V.RHS.getKind(), V.RHS.getCounterID()));
  }

  static bool isEqual(const coverage::CounterExpression &LHS,
                      const coverage::CounterExpression &RHS) {
    return LHS.Kind == RHS.Kind && LHS.LHS == RHS.LHS && LHS.RHS == RHS.RHS;
  }
};

} // end namespace llvm

#endif // LLVM_PROFILEDATA_COVERAGE_COVERAGEMAPPING_H
