/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_EROS_all_double_set_add_clip1_limit5_api.c
 *
 * Code generation for function
 * '_coder_EROS_all_double_set_add_clip1_limit5_api'
 *
 */

/* Include files */
#include "_coder_EROS_all_double_set_add_clip1_limit5_api.h"
#include "EROS_all_double_set_add_clip1_limit5.h"
#include "EROS_all_double_set_add_clip1_limit5_data.h"
#include "EROS_all_double_set_add_clip1_limit5_emxutil.h"
#include "EROS_all_double_set_add_clip1_limit5_types.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo c_emlrtRTEI = {
    1,                                                 /* lineNo */
    1,                                                 /* colNo */
    "_coder_EROS_all_double_set_add_clip1_limit5_api", /* fName */
    ""                                                 /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real_T *y);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, emxArray_uint16_T *y);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_uint16_T *y);

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, emxArray_real_T *y);

static void emlrt_marshallOut(emxArray_real_T *u, const mxArray *y);

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, emxArray_char_T *y);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_char_T *y);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret);

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_uint16_T *ret);

static real_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real_T *y)
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, emxArray_uint16_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_uint16_T *y)
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void emlrt_marshallOut(emxArray_real_T *u, const mxArray *y)
{
  real_T *u_data;
  u_data = u->data;
  emlrtMxSetData((mxArray *)y, &u_data[0]);
  emlrtSetDimensions((mxArray *)y, &u->size[0], 2);
  u->canFreeData = false;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, emxArray_char_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  h_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_char_T *y)
{
  l_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret)
{
  static const int32_T dims[2] = {-1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2] = {true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_uint16_T *ret)
{
  static const int32_T dims = -1;
  int32_T i;
  int32_T i1;
  boolean_T b = true;
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "uint16", false, 1U,
                            (const void *)&dims, &b, &i);
  ret->allocatedSize = i;
  i1 = ret->size[0];
  ret->size[0] = i;
  emxEnsureCapacity_uint16_T(sp, ret, i1, (emlrtRTEInfo *)NULL);
  ret->data = (uint16_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static real_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret)
{
  static const int32_T dims[2] = {1, -1};
  int32_T iv[2];
  int32_T i;
  char_T *ret_data;
  boolean_T bv[2] = {false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret_data = ret->data;
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

void c_EROS_all_double_set_add_clip1(const mxArray *const prhs[14],
                                     const mxArray **plhs)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  emxArray_char_T *eventType;
  emxArray_real_T *frame;
  emxArray_uint16_T *x;
  emxArray_uint16_T *y;
  const mxArray *prhs_copy_idx_0;
  real_T gGAUSS;
  real_T hGAUSS;
  real_T kEROS;
  real_T kEVENT;
  real_T kGAUSS;
  real_T mEVENT;
  real_T r0;
  real_T sGAUSS;
  real_T setEvent;
  real_T setEventTilt;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  /* Marshall function inputs */
  emxInit_real_T(&st, &frame, &c_emlrtRTEI);
  frame->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_0), "frame", frame);
  emxInit_uint16_T(&st, &x, &c_emlrtRTEI);
  x->canFreeData = false;
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "x", x);
  emxInit_uint16_T(&st, &y, &c_emlrtRTEI);
  y->canFreeData = false;
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "y", y);
  kEROS = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "kEROS");
  gGAUSS = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "gGAUSS");
  hGAUSS = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[5]), "hGAUSS");
  kGAUSS = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "kGAUSS");
  r0 = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[7]), "r0");
  sGAUSS = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[8]), "sGAUSS");
  setEvent = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[9]), "setEvent");
  kEVENT = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[10]), "kEVENT");
  setEventTilt = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[11]), "setEventTilt");
  mEVENT = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[12]), "mEVENT");
  emxInit_char_T(&st, &eventType, &c_emlrtRTEI);
  g_emlrt_marshallIn(&st, emlrtAliasP(prhs[13]), "eventType", eventType);
  /* Invoke the target function */
  EROS_all_double_set_add_clip1_limit5(&st, frame, x, y, kEROS, gGAUSS, hGAUSS,
                                       kGAUSS, r0, sGAUSS, setEvent, kEVENT,
                                       setEventTilt, mEVENT, eventType);
  emxFree_char_T(&st, &eventType);
  emxFree_uint16_T(&st, &y);
  emxFree_uint16_T(&st, &x);
  /* Marshall function outputs */
  frame->canFreeData = false;
  emlrt_marshallOut(frame, prhs_copy_idx_0);
  emxFree_real_T(&st, &frame);
  *plhs = prhs_copy_idx_0;
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_EROS_all_double_set_add_clip1_limit5_api.c) */
