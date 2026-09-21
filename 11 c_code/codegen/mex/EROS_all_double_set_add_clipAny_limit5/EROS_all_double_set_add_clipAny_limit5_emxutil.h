/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * EROS_all_double_set_add_clipAny_limit5_emxutil.h
 *
 * Code generation for function 'EROS_all_double_set_add_clipAny_limit5_emxutil'
 *
 */

#pragma once

/* Include files */
#include "EROS_all_double_set_add_clipAny_limit5_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void emxEnsureCapacity_char_T(const emlrtStack *sp, emxArray_char_T *emxArray,
                              int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real_T(const emlrtStack *sp, emxArray_real_T *emxArray,
                              int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_uint16_T(const emlrtStack *sp,
                                emxArray_uint16_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxFree_char_T(const emlrtStack *sp, emxArray_char_T **pEmxArray);

void emxFree_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray);

void emxFree_uint16_T(const emlrtStack *sp, emxArray_uint16_T **pEmxArray);

void emxInit_char_T(const emlrtStack *sp, emxArray_char_T **pEmxArray,
                    const emlrtRTEInfo *srcLocation);

void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
                    const emlrtRTEInfo *srcLocation);

void emxInit_uint16_T(const emlrtStack *sp, emxArray_uint16_T **pEmxArray,
                      const emlrtRTEInfo *srcLocation);

/* End of code generation (EROS_all_double_set_add_clipAny_limit5_emxutil.h) */
