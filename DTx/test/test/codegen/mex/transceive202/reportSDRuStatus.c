/*
 * reportSDRuStatus.c
 *
 * Code generation for function 'reportSDRuStatus'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "transceive202.h"
#include "reportSDRuStatus.h"
#include "SystemCore.h"
#include "transceive202_mexutil.h"
#include "transceive202_data.h"

/* Variable Definitions */
static emlrtRSInfo fb_emlrtRSI = { 106, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

static emlrtRSInfo gb_emlrtRSI = { 96, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

static emlrtRSInfo hb_emlrtRSI = { 86, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

static emlrtRSInfo ib_emlrtRSI = { 76, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

static emlrtRSInfo jb_emlrtRSI = { 65, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

static emlrtRSInfo kb_emlrtRSI = { 48, "reportSDRuStatus",
  "/usr/local/MATLAB/R2014b/SupportPackages/usrpradio/toolbox/shared/sdr/sdru/reportSDRuStatus.m"
};

/* Function Declarations */
static const mxArray *b_message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, const mxArray *d, emlrtMCInfo *location);

/* Function Definitions */
static const mxArray *b_message(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, const mxArray *d, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m22;
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  return emlrtCallMATLABR2012b(sp, 1, &m22, 3, pArrays, "message", true,
    location);
}

void reportSDRuStatus(const emlrtStack *sp, UsrpErrorCapiEnumT errStatus, const
                      char_T errMsg_data[], const int32_T errMsg_size[2])
{
  const mxArray *y;
  static const int32_T iv20[2] = { 1, 35 };

  const mxArray *m9;
  char_T cv39[35];
  int32_T i;
  static const char_T cv40[35] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'N', 'o',
    't', 'C', 'o', 'm', 'p', 'a', 't', 'i', 'b', 'l', 'e' };

  const mxArray *b_y;
  static const int32_T iv21[2] = { 1, 12 };

  char_T cv41[12];
  static const char_T cv42[12] = { '1', '9', '2', '.', '1', '6', '8', '.', '2',
    '0', '.', '2' };

  const mxArray *c_y;
  static const int32_T iv22[2] = { 1, 43 };

  char_T cv43[43];
  static const char_T cv44[43] = { 'r', 'e', 't', 'u', 'r', 'n', 'e', 'd', ' ',
    'b', 'y', ' ', '\'', 'g', 'e', 't', 'S', 'D', 'R', 'u', 'D', 'r', 'i', 'v',
    'e', 'r', 'V', 'e', 'r', 's', 'i', 'o', 'n', '\'', ' ', 'f', 'u', 'n', 'c',
    't', 'i', 'o', 'n' };

  const mxArray *d_y;
  static const int32_T iv23[2] = { 1, 35 };

  static const char_T cv45[35] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'N', 'o',
    't', 'R', 'e', 's', 'p', 'o', 'n', 'd', 'i', 'n', 'g' };

  const mxArray *e_y;
  static const int32_T iv24[2] = { 1, 12 };

  const mxArray *f_y;
  static const int32_T iv25[2] = { 1, 28 };

  char_T cv46[28];
  static const char_T cv47[28] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'R', 'x',
    'B', 'u', 's', 'y' };

  const mxArray *g_y;
  static const int32_T iv26[2] = { 1, 12 };

  const mxArray *h_y;
  static const int32_T iv27[2] = { 1, 28 };

  static const char_T cv48[28] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'T', 'x',
    'B', 'u', 's', 'y' };

  const mxArray *i_y;
  static const int32_T iv28[2] = { 1, 12 };

  const mxArray *j_y;
  static const int32_T iv29[2] = { 1, 26 };

  char_T cv49[26];
  static const char_T cv50[26] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'B', 'u',
    's', 'y' };

  const mxArray *k_y;
  static const int32_T iv30[2] = { 1, 12 };

  const mxArray *l_y;
  static const int32_T iv31[2] = { 1, 35 };

  static const char_T cv51[35] = { 's', 'd', 'r', 'u', ':', 'r', 'e', 'p', 'o',
    'r', 't', 'S', 'D', 'R', 'u', 'S', 't', 'a', 't', 'u', 's', ':', 'U', 'n',
    'k', 'n', 'o', 'w', 'n', 'S', 't', 'a', 't', 'u', 's' };

  int32_T u_size[2];
  int32_T i10;
  char_T u_data[1024];
  const mxArray *m_y;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;

  /* reportSDRuStatus SDRu status reporter */
  /*    reportSDRuStatus(STATUS,MSG,IP,METHOD) reports the SDRu status based on */
  /*    the STATUS input. STATUS is a UsrpErrorCapiEnumT type. IP is the IP */
  /*    address of the USRP(R) radio. METHOD is a UsrpReportMethodEnumT type and */
  /*    can be Warning, Error , or None. */
  /*  */
  /*    USRP(R) is a trademark of National Instruments Corp. */
  /*    Copyright 2012-2014 The MathWorks, Inc. */
  switch (errStatus) {
   case UsrpDriverNotCompatible:
    st.site = &kb_emlrtRSI;
    if (!(errStatus == UsrpDriverNotCompatible)) {
    } else {
      y = NULL;
      m9 = emlrtCreateCharArray(2, iv20);
      for (i = 0; i < 35; i++) {
        cv39[i] = cv40[i];
      }

      emlrtInitCharArrayR2013a(&st, 35, m9, cv39);
      emlrtAssign(&y, m9);
      b_y = NULL;
      m9 = emlrtCreateCharArray(2, iv21);
      for (i = 0; i < 12; i++) {
        cv41[i] = cv42[i];
      }

      emlrtInitCharArrayR2013a(&st, 12, m9, cv41);
      emlrtAssign(&b_y, m9);
      c_y = NULL;
      m9 = emlrtCreateCharArray(2, iv22);
      for (i = 0; i < 43; i++) {
        cv43[i] = cv44[i];
      }

      emlrtInitCharArrayR2013a(&st, 43, m9, cv43);
      emlrtAssign(&c_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, b_message(&b_st, y, b_y, c_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;

   case UsrpDriverNotResponding:
    st.site = &jb_emlrtRSI;
    if (!(errStatus == UsrpDriverNotResponding)) {
    } else {
      d_y = NULL;
      m9 = emlrtCreateCharArray(2, iv23);
      for (i = 0; i < 35; i++) {
        cv39[i] = cv45[i];
      }

      emlrtInitCharArrayR2013a(&st, 35, m9, cv39);
      emlrtAssign(&d_y, m9);
      e_y = NULL;
      m9 = emlrtCreateCharArray(2, iv24);
      for (i = 0; i < 12; i++) {
        cv41[i] = cv42[i];
      }

      emlrtInitCharArrayR2013a(&st, 12, m9, cv41);
      emlrtAssign(&e_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, message(&b_st, d_y, e_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;

   case UsrpDriverRxBusy:
    st.site = &ib_emlrtRSI;
    if (!(errStatus == UsrpDriverRxBusy)) {
    } else {
      f_y = NULL;
      m9 = emlrtCreateCharArray(2, iv25);
      for (i = 0; i < 28; i++) {
        cv46[i] = cv47[i];
      }

      emlrtInitCharArrayR2013a(&st, 28, m9, cv46);
      emlrtAssign(&f_y, m9);
      g_y = NULL;
      m9 = emlrtCreateCharArray(2, iv26);
      for (i = 0; i < 12; i++) {
        cv41[i] = cv42[i];
      }

      emlrtInitCharArrayR2013a(&st, 12, m9, cv41);
      emlrtAssign(&g_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, message(&b_st, f_y, g_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;

   case UsrpDriverTxBusy:
    st.site = &hb_emlrtRSI;
    if (!(errStatus == UsrpDriverTxBusy)) {
    } else {
      h_y = NULL;
      m9 = emlrtCreateCharArray(2, iv27);
      for (i = 0; i < 28; i++) {
        cv46[i] = cv48[i];
      }

      emlrtInitCharArrayR2013a(&st, 28, m9, cv46);
      emlrtAssign(&h_y, m9);
      i_y = NULL;
      m9 = emlrtCreateCharArray(2, iv28);
      for (i = 0; i < 12; i++) {
        cv41[i] = cv42[i];
      }

      emlrtInitCharArrayR2013a(&st, 12, m9, cv41);
      emlrtAssign(&i_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, message(&b_st, h_y, i_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;

   case UsrpDriverBusy:
    st.site = &gb_emlrtRSI;
    if (!(errStatus == UsrpDriverBusy)) {
    } else {
      j_y = NULL;
      m9 = emlrtCreateCharArray(2, iv29);
      for (i = 0; i < 26; i++) {
        cv49[i] = cv50[i];
      }

      emlrtInitCharArrayR2013a(&st, 26, m9, cv49);
      emlrtAssign(&j_y, m9);
      k_y = NULL;
      m9 = emlrtCreateCharArray(2, iv30);
      for (i = 0; i < 12; i++) {
        cv41[i] = cv42[i];
      }

      emlrtInitCharArrayR2013a(&st, 12, m9, cv41);
      emlrtAssign(&k_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, message(&b_st, j_y, k_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;

   case UsrpDriverError:
    st.site = &fb_emlrtRSI;
    if (!(errStatus == UsrpDriverError)) {
    } else {
      l_y = NULL;
      m9 = emlrtCreateCharArray(2, iv31);
      for (i = 0; i < 35; i++) {
        cv39[i] = cv51[i];
      }

      emlrtInitCharArrayR2013a(&st, 35, m9, cv39);
      emlrtAssign(&l_y, m9);
      u_size[0] = 1;
      u_size[1] = errMsg_size[1];
      i = errMsg_size[0] * errMsg_size[1];
      for (i10 = 0; i10 < i; i10++) {
        u_data[i10] = errMsg_data[i10];
      }

      m_y = NULL;
      m9 = emlrtCreateCharArray(2, u_size);
      emlrtInitCharArrayR2013a(&st, u_size[1], m9, (char_T *)u_data);
      emlrtAssign(&m_y, m9);
      b_st.site = &rb_emlrtRSI;
      c_error(&b_st, message(&b_st, l_y, m_y, &c_emlrtMCI), &c_emlrtMCI);
    }
    break;
  }
}

/* End of code generation (reportSDRuStatus.c) */
