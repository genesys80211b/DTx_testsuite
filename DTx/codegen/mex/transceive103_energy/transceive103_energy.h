/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * transceive103_energy.h
 *
 * Code generation for function 'transceive103_energy'
 *
 */

#ifndef __TRANSCEIVE103_ENERGY_H__
#define __TRANSCEIVE103_ENERGY_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "transceive103_energy_types.h"

/* Function Declarations */
extern void hrx_not_empty_init(void);
extern void htx_not_empty_init(void);
extern void transceive103_energy(transceive103_energyStackData *SD, const
  emlrtStack *sp, const creal_T d2s[1408], boolean_T ft, real_T txGain, real_T
  rxGain, real_T centerFreqTx, real_T centerFreqRx, real_T intFactor, real_T
  decFactor, real_T flag, creal_T dr[1408], uint32_T *ns);

#endif

/* End of code generation (transceive103_energy.h) */
