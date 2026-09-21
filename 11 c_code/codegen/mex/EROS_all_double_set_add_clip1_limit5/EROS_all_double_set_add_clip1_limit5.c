/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * EROS_all_double_set_add_clip1_limit5.c
 *
 * Code generation for function 'EROS_all_double_set_add_clip1_limit5'
 *
 */

/* Include files */
#include "EROS_all_double_set_add_clip1_limit5.h"
#include "EROS_all_double_set_add_clip1_limit5_data.h"
#include "EROS_all_double_set_add_clip1_limit5_emxutil.h"
#include "EROS_all_double_set_add_clip1_limit5_types.h"
#include "rt_nonfinite.h"
#include "unsafeSxfun.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    94,                                     /* lineNo */
    "EROS_all_double_set_add_clip1_limit5", /* fcnName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI = {
    57,                                     /* lineNo */
    "EROS_all_double_set_add_clip1_limit5", /* fcnName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pathName */
};

static emlrtRSInfo c_emlrtRSI = {
    56,                                     /* lineNo */
    "EROS_all_double_set_add_clip1_limit5", /* fcnName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pathName */
};

static emlrtRSInfo d_emlrtRSI = {
    40,                                     /* lineNo */
    "EROS_all_double_set_add_clip1_limit5", /* fcnName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pathName */
};

static emlrtMCInfo emlrtMCI = {
    27,      /* lineNo */
    5,       /* colNo */
    "error", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\lang\\error.m" /* pName
                                                                       */
};

