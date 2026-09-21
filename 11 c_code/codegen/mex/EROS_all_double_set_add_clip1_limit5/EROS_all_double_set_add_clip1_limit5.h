/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * EROS_all_double_set_add_clip1_limit5.h
 *
 * Code generation for function 'EROS_all_double_set_add_clip1_limit5'
 *
 */

#pragma once

/* Include files */
#include "EROS_all_double_set_add_clip1_limit5_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void EROS_all_double_set_add_clip1_limit5(
    const emlrtStack *sp, emxArray_real_T *frame, const emxArray_uint16_T *x,
    const emxArray_uint16_T *y, real_T kEROS, real_T gGAUSS, real_T hGAUSS,
    real_T kGAUSS, real_T r0, real_T sGAUSS, real_T setEvent, real_T kEVENT,
    real_T setEventTilt, real_T mEVENT, const emxArray_char_T *eventType);

/* End of code generation (EROS_all_double_set_add_clip1_limit5.h) */
