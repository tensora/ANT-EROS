/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_EROS_all_double_set_add_clipAny_limit5_info.c
 *
 * Code generation for function 'EROS_all_double_set_add_clipAny_limit5'
 *
 */

/* Include files */
#include "_coder_EROS_all_double_set_add_clipAny_limit5_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[5] = {
      "789cdd95cf4ec24010c6b7068d89ffb8a8d79ebc691045a33743100d8244d044ada9a51d"
      "d3d5ed766d17059fc09bafe243f8005ebc79d297f0a8050a7493a628"
      "498d4ed20c936fbbbfd9afed80a4dda284109a46edf89868e7a94e9dece411140c519784"
      "755270391a4589c07dbefed0c9ba4d393478bba09a05dd3b0ddbc254",
      "a3bcda64801c706d7203464bb9c004aad8824a7f51f22a6bbb4fea169ee4fdce9aa05f55"
      "ea16724cb7d721e92fba7e9c879c3711e18718a21fe23a9f77ff439e"
      "bfff4204cfd77307fb1555234435ec7a8d80ea025735c3507582d9166daa045b986786f7"
      "c1ef632cb4afb652c7942faff578cf43f270282fa89fe6cef29b4aa1",
      "bae35d32342eed5a4d4ea7d2197951deb3758d289e5372fe705749adca2ed338d6be4c03"
      "577730e3b6a30c66e492d5e145f93933e0f9c4dc5b3fdecaf34faf52"
      "9cbcc919e32d4e9e1fbfc56b84ec37e8fb391bc24b0a7a165f9b1bfa3163e6da7a71d94d"
      "c3c9caea6d5f1fe5084e541f28a48e6bfffffe9db321cf27fe5f8ae7",
      "f3f5161e8c02381408fabdb9fd3824af14ca0beadf799e29d904c2c0512fea54e7d8a6ae"
      "12b0cb7b6871cd117529deb95c1a797f8993e7c75f9dcb7321bca4a0"
      "97570a04c375a1bc513bc81e550eef324d46f37f7f2e7f02a8dacbdb",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 3088U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *epFieldName[7] = {
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Visible"};
  const char_T *propFieldName[7] = {
      "Version",      "ResolvedFunctions", "Checksum", "EntryPoints",
      "CoverageInfo", "IsPolymorphic",     "AuxData"};
  uint8_T v[216] = {
      0U,   1U,   73U,  77U,  0U,   0U,   0U,   0U,   14U,  0U,   0U,   0U,
      200U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,
      2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   4U,   0U,
      17U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,   17U,  0U,   0U,   0U,
      67U,  108U, 97U,  115U, 115U, 69U,  110U, 116U, 114U, 121U, 80U,  111U,
      105U, 110U, 116U, 115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      14U,  0U,   0U,   0U,   112U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      0U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   4U,   0U,   14U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,
      56U,  0U,   0U,   0U,   81U,  117U, 97U,  108U, 105U, 102U, 105U, 101U,
      100U, 78U,  97U,  109U, 101U, 0U,   77U,  101U, 116U, 104U, 111U, 100U,
      115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   80U,  114U, 111U, 112U,
      101U, 114U, 116U, 105U, 101U, 115U, 0U,   0U,   0U,   0U,   72U,  97U,
      110U, 100U, 108U, 101U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 15);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("EROS_all_double_set_add_clipAny_limit5"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(15.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "ResolvedFilePath",
      emlrtMxCreateString(
          "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
          "spatial_descriptor\\EROS_all_double_set_add_clipAny_limit5.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740076.490474537));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2973910 (R2025a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("DAJErj2w9oGfNqq2i3sEAB"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_EROS_all_double_set_add_clipAny_limit5_info.c)
 */