static emlrtECInfo emlrtECI = {
    -1,                                     /* nDims */
    102,                                    /* lineNo */
    9,                                      /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtBCInfo emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    102,                                    /* lineNo */
    34,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    102,                                    /* lineNo */
    28,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    102,                                    /* lineNo */
    21,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    102,                                    /* lineNo */
    15,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtECInfo b_emlrtECI = {
    2,                                      /* nDims */
    99,                                     /* lineNo */
    21,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtECInfo c_emlrtECI = {
    1,                                      /* nDims */
    99,                                     /* lineNo */
    21,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtBCInfo e_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    98,                                     /* lineNo */
    51,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    98,                                     /* lineNo */
    45,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    98,                                     /* lineNo */
    38,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    98,                                     /* lineNo */
    32,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    81,                                     /* lineNo */
    16,                                     /* colNo */
    "y",                                    /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    80,                                     /* lineNo */
    16,                                     /* colNo */
    "x",                                    /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtRTEInfo emlrtRTEI = {
    53,                                     /* lineNo */
    16,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtRTEInfo b_emlrtRTEI = {
    52,                                     /* lineNo */
    12,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtDCInfo emlrtDCI = {
    49,                                     /* lineNo */
    24,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    1 /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = {
    49,                                     /* lineNo */
    24,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    4 /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = {
    29,              /* lineNo */
    29,              /* colNo */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    1                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = {
    -1,              /* iFirst */
    -1,              /* iLast */
    29,              /* lineNo */
    29,              /* colNo */
    "smallFrame",    /* aName */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    0                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = {
    29,              /* lineNo */
    41,              /* colNo */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    1                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = {
    -1,              /* iFirst */
    -1,              /* iLast */
    29,              /* lineNo */
    41,              /* colNo */
    "smallFrame",    /* aName */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    0                                    /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = {
    29,              /* lineNo */
    53,              /* colNo */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    1                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = {
    -1,              /* iFirst */
    -1,              /* iLast */
    29,              /* lineNo */
    53,              /* colNo */
    "smallFrame",    /* aName */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    0                                    /* checkKind */
};

static emlrtDCInfo f_emlrtDCI = {
    29,              /* lineNo */
    65,              /* colNo */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    1                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = {
    -1,              /* iFirst */
    -1,              /* iLast */
    29,              /* lineNo */
    65,              /* colNo */
    "smallFrame",    /* aName */
    "limitedKernel", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\00 "
    "helper_functions\\limitedKernel.m", /* pName */
    0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    84,                                     /* lineNo */
    23,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    84,                                     /* lineNo */
    26,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    57,                                     /* lineNo */
    25,                                     /* colNo */
    "decayKernel",                          /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    57,                                     /* lineNo */
    28,                                     /* colNo */
    "decayKernel",                          /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    129,                                    /* lineNo */
    18,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    129,                                    /* lineNo */
    22,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    123,                                    /* lineNo */
    19,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = {
    -1,                                     /* iFirst */
    -1,                                     /* iLast */
    123,                                    /* lineNo */
    23,                                     /* colNo */
    "frame",                                /* aName */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m", /* pName */
    0 /* checkKind */
};

static emlrtRTEInfo d_emlrtRTEI = {
    49,                                     /* lineNo */
    19,                                     /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtRTEInfo f_emlrtRTEI = {
    49,                                     /* lineNo */
    5,                                      /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtRTEInfo g_emlrtRTEI = {
    102,                                    /* lineNo */
    9,                                      /* colNo */
    "EROS_all_double_set_add_clip1_limit5", /* fName */
    "G:\\KTH\\KTH exjobb 2025 - Local\\EROS GUI\\04 "
    "spatial_descriptor\\EROS_all_double_set_add_clip1_limit5.m" /* pName */
};

static emlrtRSInfo g_emlrtRSI = {
    27,      /* lineNo */
    "error", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\lang\\error.m" /* pathName
                                                                       */
};

static emlrtRSInfo h_emlrtRSI =
    {
        31,            /* lineNo */
        "unsafeSxfun", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\eml\\+coder\\+"
        "internal\\unsafeSxfun.m" /* pathName */
};

/* Function Declarations */
static void b_error(const emlrtStack *sp, const mxArray *m, const mxArray *m1,
                    emlrtMCInfo *location);

/* Function Definitions */
static void b_error(const emlrtStack *sp, const mxArray *m, const mxArray *m1,
                    emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b((emlrtConstCTX)sp, 0, NULL, 2, &pArrays[0], "error",
                        true, location);
}

void EROS_all_double_set_add_clip1_limit5(
    const emlrtStack *sp, emxArray_real_T *frame, const emxArray_uint16_T *x,
    const emxArray_uint16_T *y, real_T kEROS, real_T gGAUSS, real_T hGAUSS,
    real_T kGAUSS, real_T r0, real_T sGAUSS, real_T setEvent, real_T kEVENT,
    real_T setEventTilt, real_T mEVENT, const emxArray_char_T *eventType)
{
  static const int32_T iv[2] = {1, 29};
  static const char_T varargin_1[29] = {
      'U', 'n', 'k', 'n', 'o', 'w', 'n', ' ', 'p', 'r', 'o', 'c', 'e', 's', 's',
      'i', 'n', 'g', ' ', 'm', 'e', 't', 'h', 'o', 'd', ':', ' ', '%', 's'};
  static const char_T cv[3] = {'s', 'e', 't'};
  static const char_T cv1[3] = {'a', 'd', 'd'};
  emlrtStack b_st;
  emlrtStack st;
  emxArray_real_T *b_r;
  emxArray_real_T *decayKernel;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *m;
  real_T a;
  real_T r;
  real_T totalKernelSize;
  real_T *decayKernel_data;
  real_T *frame_data;
  real_T *r1;
  int32_T iv1[2];
  int32_T b_i;
  int32_T b_index;
  int32_T exitg1;
  int32_T i;
  int32_T loop_ub;
  int32_T q;
  int32_T xi;
  int32_T xlimit;
  int32_T yi;
  int32_T ylimit;
  const uint16_T *x_data;
  const uint16_T *y_data;
  const char_T *eventType_data;
  boolean_T result;
  (void)kEVENT;
  (void)setEventTilt;
  (void)mEVENT;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  eventType_data = eventType->data;
  y_data = y->data;
  x_data = x->data;
  frame_data = frame->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtConstCTX)sp);
  /* IMPORTANT: save the event in every loop so that it is not overwritten */
  /* By the masks!!! */
  /* ALSO important!! The surface place for the incoming event is set to NAN!!
   * this saves it from */
  /* faulty code trying to add something to it. This is very confusing but */
  /* saves my program from a strange bug where my fluffy kernel tries to */
  /* add itself when it has radius 0. It should actually be turned */
  /* off!!! */
  /* decayKernel = gaussianKernel(kEROS,gGAUSS,hGAUSS,kGAUSS,r0,sGAUSS); */
  /* frame: double [n x m] */
  /* x: uint16 [n x 1] */
  /* y: uint16 [n x 1] */
  /* kEROS double */
  /* hGAUSS double */
  /* kGAUSS double */
  /* r0 double */
  /* sGAUSS double */
  /* setEvent double */
  /* kEVENT double */
  /* setEventTilt double */
  /* mEvent double */
  /* eventType = chararray [1xn] */
  /* Used for adding or setting an event. */
  result = false;
  if (eventType->size[1] == 3) {
    b_index = 0;
    do {
      exitg1 = 0;
      if (b_index < 3) {
        if (cv[b_index] != eventType_data[b_index]) {
          exitg1 = 1;
        } else {
          b_index++;
        }
      } else {
        result = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);
  }
  if (result) {
    b_index = 0;
  } else {
    result = false;
    if (eventType->size[1] == 3) {
      b_index = 0;
      do {
        exitg1 = 0;
        if (b_index < 3) {
          if (cv1[b_index] != eventType_data[b_index]) {
            exitg1 = 1;
          } else {
            b_index++;
          }
        } else {
          result = true;
          exitg1 = 1;
        }
      } while (exitg1 == 0);
    }
    if (result) {
      b_index = 1;
    } else {
      b_index = -1;
    }
  }
  switch (b_index) {
  case 0:
    q = 1;
    break;
  case 1:
    q = 0;
    break;
  default:
    st.site = &d_emlrtRSI;
    b_y = NULL;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(&st, 29, m, &varargin_1[0]);
    emlrtAssign(&b_y, m);
    c_y = NULL;
    iv1[0] = 1;
    iv1[1] = eventType->size[1];
    m = emlrtCreateCharArray(2, &iv1[0]);
    emlrtInitCharArrayR2013a(&st, eventType->size[1], m, &eventType_data[0]);
    emlrtAssign(&c_y, m);
    b_st.site = &g_emlrtRSI;
    b_error(&b_st, b_y, c_y, &emlrtMCI);
    break;
  }
  totalKernelSize = kEROS * 2.0 + 1.0;
  if (!(totalKernelSize >= 0.0)) {
    emlrtNonNegativeCheckR2012b(totalKernelSize, &b_emlrtDCI,
                                (emlrtConstCTX)sp);
  }
  if (totalKernelSize != (int32_T)muDoubleScalarFloor(totalKernelSize)) {
    emlrtIntegerCheckR2012b(totalKernelSize, &emlrtDCI, (emlrtConstCTX)sp);
  }
  loop_ub = (int32_T)totalKernelSize;
  emxInit_real_T(sp, &decayKernel, &f_emlrtRTEI);
  b_index = decayKernel->size[0] * decayKernel->size[1];
  decayKernel->size[0] = (int32_T)totalKernelSize;
  decayKernel->size[1] = (int32_T)totalKernelSize;
  emxEnsureCapacity_real_T(sp, decayKernel, b_index, &d_emlrtRTEI);
  decayKernel_data = decayKernel->data;
  emlrtForLoopVectorCheckR2021a(1.0, 1.0, totalKernelSize, mxDOUBLE_CLASS,
                                (int32_T)totalKernelSize, &b_emlrtRTEI,
                                (emlrtConstCTX)sp);
  for (xi = 0; xi < loop_ub; xi++) {
    emlrtForLoopVectorCheckR2021a(1.0, 1.0, totalKernelSize, mxDOUBLE_CLASS,
                                  (int32_T)totalKernelSize, &emlrtRTEI,
                                  (emlrtConstCTX)sp);
    for (yi = 0; yi < loop_ub; yi++) {
      /* Can be effectivisized maybe by not recalculating for every */
      /* point. Also vectorize possible but not so critical. */
      st.site = &c_emlrtRSI;
      r = (kEROS + 1.0) - ((real_T)xi + 1.0);
      st.site = &c_emlrtRSI;
      a = (kEROS + 1.0) - ((real_T)yi + 1.0);
      st.site = &c_emlrtRSI;
      r = muDoubleScalarSqrt(r * r + a * a);
      st.site = &b_emlrtRSI;
      a = r - r0;
      st.site = &b_emlrtRSI;
      if (((int32_T)((uint32_T)xi + 1U) < 1) ||
          ((int32_T)((uint32_T)xi + 1U) > decayKernel->size[0])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)xi + 1U), 1,
                                      decayKernel->size[0], &q_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      if (((int32_T)((uint32_T)yi + 1U) < 1) ||
          ((int32_T)((uint32_T)yi + 1U) > decayKernel->size[1])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)yi + 1U), 1,
                                      decayKernel->size[1], &r_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      decayKernel_data[xi + decayKernel->size[0] * yi] =
          5.0 / (muDoubleScalarExp(
                     -((gGAUSS + hGAUSS * r) +
                       kGAUSS * muDoubleScalarExp(-(a * a) /
                                                  (2.0 * (sGAUSS * sGAUSS))))) +
                 1.0);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b((emlrtConstCTX)sp);
      }
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  /*  %generate an event with fluffy edges */
  /*  kEVENTMid = kEVENT+1; */
  /*  eventTotalSize = kEVENT*2+1; */
  /*  eventKernel = ones(eventTotalSize); */
  /*  for exi=1:eventTotalSize */
  /*      for eyi=1:eventTotalSize */
  /*          r = sqrt((kEVENTMid-exi)^2+(kEVENTMid-eyi)^2); */
  /*          %eventKernel(exi,eyi) = r*setEventTilt + setEvent; */
  /*          eventKernel(exi,eyi) = 5/( 1 + exp( -( r*setEventTilt + mEVENT ) )
   * ); */
  /*      end */
  /*  end */
  xlimit = frame->size[1];
  ylimit = frame->size[0];
  i = x->size[0];
  emxInit_real_T(sp, &b_r, &g_emlrtRTEI);
  for (b_i = 0; b_i < i; b_i++) {
    real_T e_old;
    int32_T b_e_old_tmp;
    int32_T b_loop_ub;
    int32_T c_loop_ub;
    int32_T e_old_tmp;
    int32_T i1;
    int32_T i10;
    int32_T i11;
    int32_T i12;
    int32_T i2;
    int32_T i3;
    int32_T i4;
    int32_T i5;
    int32_T i6;
    int32_T i7;
    int32_T i8;
    int32_T i9;
    uint16_T wxmax;
    uint16_T wxmin;
    uint16_T wymax;
    uint16_T wymin;
    if (b_i + 1 > i) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, i, &j_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (b_i + 1 > y->size[0]) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, y->size[0], &i_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    /* IMPORTANT: save the event. Otherwise the two masks overwrite it! */
    i1 = frame->size[0];
    if ((y_data[b_i] < 1) || (y_data[b_i] > i1)) {
      emlrtDynamicBoundsCheckR2012b(y_data[b_i], 1, i1, &o_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    i2 = frame->size[1];
    if ((x_data[b_i] < 1) || (x_data[b_i] > i2)) {
      emlrtDynamicBoundsCheckR2012b(x_data[b_i], 1, i2, &p_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    e_old_tmp = y_data[b_i] - 1;
    b_e_old_tmp = x_data[b_i] - 1;
    e_old = frame_data[e_old_tmp + frame->size[0] * b_e_old_tmp];
    /* Limit the X-scale windows */
    loop_ub = x_data[b_i];
    r = muDoubleScalarRound((real_T)loop_ub - kEROS);
    if (r < 65536.0) {
      if (r >= 0.0) {
        wxmin = (uint16_T)r;
      } else {
        wxmin = 0U;
      }
    } else if (r >= 65536.0) {
      wxmin = MAX_uint16_T;
    } else {
      wxmin = 0U;
    }
    if (wxmin < 1) {
      wxmin = 1U;
    }
    r = muDoubleScalarRound((real_T)loop_ub + kEROS);
    if (r < 65536.0) {
      if (r >= 0.0) {
        wxmax = (uint16_T)r;
      } else {
        wxmax = 0U;
      }
    } else if (r >= 65536.0) {
      wxmax = MAX_uint16_T;
    } else {
      wxmax = 0U;
    }
    if (wxmax > xlimit) {
      wxmax = (uint16_T)xlimit;
    }
    /* Limit the Y-scale windows */
    b_index = y_data[b_i];
    r = muDoubleScalarRound((real_T)b_index - kEROS);
    if (r < 65536.0) {
      if (r >= 0.0) {
        wymin = (uint16_T)r;
      } else {
        wymin = 0U;
      }
    } else if (r >= 65536.0) {
      wymin = MAX_uint16_T;
    } else {
      wymin = 0U;
    }
    if (wymin < 1) {
      wymin = 1U;
    }
    r = muDoubleScalarRound((real_T)b_index + kEROS);
    if (r < 65536.0) {
      if (r >= 0.0) {
        wymax = (uint16_T)r;
      } else {
        wymax = 0U;
      }
    } else if (r >= 65536.0) {
      wymax = MAX_uint16_T;
    } else {
      wymax = 0U;
    }
    if (wymax > ylimit) {
      wymax = (uint16_T)ylimit;
    }
    st.site = &emlrtRSI;
    totalKernelSize = ((real_T)decayKernel->size[0] - 1.0) / 2.0;
    /* 1.) Unlimited global small frame limits. */
    /* 2.) Limited global small frame limits. */
    /* 3.) Calculate differences */
    a = (real_T)b_index + totalKernelSize;
    r = (real_T)decayKernel->size[0] -
        (a - muDoubleScalarMin(a, frame->size[0]));
    a = (real_T)b_index - totalKernelSize;
    a = 1.0 - (a - muDoubleScalarMax(a, 1.0));
    if (a > r) {
      i3 = 0;
      i4 = 0;
    } else {
      if (a != muDoubleScalarFloor(a)) {
        emlrtIntegerCheckR2012b(a, &c_emlrtDCI, &st);
      }
      if (((int32_T)a < 1) || ((int32_T)a > decayKernel->size[0])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)a, 1, decayKernel->size[0],
                                      &k_emlrtBCI, &st);
      }
      i3 = (int32_T)a - 1;
      if (r != (int32_T)muDoubleScalarFloor(r)) {
        emlrtIntegerCheckR2012b(r, &d_emlrtDCI, &st);
      }
      if (((int32_T)r < 1) || ((int32_T)r > decayKernel->size[0])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)r, 1, decayKernel->size[0],
                                      &l_emlrtBCI, &st);
      }
      i4 = (int32_T)r;
    }
    a = (real_T)loop_ub + totalKernelSize;
    r = (real_T)decayKernel->size[0] -
        (a - muDoubleScalarMin(a, frame->size[1]));
    a = (real_T)loop_ub - totalKernelSize;
    a = 1.0 - (a - muDoubleScalarMax(a, 1.0));
    if (a > r) {
      i5 = 0;
      b_index = 0;
    } else {
      if (a != muDoubleScalarFloor(a)) {
        emlrtIntegerCheckR2012b(a, &e_emlrtDCI, &st);
      }
      if (((int32_T)a < 1) || ((int32_T)a > decayKernel->size[1])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)a, 1, decayKernel->size[1],
                                      &m_emlrtBCI, &st);
      }
      i5 = (int32_T)a - 1;
      if (r != (int32_T)muDoubleScalarFloor(r)) {
        emlrtIntegerCheckR2012b(r, &f_emlrtDCI, &st);
      }
      if (((int32_T)r < 1) || ((int32_T)r > decayKernel->size[1])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)r, 1, decayKernel->size[1],
                                      &n_emlrtBCI, &st);
      }
      b_index = (int32_T)r;
    }
    /* Multiply a submatrix block with the total decay for both */
    /* polarities. */
    if (wymin > wymax) {
      i6 = 0;
      loop_ub = 0;
    } else {
      if ((wymin < 1) || (wymin > i1)) {
        emlrtDynamicBoundsCheckR2012b(wymin, 1, i1, &h_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i6 = wymin - 1;
      if ((wymax < 1) || (wymax > i1)) {
        emlrtDynamicBoundsCheckR2012b(wymax, 1, i1, &g_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      loop_ub = wymax;
    }
    if (wxmin > wxmax) {
      i7 = 0;
      i8 = 0;
    } else {
      if ((wxmin < 1) || (wxmin > i2)) {
        emlrtDynamicBoundsCheckR2012b(wxmin, 1, i2, &f_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i7 = wxmin - 1;
      if ((wxmax < 1) || (wxmax > i2)) {
        emlrtDynamicBoundsCheckR2012b(wxmax, 1, i2, &e_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i8 = wxmax;
    }
    b_loop_ub = loop_ub - i6;
    i9 = i4 - i3;
    if ((b_loop_ub != i9) && ((b_loop_ub != 1) && (i9 != 1))) {
      emlrtDimSizeImpxCheckR2021b(b_loop_ub, i9, &c_emlrtECI,
                                  (emlrtConstCTX)sp);
    }
    c_loop_ub = i8 - i7;
    i10 = b_index - i5;
    if ((c_loop_ub != i10) && ((c_loop_ub != 1) && (i10 != 1))) {
      emlrtDimSizeImpxCheckR2021b(c_loop_ub, i10, &b_emlrtECI,
                                  (emlrtConstCTX)sp);
    }
    /* We clip the regio to max 1 for every event update!! */
    if (wymin > wymax) {
      i11 = 0;
      i1 = 0;
    } else {
      if (wymin > i1) {
        emlrtDynamicBoundsCheckR2012b(wymin, 1, i1, &d_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i11 = wymin - 1;
      if (wymax > i1) {
        emlrtDynamicBoundsCheckR2012b(wymax, 1, i1, &c_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i1 = wymax;
    }
    if (wxmin > wxmax) {
      i12 = 0;
      i2 = 0;
    } else {
      if (wxmin > i2) {
        emlrtDynamicBoundsCheckR2012b(wxmin, 1, i2, &b_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i12 = wxmin - 1;
      if (wxmax > i2) {
        emlrtDynamicBoundsCheckR2012b(wxmax, 1, i2, &emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      i2 = wxmax;
    }
    if ((b_loop_ub == i9) && (c_loop_ub == i10)) {
      b_index = b_r->size[0] * b_r->size[1];
      b_r->size[0] = b_loop_ub;
      b_r->size[1] = c_loop_ub;
      emxEnsureCapacity_real_T(sp, b_r, b_index, &e_emlrtRTEI);
      r1 = b_r->data;
      for (xi = 0; xi < c_loop_ub; xi++) {
        for (yi = 0; yi < b_loop_ub; yi++) {
          r = frame_data[(i6 + yi) + frame->size[0] * (i7 + xi)] *
              decayKernel_data[(i3 + yi) + decayKernel->size[0] * (i5 + xi)];
          r1[yi + b_r->size[0] * xi] = muDoubleScalarMin(r, 1.0);
        }
      }
    } else {
      st.site = &h_emlrtRSI;
      binary_expand_op(&st, b_r, frame, i6, loop_ub, i7, i8, decayKernel, i3,
                       i4, i5, b_index);
      r1 = b_r->data;
    }
    loop_ub = i1 - i11;
    iv1[0] = loop_ub;
    b_index = i2 - i12;
    iv1[1] = b_index;
    emlrtSubAssignSizeCheckR2012b(&iv1[0], 2, &b_r->size[0], 2, &emlrtECI,
                                  (emlrtCTX)sp);
    for (xi = 0; xi < b_index; xi++) {
      for (yi = 0; yi < loop_ub; yi++) {
        frame_data[(i11 + yi) + frame->size[0] * (i12 + xi)] =
            r1[yi + loop_ub * xi];
      }
    }
    /*  %%%%THIS IS CODE FOR ADDING A variable even */
    /*   */
    /*  %Limit the X-scale windows */
    /*  wxmin2 = max(ex-kEVENT, 1); */
    /*  wxmax2 = min(ex+kEVENT, xlimit); */
    /*   */
    /*  %Limit the Y-scale windows */
    /*  wymin2 = max(ey-kEVENT, 1); */
    /*  wymax2 = min(ey+kEVENT, ylimit); */
    /*   */
    /*  limitedEventKernel = limitedKernel(ex,ey,eventKernel,frame); */
    /*  previousRegion = frame(wymin2:wymax2, wxmin2:wxmax2); */
    /*  newRegion = previousRegion+limitedEventKernel; */
    /*  frame(wymin2:wymax2, wxmin2:wxmax2) = newRegion; */
    /* SET: overwrite the existing value with value in setEvent */
    if (q == 1) {
      /* clip here also! */
      b_index = frame->size[0];
      if ((y_data[b_i] < 1) || (y_data[b_i] > b_index)) {
        emlrtDynamicBoundsCheckR2012b(y_data[b_i], 1, b_index, &u_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      b_index = frame->size[1];
      if ((x_data[b_i] < 1) || (x_data[b_i] > b_index)) {
        emlrtDynamicBoundsCheckR2012b(x_data[b_i], 1, b_index, &v_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      frame_data[e_old_tmp + frame->size[0] * b_e_old_tmp] =
          muDoubleScalarMin(setEvent, 1.0);
      /* ADD:add the value in setEvent to the existing value */
    } else {
      /* clip here tooo */
      b_index = frame->size[0];
      if ((y_data[b_i] < 1) || (y_data[b_i] > b_index)) {
        emlrtDynamicBoundsCheckR2012b(y_data[b_i], 1, b_index, &s_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      b_index = frame->size[1];
      if ((x_data[b_i] < 1) || (x_data[b_i] > b_index)) {
        emlrtDynamicBoundsCheckR2012b(x_data[b_i], 1, b_index, &t_emlrtBCI,
                                      (emlrtConstCTX)sp);
      }
      frame_data[e_old_tmp + frame->size[0] * b_e_old_tmp] =
          muDoubleScalarMin(e_old + setEvent, 1.0);
    }
    /*   if i == 100000 */
    /*       ibreak = i; */
    /*  end */
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  emxFree_real_T(sp, &b_r);
  emxFree_real_T(sp, &decayKernel);
  /* limiting the max values to one, pretty fast function. */
  /* seems to be a bit problematic to set events = 1 or bigger */
  /* result should maybe be limited between every event instead of in the */
  /* end of the frame? */
  /* frame = min(frame,1); */
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtConstCTX)sp);
}

/* End of code generation (EROS_all_double_set_add_clip1_limit5.c) */
