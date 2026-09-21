/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_EROS_all_double_set_add_clip1_limit5_mex.c
 *
 * Code generation for function
 * '_coder_EROS_all_double_set_add_clip1_limit5_mex'
 *
 */

/* Include files */
#include "_coder_EROS_all_double_set_add_clip1_limit5_mex.h"
#include "EROS_all_double_set_add_clip1_limit5_data.h"
#include "EROS_all_double_set_add_clip1_limit5_initialize.h"
#include "EROS_all_double_set_add_clip1_limit5_terminate.h"
#include "_coder_EROS_all_double_set_add_clip1_limit5_api.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void EROS_all_double_set_add_clip1_limit5_mexFunction(int32_T nlhs,
                                                      mxArray *plhs[1],
                                                      int32_T nrhs,
                                                      const mxArray *prhs[14])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *b_prhs[14];
  const mxArray *outputs;
  int32_T i;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 14) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 14, 4,
                        36, "EROS_all_double_set_add_clip1_limit5");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 36,
                        "EROS_all_double_set_add_clip1_limit5");
  }
  /* Call the function. */
  for (i = 0; i < 14; i++) {
    b_prhs[i] = prhs[i];
  }
  c_EROS_all_double_set_add_clip1(b_prhs, &outputs);
  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, &plhs[0], &outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&EROS_all_double_set_add_clip1_limit5_atexit);
  EROS_all_double_set_add_clip1_limit5_initialize();
  EROS_all_double_set_add_clip1_limit5_mexFunction(nlhs, plhs, nrhs, prhs);
  EROS_all_double_set_add_clip1_limit5_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "windows-1252", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_EROS_all_double_set_add_clip1_limit5_mex.c) */
