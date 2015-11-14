/*
 * _coder_rffe_mex.c
 *
 * Code generation for function 'rffe'
 *
 */

/* Include files */
#include "mex.h"
#include "rffe.h"

/* Function Declarations */
static void rffe_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]);

/* Variable Definitions */
emlrtContext emlrtContextGlobal = { true, false, EMLRT_VERSION_INFO, NULL, "rffe", NULL, false, {1243040238U,2922221574U,364785632U,2381482960U}, NULL };
void *emlrtRootTLSGlobal = NULL;

/* Function Definitions */
static void rffe_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const mxArray *outputs[1];
  const mxArray *inputs[5];
  int n = 0;
  int nOutputs = (nlhs < 1 ? 1 : nlhs);
  int nInputs = nrhs;
  emlrtStack st = { NULL, NULL, NULL };
  rffeStackData* rffeStackDataLocal = (rffeStackData*)mxCalloc(1,sizeof(rffeStackData));
  /* Module initialization. */
  rffe_initialize(&emlrtContextGlobal);
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs < 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooFewInputsConstants", 9, mxCHAR_CLASS, (int)strlen(mexFunctionName()), mexFunctionName(), mxCHAR_CLASS, 4, "rffe", mxCHAR_CLASS, 4, "rffe");
  }
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, mxINT32_CLASS, 5, mxCHAR_CLASS, 4, "rffe");
  } else if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, mxCHAR_CLASS, 4, "rffe");
  }
  /* Temporary copy for mex inputs. */
  for (n = 0; n < nInputs; ++n) {
    inputs[n] = prhs[n];
  }
  /* Call the function. */
  rffe_api(rffeStackDataLocal, inputs, outputs);
  /* Copy over outputs to the caller. */
  for (n = 0; n < nOutputs; ++n) {
    plhs[n] = emlrtReturnArrayR2009a(outputs[n]);
  }
  /* Module finalization. */
  rffe_terminate();
  mxFree(rffeStackDataLocal);
}

void rffe_atexit_wrapper(void)
{
   rffe_atexit();
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* Initialize the memory manager. */
  mexAtExit(rffe_atexit_wrapper);
  /* Dispatch the entry-point. */
  rffe_mexFunction(nlhs, plhs, nrhs, prhs);
}
/* End of code generation (_coder_rffe_mex.c) */
