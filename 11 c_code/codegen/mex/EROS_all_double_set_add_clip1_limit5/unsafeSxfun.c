/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * unsafeSxfun.c
 *
 * Code generation for function 'unsafeSxfun'
 *
 */

/* Include files */
#include "unsafeSxfun.h"
#include "EROS_all_double_set_add_clip1_limit5_data.h"
#include "EROS_all_double_set_add_clip1_limit5_emxutil.h"
#include "EROS_all_double_set_add_clip1_limit5_types.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtRTEInfo h_emlrtRTEI = {
    99,                                     /* lineNo */
    21,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

/* Function Definitions */
void binary_expand_op(const emlrtStack *sp, emxArray_real_T *in1,
                      const emxArray_real_T *in3, int32_T in4, int32_T in5,
                      int32_T in6, int32_T in7, const emxArray_real_T *in8,
                      int32_T in9, int32_T in10, int32_T in11, int32_T in12)
{
  emxArray_real_T *b_in3;
  const real_T *in3_data;
  const real_T *in8_data;
  real_T *b_in3_data;
  real_T *in1_data;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b_loop_ub;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T loop_ub;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  in8_data = in8->data;
  in3_data = in3->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtConstCTX)sp);
  emxInit_real_T(sp, &b_in3, &h_emlrtRTEI);
  stride_1_0 = in10 - in9;
  stride_1_1 = in5 - in4;
  if (stride_1_0 == 1) {
    loop_ub = stride_1_1;
  } else {
    loop_ub = stride_1_0;
  }
  aux_0_1 = b_in3->size[0] * b_in3->size[1];
  b_in3->size[0] = loop_ub;
  i = in12 - in11;
  aux_1_1 = in7 - in6;
  if (i == 1) {
    b_loop_ub = aux_1_1;
  } else {
    b_loop_ub = i;
  }
  b_in3->size[1] = b_loop_ub;
  emxEnsureCapacity_real_T(sp, b_in3, aux_0_1, &h_emlrtRTEI);
  b_in3_data = b_in3->data;
  stride_0_0 = (stride_1_1 != 1);
  stride_0_1 = (aux_1_1 != 1);
  stride_1_0 = (stride_1_0 != 1);
  stride_1_1 = (i != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  for (i1 = 0; i1 < b_loop_ub; i1++) {
    for (i2 = 0; i2 < loop_ub; i2++) {
      b_in3_data[i2 + b_in3->size[0] * i1] =
          in3_data[(in4 + i2 * stride_0_0) + in3->size[0] * (in6 + aux_0_1)] *
          in8_data[(in9 + i2 * stride_1_0) + in8->size[0] * (in11 + aux_1_1)];
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
  stride_1_1 = in1->size[0] * in1->size[1];
  in1->size[0] = loop_ub;
  in1->size[1] = b_loop_ub;
  emxEnsureCapacity_real_T(sp, in1, stride_1_1, &e_emlrtRTEI);
  in1_data = in1->data;
  for (i1 = 0; i1 < b_loop_ub; i1++) {
    for (i2 = 0; i2 < loop_ub; i2++) {
      real_T varargin_1;
      varargin_1 = b_in3_data[i2 + b_in3->size[0] * i1];
      in1_data[i2 + in1->size[0] * i1] = muDoubleScalarMin(varargin_1, 1.0);
    }
  }
  emxFree_real_T(sp, &b_in3);
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtConstCTX)sp);
}

/* End of code generation (unsafeSxfun.c) */
