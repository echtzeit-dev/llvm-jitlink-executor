//===- DXContainerTest.cpp - Tests for DXContainerFile --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/Object/DXContainer.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/BinaryFormat/Magic.h"
#include "llvm/ObjectYAML/DXContainerYAML.h"
#include "llvm/ObjectYAML/yaml2obj.h"
#include "llvm/Support/MemoryBufferRef.h"
#include "llvm/Testing/Support/Error.h"
#include "gtest/gtest.h"

using namespace llvm;
using namespace llvm::object;

template <std::size_t X> MemoryBufferRef getMemoryBuffer(uint8_t Data[X]) {
  StringRef Obj(reinterpret_cast<char *>(&Data[0]), X);
  return MemoryBufferRef(Obj, "");
}

TEST(DXCFile, IdentifyMagic) {
  {
    StringRef Buffer("DXBC");
    EXPECT_EQ(identify_magic(Buffer), file_magic::dxcontainer_object);
  }
  {
    StringRef Buffer("DXBCBlahBlahBlah");
    EXPECT_EQ(identify_magic(Buffer), file_magic::dxcontainer_object);
  }
}

TEST(DXCFile, ParseHeaderErrors) {
  uint8_t Buffer[] = {0x44, 0x58, 0x42, 0x43};
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<4>(Buffer)),
      FailedWithMessage("Reading structure out of file bounds"));
}

TEST(DXCFile, EmptyFile) {
  EXPECT_THAT_EXPECTED(
      DXContainer::create(MemoryBufferRef(StringRef("", 0), "")),
      FailedWithMessage("Reading structure out of file bounds"));
}

TEST(DXCFile, ParseHeader) {
  uint8_t Buffer[] = {0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
                      0x70, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
  DXContainer C =
      llvm::cantFail(DXContainer::create(getMemoryBuffer<32>(Buffer)));
  EXPECT_TRUE(memcmp(C.getHeader().Magic, "DXBC", 4) == 0);
  EXPECT_TRUE(memcmp(C.getHeader().FileHash.Digest,
                     "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) == 0);
  EXPECT_EQ(C.getHeader().Version.Major, 1u);
  EXPECT_EQ(C.getHeader().Version.Minor, 0u);
}

TEST(DXCFile, ParsePartMissingOffsets) {
  uint8_t Buffer[] = {
      0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
      0x00, 0x00, 0x70, 0x0D, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
  };
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<32>(Buffer)),
      FailedWithMessage("Reading structure out of file bounds"));
}

TEST(DXCFile, ParsePartInvalidOffsets) {
  // This test covers a case where the part offset is beyond the buffer size.
  uint8_t Buffer[] = {
      0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
      0x70, 0x0D, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
  };
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<36>(Buffer)),
      FailedWithMessage("Part offset points beyond boundary of the file"));
}

TEST(DXCFile, ParsePartTooSmallBuffer) {
  // This test covers a case where there is insufficent space to read a full
  // part name, but the offset for the part is inside the buffer.
  uint8_t Buffer[] = {0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
                      0x26, 0x0D, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
                      0x24, 0x00, 0x00, 0x00, 0x46, 0x4B};
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<38>(Buffer)),
      FailedWithMessage("File not large enough to read part name"));
}

TEST(DXCFile, ParsePartNoSize) {
  // This test covers a case where the part's header is readable, but the size
  // the part extends beyond the boundaries of the file.
  uint8_t Buffer[] = {0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                      0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x28, 0x0D, 0x00,
                      0x00, 0x01, 0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00,
                      0x46, 0x4B, 0x45, 0x30, 0x00, 0x00};
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<42>(Buffer)),
      FailedWithMessage("Reading part size out of file bounds"));
}

TEST(DXCFile, ParseOverlappingParts) {
  // This test covers a case where a part's offset is inside the size range
  // covered by the previous part.
  uint8_t Buffer[] = {
      0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
      0x40, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00,
      0x2C, 0x00, 0x00, 0x00, 0x46, 0x4B, 0x45, 0x30, 0x08, 0x00, 0x00, 0x00,
      0x46, 0x4B, 0x45, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  };
  EXPECT_THAT_EXPECTED(
      DXContainer::create(getMemoryBuffer<60>(Buffer)),
      FailedWithMessage(
          "Part offset for part 1 begins before the previous part ends"));
}

TEST(DXCFile, ParseEmptyParts) {
  uint8_t Buffer[] = {
      0x44, 0x58, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
      0x70, 0x0D, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00,
      0x44, 0x00, 0x00, 0x00, 0x4C, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00,
      0x5C, 0x00, 0x00, 0x00, 0x64, 0x00, 0x00, 0x00, 0x6C, 0x00, 0x00, 0x00,
      0x46, 0x4B, 0x45, 0x30, 0x00, 0x00, 0x00, 0x00, 0x46, 0x4B, 0x45, 0x31,
      0x00, 0x00, 0x00, 0x00, 0x46, 0x4B, 0x45, 0x32, 0x00, 0x00, 0x00, 0x00,
      0x46, 0x4B, 0x45, 0x33, 0x00, 0x00, 0x00, 0x00, 0x46, 0x4B, 0x45, 0x34,
      0x00, 0x00, 0x00, 0x00, 0x46, 0x4B, 0x45, 0x35, 0x00, 0x00, 0x00, 0x00,
      0x46, 0x4B, 0x45, 0x36, 0x00, 0x00, 0x00, 0x00,
  };
  DXContainer C =
      llvm::cantFail(DXContainer::create(getMemoryBuffer<116>(Buffer)));
  EXPECT_EQ(C.getHeader().PartCount, 7u);

  // All the part sizes are 0, which makes a nice test of the range based for
  int ElementsVisited = 0;
  for (auto Part : C) {
    EXPECT_EQ(Part.Part.Size, 0u);
    EXPECT_EQ(Part.Data.size(), 0u);
    ++ElementsVisited;
  }
  EXPECT_EQ(ElementsVisited, 7);

  {
    // These are all intended to be fake part names so that the parser doesn't
    // try to parse the part data.
    auto It = C.begin();
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE0", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE1", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE2", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE3", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE4", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE5", 4) == 0);
    ++It;
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE6", 4) == 0);
    ++It; // Don't increment past the end
    EXPECT_TRUE(memcmp(It->Part.Name, "FKE6", 4) == 0);
  }
}

