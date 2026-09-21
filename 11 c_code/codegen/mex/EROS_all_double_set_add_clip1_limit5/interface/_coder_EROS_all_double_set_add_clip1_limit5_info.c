/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_EROS_all_double_set_add_clip1_limit5_info.c
 *
 * Code generation for function 'EROS_all_double_set_add_clip1_limit5'
 *
 */

/* Include files */
#include "_coder_EROS_all_double_set_add_clip1_limit5_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[5] = {
      "789cdd55cd4ec240105e0c1a13e3cfc9730f5e352062d4a304c1a040f8f1624d2ded20ab"
      "dbedda2e083e81377d141fc1a32fe0cd8bf1e2cd57900205ba495394"
      "a4462769a6936f76bf996fbb5314393c8e20849650df3e16fa7e7110af0cfc0cf29a8847"
      "84bc88371dcda2a8679d8bdf0fbc66520e6dde0fa86ac070a56e1a98",
      "aa94573a0c9005b6495aa0f7903a2650c10694c783bc13190763d0307020e73dd500edaa"
      "dc3490d5b0471592f160a8c7b94fbfd1003d4413f510f35cbebb1ff2"
      "b9fbaf05f0b978ba54282b2a218a6e366b04141bb8a2eabaa211cce20ac106e6c9f1bace"
      "a7ac6bceb7ae3ed2c494c7b7477ccf53f25df8f279f1d3f459664fce",
      "55b2ce2341fbd2acd5a4cdd866525a978e4c4d25b2a39494a91ecab12dc9662ac76a5734"
      "b0350b336e5af224426e18813a2e4fd897e847f9f33dfff9f8da83c2"
      "e27b7a230f61f2b9f65b7c6d9ffd26fd2e577df856041cef9ce06cab400b5a22aec75b37"
      "8c65f7edf4a88e62004f501dc8270e6bffff7abfd9947d89ff47b12f",
      "17ef11839e038b0241bf37a71fa7e4cbfbf279f1ef9c634c6a00616029f526d53836a92d"
      "7be4ea1e5768f343d908771ee767de5fc2e473edbfcfe3622247305c"
      "e78abbb552eaa45cbd4d7618cdfcfd79fc05ef1acb72",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 3072U, &nameCaptureInfo);
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
  xInputs = emlrtCreateLogicalMatrix(1, 14);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("EROS_all_double_set_add_clip1_limit5"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(14.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "ResolvedFilePath",
      emlrtMxCreateString(
          "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
          "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(740052.06930555555));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2973910 (R2025a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("Q5JpjkPUXcBJEcBOtDcX0G"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_EROS_all_double_set_add_clip1_limit5_info.c)
 */
