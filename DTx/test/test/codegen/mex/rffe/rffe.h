/*
 * rffe.h
 *
 * Code generation for function 'rffe'
 *
 */

#ifndef __RFFE_H__
#define __RFFE_H__

/* Include files */
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "rffe_types.h"

/* Variable Declarations */
extern emlrtRSInfo m_emlrtRSI;
extern emlrtRSInfo q_emlrtRSI;
extern emlrtRSInfo r_emlrtRSI;
extern emlrtRSInfo s_emlrtRSI;
extern emlrtRSInfo w_emlrtRSI;
extern emlrtRSInfo x_emlrtRSI;
extern emlrtRSInfo cb_emlrtRSI;
extern emlrtRSInfo db_emlrtRSI;
extern emlrtRSInfo gb_emlrtRSI;
extern emlrtRSInfo pb_emlrtRSI;
extern emlrtRSInfo qb_emlrtRSI;
extern rffeStackData *rffeStackDataLocal;

/* Function Declarations */
extern void rffe(rffeStackData *SD, const emlrtStack *sp, const creal_T df[1408],
                 boolean_T ft, creal_T dfr[704]);
extern void rffe_api(rffeStackData *SD, const mxArray * const prhs[5], const
                     mxArray *plhs[1]);
extern void rffe_atexit(void);
extern void rffe_initialize(emlrtContext *aContext);
extern void rffe_terminate(void);

#endif

/* End of code generation (rffe.h) */