static Expected<DXContainer>
generateDXContainer(StringRef Yaml, SmallVectorImpl<char> &BinaryData) {
  DXContainerYAML::Object Obj;
  SMDiagnostic GenerateDiag;
  yaml::Input YIn(
      Yaml, /*Ctxt=*/nullptr,
      [](const SMDiagnostic &Diag, void *DiagContext) {
        *static_cast<SMDiagnostic *>(DiagContext) = Diag;
      },
      &GenerateDiag);

  YIn >> Obj;
  if (YIn.error())
    return createStringError(YIn.error(), GenerateDiag.getMessage());

  raw_svector_ostream OS(BinaryData);
  std::string ErrorMsg;
  if (!yaml::yaml2dxcontainer(
          Obj, OS, [&ErrorMsg](const Twine &Msg) { ErrorMsg = Msg.str(); }))
    return createStringError(YIn.error(), ErrorMsg);

  MemoryBufferRef BinaryDataRef = MemoryBufferRef(OS.str(), "");

  return DXContainer::create(BinaryDataRef);
}

TEST(DXCFile, PSVResourceIterators) {
  const char *Yaml = R"(
--- !dxcontainer
Header:
  Hash:            [ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
                     0x0, 0x0, 0x0, 0x0, 0x0, 0x0 ]
  Version:
    Major:           1
    Minor:           0
  PartCount:       2
Parts:
  - Name:            PSV0
    Size:            144
    PSVInfo:
      Version:         0
      ShaderStage:     14
      PayloadSizeInBytes: 4092
      MinimumWaveLaneCount: 0
      MaximumWaveLaneCount: 4294967295
      Resources:
        - Type:            1
          Space:           1
          LowerBound:      1
          UpperBound:      1
        - Type:            2
          Space:           2
          LowerBound:      2
          UpperBound:      2
        - Type:            3
          Space:           3
          LowerBound:      3
          UpperBound:      3
  - Name:            DXIL
    Size:            24
    Program:
      MajorVersion:    6
      MinorVersion:    0
      ShaderKind:      14
      Size:            6
      DXILMajorVersion: 0
      DXILMinorVersion: 1
      DXILSize:        0
...
)";

  SmallVector<char, 256> BinaryData;
  auto C = generateDXContainer(Yaml, BinaryData);

  ASSERT_THAT_EXPECTED(C, Succeeded());

  const auto &PSVInfo = C->getPSVInfo();
  ASSERT_TRUE(PSVInfo.has_value());

  EXPECT_EQ(PSVInfo->getResourceCount(), 3u);

  auto It = PSVInfo->getResources().begin();

  EXPECT_TRUE(It == PSVInfo->getResources().begin());

  dxbc::PSV::v2::ResourceBindInfo Binding;

  Binding = *It;
  EXPECT_EQ(Binding.Type, 1u);
  EXPECT_EQ(Binding.Flags, 0u);

  ++It;
  Binding = *It;

  EXPECT_EQ(Binding.Type, 2u);
  EXPECT_EQ(Binding.Flags, 0u);

  --It;
  Binding = *It;

  EXPECT_TRUE(It == PSVInfo->getResources().begin());

  EXPECT_EQ(Binding.Type, 1u);
  EXPECT_EQ(Binding.Flags, 0u);

  --It;
  Binding = *It;

  EXPECT_EQ(Binding.Type, 1u);
  EXPECT_EQ(Binding.Flags, 0u);

  ++It;
  Binding = *It;

  EXPECT_EQ(Binding.Type, 2u);
  EXPECT_EQ(Binding.Flags, 0u);

  ++It;
  Binding = *It;

  EXPECT_EQ(Binding.Type, 3u);
  EXPECT_EQ(Binding.Flags, 0u);

  EXPECT_FALSE(It == PSVInfo->getResources().end());

  ++It;
  Binding = *It;

  EXPECT_TRUE(It == PSVInfo->getResources().end());
  EXPECT_FALSE(It != PSVInfo->getResources().end());

  EXPECT_EQ(Binding.Type, 0u);
  EXPECT_EQ(Binding.Flags, 0u);

  {
    auto Old = It++;
    Binding = *Old;

    EXPECT_TRUE(Old == PSVInfo->getResources().end());
    EXPECT_FALSE(Old != PSVInfo->getResources().end());

    EXPECT_EQ(Binding.Type, 0u);
    EXPECT_EQ(Binding.Flags, 0u);
  }

  Binding = *It;

  EXPECT_TRUE(It == PSVInfo->getResources().end());

  EXPECT_EQ(Binding.Type, 0u);
  EXPECT_EQ(Binding.Flags, 0u);

  {
    auto Old = It--;
    Binding = *Old;
    EXPECT_TRUE(Old == PSVInfo->getResources().end());

    EXPECT_EQ(Binding.Type, 0u);
    EXPECT_EQ(Binding.Flags, 0u);
  }
  
  Binding = *It;

  EXPECT_EQ(Binding.Type, 3u);
  EXPECT_EQ(Binding.Flags, 0u);
}
