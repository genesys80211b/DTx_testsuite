/*
 * transceive102_mexutil.h
 *
 * Code generation for function 'transceive102_mexutil'
 *
 */

#ifndef __TRANSCEIVE102_MEXUTIL_H__
#define __TRANSCEIVE102_MEXUTIL_H__

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
#include "transceive102_types.h"

/* Function Declarations */
extern void c_error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo
                    *location);
extern const mxArray *message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location);
extern const mxArray *sdruroot(const emlrtStack *sp, emlrtMCInfo *location);
extern void setupsdru(const emlrtStack *sp, const mxArray *b, const mxArray *c,
                      emlrtMCInfo *location);

#endif

/* End of code generation (transceive102_mexutil.h) */
