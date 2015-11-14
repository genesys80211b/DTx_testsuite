/*
 * transceive202.c
 *
 * Code generation for function 'transceive202'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "transceive202.h"
#include "SystemCore.h"
#include "SDRuReceiver.h"
#include "SDRuTransmitter.h"
#include "transceive202_data.h"

/* Variable Definitions */
static comm_SDRuReceiver hrx;
static boolean_T hrx_not_empty;
static comm_SDRuTransmitter htx;
static boolean_T htx_not_empty;
static emlrtRSInfo emlrtRSI = { 6, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo b_emlrtRSI = { 11, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo c_emlrtRSI = { 17, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo d_emlrtRSI = { 18, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo e_emlrtRSI = { 20, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo f_emlrtRSI = { 21, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo g_emlrtRSI = { 24, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

static emlrtRSInfo h_emlrtRSI = { 28, "transceive202",
  "/home/bdroz/Documents/MATLAB/test/transceive202.m" };

/* Function Definitions */
void hrx_not_empty_init(void)
{
  hrx_not_empty = false;
}

void htx_not_empty_init(void)
{
  htx_not_empty = false;
}

void transceive202(transceive202StackData *SD, const emlrtStack *sp, const
                   creal_T d2s[1408], real_T ft, creal_T dr[1408], uint32_T *ns)
{
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  memset(&dr[0], 0, 1408U * sizeof(creal_T));
  *ns = 0U;
  if ((!htx_not_empty) || (ft == 0.0)) {
    st.site = &emlrtRSI;
    SDRuTransmitter_SDRuTransmitter(&st, &htx);
    htx_not_empty = true;
  }

  if ((!hrx_not_empty) || (ft == 0.0)) {
    st.site = &b_emlrtRSI;
    SDRuReceiver_SDRuReceiver(&st, &hrx);
    hrx_not_empty = true;
  }

  if (ft == 2.0) {
    st.site = &c_emlrtRSI;
    SystemCore_reset(&st, &hrx);
    st.site = &d_emlrtRSI;
    b_SystemCore_reset(&st, &htx);
  } else if (ft == 3.0) {
    st.site = &e_emlrtRSI;
    SystemCore_release(&st, &hrx);
    st.site = &f_emlrtRSI;
    b_SystemCore_release(&st, &htx);
  } else {
    if (!!htx_not_empty) {
      st.site = &g_emlrtRSI;
      SystemCore_step(&st, &htx, d2s);
    }

    if (!!hrx_not_empty) {
      while (*ns < 1U) {
        st.site = &h_emlrtRSI;
        b_SystemCore_step(SD, &st, &hrx, dr, ns);
        emlrtBreakCheckFastR2012b(emlrtBreakCheckR2012bFlagVar, sp);
      }
    }
  }
}

/* End of code generation (transceive202.c) */
