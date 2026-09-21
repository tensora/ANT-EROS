/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * EROS_all_double_set_add_clipAny_limit5_terminate.c
 *
 * Code generation for function
 * 'EROS_all_double_set_add_clipAny_limit5_terminate'
 *
 */

/* Include files */
#include "EROS_all_double_set_add_clipAny_limit5_terminate.h"
#include "EROS_all_double_set_add_clipAny_limit5_data.h"
#include "_coder_EROS_all_double_set_add_clipAny_limit5_mex.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void emlrtExitTimeCleanupDtorFcn(const void *r);

/* Function Definitions */
static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void EROS_all_double_set_add_clipAny_limit5_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtPushHeapReferenceStackR2021a(
      &st, false, NULL, (void *)&emlrtExitTimeCleanupDtorFcn, NULL, NULL, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void EROS_all_double_set_add_clipAny_limit5_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (EROS_all_double_set_add_clipAny_limit5_terminate.c)
 */
