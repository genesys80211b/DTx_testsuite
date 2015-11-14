/*
 * _coder_transceive102_mex.c
 *
 * Code generation for function 'transceive102'
 *
 */

/* Include files */
#include "mex.h"
#include "_coder_transceive102_api.h"
#include "transceive102_initialize.h"
#include "transceive102_terminate.h"

/* Function Declarations */
static void transceive102_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]);

/* Variable Definitions */
emlrtContext emlrtContextGlobal = { true, false, EMLRT_VERSION_INFO, NULL, "transceive102", NULL, false, {3024490070U,1960474184U,2004393916U,2615046318U}, NULL };
void *emlrtRootTLSGlobal = NULL;

/* Function Definitions */
static void transceive102_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const mxArray *outputs[2];
  const mxArray *inputs[2];
  int n = 0;
  int nOutputs = (nlhs < 1 ? 1 : nlhs);
  int nInputs = nrhs;
  emlrtStack st = { NULL, NULL, NULL };
  transceive102StackData* transceive102StackDataLocal = (transceive102StackData*)mxCalloc(1,sizeof(transceive102StackData));
  /* Module initialization. */
  transceive102_initialize(&emlrtContextGlobal);
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, mxINT32_CLASS, 2, mxCHAR_CLASS, 13, "transceive102");
  } else if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, mxCHAR_CLASS, 13, "transceive102");
  }
  /* Temporary copy for mex inputs. */
  for (n = 0; n < nInputs; ++n) {
    inputs[n] = prhs[n];
  }
  /* Call the function. */
  transceive102_api(transceive102StackDataLocal, inputs, outputs);
  /* Copy over outputs to the caller. */
  for (n = 0; n < nOutputs; ++n) {
    plhs[n] = emlrtReturnArrayR2009a(outputs[n]);
  }
  /* Module finalization. */
  transceive102_terminate();
  mxFree(transceive102StackDataLocal);
}

void transceive102_atexit_wrapper(void)
{
   transceive102_atexit();
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* Initialize the memory manager. */
  mexAtExit(transceive102_atexit_wrapper);
  /* Dispatch the entry-point. */
  transceive102_mexFunction(nlhs, plhs, nrhs, prhs);
}
/* End of code generation (_coder_transceive102_mex.c) */
