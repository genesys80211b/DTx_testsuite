/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_transceive102_energy_mex.c
 *
 * Code generation for function '_coder_transceive102_energy_mex'
 *
 */

/* Include files */
#include "transceive102_energy.h"
#include "_coder_transceive102_energy_mex.h"
#include "transceive102_energy_terminate.h"
#include "_coder_transceive102_energy_api.h"
#include "transceive102_energy_initialize.h"
#include "transceive102_energy_data.h"

/* Variable Definitions */
static transceive102_energyStackData *c_transceive102_energyStackData = NULL;

/* Function Declarations */
static void c_transceive102_energy_mexFunct(transceive102_energyStackData *SD,
  int32_T nlhs, mxArray *plhs[2], int32_T nrhs, const mxArray *prhs[9]);

/* Function Definitions */
static void c_transceive102_energy_mexFunct(transceive102_energyStackData *SD,
  int32_T nlhs, mxArray *plhs[2], int32_T nrhs, const mxArray *prhs[9])
{
  int32_T n;
  const mxArray *inputs[9];
  const mxArray *outputs[2];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 9) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 9, 4,
                        20, "transceive102_energy");
  }

  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 20,
                        "transceive102_energy");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  transceive102_energy_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  transceive102_energy_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  c_transceive102_energyStackData = (transceive102_energyStackData *)mxCalloc(1,
    1U * sizeof(transceive102_energyStackData));
  mexAtExit(transceive102_energy_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  transceive102_energy_initialize();

  /* Dispatch the entry-point. */
  c_transceive102_energy_mexFunct(c_transceive102_energyStackData, nlhs, plhs,
    nrhs, prhs);
  mxFree(c_transceive102_energyStackData);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_transceive102_energy_mex.c) */
