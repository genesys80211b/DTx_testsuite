/*
 * SystemCore.h
 *
 * Code generation for function 'SystemCore'
 *
 */

#ifndef __SYSTEMCORE_H__
#define __SYSTEMCORE_H__

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
#include "transceive202_types.h"

/* Function Declarations */
extern void SystemCore_release(const emlrtStack *sp, comm_SDRuReceiver *obj);
extern void SystemCore_reset(const emlrtStack *sp, const comm_SDRuReceiver *obj);
extern void SystemCore_step(const emlrtStack *sp, comm_SDRuTransmitter *obj,
  const creal_T varargin_1[1408]);
extern void b_SystemCore_release(const emlrtStack *sp, comm_SDRuTransmitter *obj);
extern void b_SystemCore_reset(const emlrtStack *sp, const comm_SDRuTransmitter *
  obj);
extern void b_SystemCore_step(transceive202StackData *SD, const emlrtStack *sp,
  comm_SDRuReceiver *obj, creal_T varargout_1[1408], uint32_T *varargout_2);

#endif

/* End of code generation (SystemCore.h) */
