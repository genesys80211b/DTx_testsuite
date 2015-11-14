/*
 * SDRuTransmitter.h
 *
 * Code generation for function 'SDRuTransmitter'
 *
 */

#ifndef __SDRUTRANSMITTER_H__
#define __SDRUTRANSMITTER_H__

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
extern comm_SDRuTransmitter *SDRuTransmitter_SDRuTransmitter(const emlrtStack
  *sp, comm_SDRuTransmitter *obj);
extern void SDRuTransmitter_stepImpl(const emlrtStack *sp, const
  comm_SDRuTransmitter *obj, const creal_T x[1408]);

#endif

/* End of code generation (SDRuTransmitter.h) */
