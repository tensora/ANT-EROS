/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * EROS_all_double_set_add_clipAny_limit5_initialize.c
 *
 * Code generation for function
 * 'EROS_all_double_set_add_clipAny_limit5_initialize'
 *
 */

/* Include files */
#include "EROS_all_double_set_add_clipAny_limit5_initialize.h"
#include "EROS_all_double_set_add_clipAny_limit5_data.h"
#include "_coder_EROS_all_double_set_add_clipAny_limit5_mex.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void EROS_all_double_set_add_clipAny_limit5_once(void);

/* Function Definitions */
static void EROS_all_double_set_add_clipAny_limit5_once(void)
{
  mex_InitInfAndNan();
}

void EROS_all_double_set_add_clipAny_limit5_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    EROS_all_double_set_add_clipAny_limit5_once();
  }
}

/* End of code generation (EROS_all_double_set_add_clipAny_limit5_initialize.c)
 */
