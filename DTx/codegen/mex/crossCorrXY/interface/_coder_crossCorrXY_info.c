/*
 * Trial License - for use to evaluate programs for possible purchase as
 * an end-user only.
 *
 * _coder_crossCorrXY_info.c
 *
 * Code generation for function '_coder_crossCorrXY_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "crossCorrXY.h"
#include "_coder_crossCorrXY_info.h"

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const uint32_T u);
static const mxArray *emlrt_marshallOut(const char * u);
static void info_helper(const mxArray **info);

/* Function Definitions */
static const mxArray *b_emlrt_marshallOut(const uint32_T u)
{
  const mxArray *y;
  const mxArray *m1;
  y = NULL;
  m1 = emlrtCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
  *(uint32_T *)mxGetData(m1) = u;
  emlrtAssign(&y, m1);
  return y;
}

static const mxArray *emlrt_marshallOut(const char * u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateString(u);
  emlrtAssign(&y, m0);
  return y;
}

static void info_helper(const mxArray **info)
{
  const mxArray *rhs0 = NULL;
  const mxArray *lhs0 = NULL;
  const mxArray *rhs1 = NULL;
  const mxArray *lhs1 = NULL;
  const mxArray *rhs2 = NULL;
  const mxArray *lhs2 = NULL;
  const mxArray *rhs3 = NULL;
  const mxArray *lhs3 = NULL;
  const mxArray *rhs4 = NULL;
  const mxArray *lhs4 = NULL;
  const mxArray *rhs5 = NULL;
  const mxArray *lhs5 = NULL;
  const mxArray *rhs6 = NULL;
  const mxArray *lhs6 = NULL;
  const mxArray *rhs7 = NULL;
  const mxArray *lhs7 = NULL;
  const mxArray *rhs8 = NULL;
  const mxArray *lhs8 = NULL;
  const mxArray *rhs9 = NULL;
  const mxArray *lhs9 = NULL;
  const mxArray *rhs10 = NULL;
  const mxArray *lhs10 = NULL;
  const mxArray *rhs11 = NULL;
  const mxArray *lhs11 = NULL;
  const mxArray *rhs12 = NULL;
  const mxArray *lhs12 = NULL;
  const mxArray *rhs13 = NULL;
  const mxArray *lhs13 = NULL;
  const mxArray *rhs14 = NULL;
  const mxArray *lhs14 = NULL;
  const mxArray *rhs15 = NULL;
  const mxArray *lhs15 = NULL;
  const mxArray *rhs16 = NULL;
  const mxArray *lhs16 = NULL;
  const mxArray *rhs17 = NULL;
  const mxArray *lhs17 = NULL;
  const mxArray *rhs18 = NULL;
  const mxArray *lhs18 = NULL;
  const mxArray *rhs19 = NULL;
  const mxArray *lhs19 = NULL;
  const mxArray *rhs20 = NULL;
  const mxArray *lhs20 = NULL;
  const mxArray *rhs21 = NULL;
  const mxArray *lhs21 = NULL;
  const mxArray *rhs22 = NULL;
  const mxArray *lhs22 = NULL;
  const mxArray *rhs23 = NULL;
  const mxArray *lhs23 = NULL;
  const mxArray *rhs24 = NULL;
  const mxArray *lhs24 = NULL;
  const mxArray *rhs25 = NULL;
  const mxArray *lhs25 = NULL;
  const mxArray *rhs26 = NULL;
  const mxArray *lhs26 = NULL;
  const mxArray *rhs27 = NULL;
  const mxArray *lhs27 = NULL;
  const mxArray *rhs28 = NULL;
  const mxArray *lhs28 = NULL;
  const mxArray *rhs29 = NULL;
  const mxArray *lhs29 = NULL;
  const mxArray *rhs30 = NULL;
  const mxArray *lhs30 = NULL;
  const mxArray *rhs31 = NULL;
  const mxArray *lhs31 = NULL;
  const mxArray *rhs32 = NULL;
  const mxArray *lhs32 = NULL;
  const mxArray *rhs33 = NULL;
  const mxArray *lhs33 = NULL;
  const mxArray *rhs34 = NULL;
  const mxArray *lhs34 = NULL;
  const mxArray *rhs35 = NULL;
  const mxArray *lhs35 = NULL;
  const mxArray *rhs36 = NULL;
  const mxArray *lhs36 = NULL;
  const mxArray *rhs37 = NULL;
  const mxArray *lhs37 = NULL;
  const mxArray *rhs38 = NULL;
  const mxArray *lhs38 = NULL;
  const mxArray *rhs39 = NULL;
  const mxArray *lhs39 = NULL;
  const mxArray *rhs40 = NULL;
  const mxArray *lhs40 = NULL;
  const mxArray *rhs41 = NULL;
  const mxArray *lhs41 = NULL;
  const mxArray *rhs42 = NULL;
  const mxArray *lhs42 = NULL;
  const mxArray *rhs43 = NULL;
  const mxArray *lhs43 = NULL;
  const mxArray *rhs44 = NULL;
  const mxArray *lhs44 = NULL;
  const mxArray *rhs45 = NULL;
  const mxArray *lhs45 = NULL;
  const mxArray *rhs46 = NULL;
  const mxArray *lhs46 = NULL;
  const mxArray *rhs47 = NULL;
  const mxArray *lhs47 = NULL;
  const mxArray *rhs48 = NULL;
  const mxArray *lhs48 = NULL;
  const mxArray *rhs49 = NULL;
  const mxArray *lhs49 = NULL;
  const mxArray *rhs50 = NULL;
  const mxArray *lhs50 = NULL;
  const mxArray *rhs51 = NULL;
  const mxArray *lhs51 = NULL;
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 0);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.matlabCodegenHandle"),
                "name", 0);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXC]/usr/local/MATLAB/R2015b/toolbox/coder/coder/+coder/+internal/matlabCodegenHandle.p"),
                "resolved", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(1431720362U), "fileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 0);
  emlrtAssign(&rhs0, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs0, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs0), "rhs", 0);
  emlrtAddField(*info, emlrtAliasP(lhs0), "lhs", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "context", 1);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemProp"),
                "name", 1);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "resolved", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 1);
  emlrtAssign(&rhs1, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs1, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs1), "rhs", 1);
  emlrtAddField(*info, emlrtAliasP(lhs1), "lhs", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "context", 2);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.matlabCodegenHandle"),
                "name", 2);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXC]/usr/local/MATLAB/R2015b/toolbox/coder/coder/+coder/+internal/matlabCodegenHandle.p"),
                "resolved", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(1431720362U), "fileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 2);
  emlrtAssign(&rhs2, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs2, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs2), "rhs", 2);
  emlrtAddField(*info, emlrtAliasP(lhs2), "lhs", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "context", 3);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemCore"),
                "name", 3);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "resolved", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 3);
  emlrtAssign(&rhs3, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs3, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs3), "rhs", 3);
  emlrtAddField(*info, emlrtAliasP(lhs3), "lhs", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 4);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.System"), "name",
                4);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "resolved", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 4);
  emlrtAssign(&rhs4, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs4, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs4), "rhs", 4);
  emlrtAddField(*info, emlrtAliasP(lhs4), "lhs", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+mixin/+coder/Nondirect.p"),
                "context", 5);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.matlabCodegenHandle"),
                "name", 5);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXC]/usr/local/MATLAB/R2015b/toolbox/coder/coder/+coder/+internal/matlabCodegenHandle.p"),
                "resolved", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(1431720362U), "fileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 5);
  emlrtAssign(&rhs5, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs5, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs5), "rhs", 5);
  emlrtAddField(*info, emlrtAliasP(lhs5), "lhs", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 6);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.mixin.coder.Nondirect"),
                "name", 6);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+mixin/+coder/Nondirect.p"),
                "resolved", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 6);
  emlrtAssign(&rhs6, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs6, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs6), "rhs", 6);
  emlrtAddField(*info, emlrtAliasP(lhs6), "lhs", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[E]/usr/local/MATLAB/Copy_of_V35/crossCorrXY.m"), "context", 7);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.Crosscorrelator"), "name",
                7);
  emlrtAddField(*info, emlrt_marshallOut("int32"), "dominantType", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "resolved", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(1431725912U), "fileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 7);
  emlrtAssign(&rhs7, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs7, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs7), "rhs", 7);
  emlrtAddField(*info, emlrtAliasP(lhs7), "lhs", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 8);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemProp"),
                "name", 8);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "resolved", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 8);
  emlrtAssign(&rhs8, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs8, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs8), "rhs", 8);
  emlrtAddField(*info, emlrtAliasP(lhs8), "lhs", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "context", 9);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemCore"),
                "name", 9);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "resolved", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(1431715898U), "fileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 9);
  emlrtAssign(&rhs9, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs9, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs9), "rhs", 9);
  emlrtAddField(*info, emlrtAliasP(lhs9), "lhs", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 10);
  emlrtAddField(*info, emlrt_marshallOut("createsystemobjectv2"), "name", 10);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/createsystemobjectv2.m"),
                "resolved", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(1416015006U), "fileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 10);
  emlrtAssign(&rhs10, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs10, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs10), "rhs", 10);
  emlrtAddField(*info, emlrtAliasP(lhs10), "lhs", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/createsystemobjectv2.m"),
                "context", 11);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.length"), "name", 11);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/length.m"),
                "resolved", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(1429650858U), "fileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 11);
  emlrtAssign(&rhs11, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs11, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs11), "rhs", 11);
  emlrtAddField(*info, emlrtAliasP(lhs11), "lhs", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/createsystemobjectv2.m"),
                "context", 12);
  emlrtAddField(*info, emlrt_marshallOut("feval"), "name", 12);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXMB]/usr/local/MATLAB/R2015b/toolbox/matlab/lang/feval.m"), "resolved",
                12);
  emlrtAddField(*info, b_emlrt_marshallOut(MAX_uint32_T), "fileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(MAX_uint32_T), "fileTimeHi", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(MAX_uint32_T), "mFileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(MAX_uint32_T), "mFileTimeHi", 12);
  emlrtAssign(&rhs12, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs12, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs12), "rhs", 12);
  emlrtAddField(*info, emlrtAliasP(lhs12), "lhs", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 13);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.isSystemObject"), "name",
                13);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/matlab/system/+matlab/+system/isSystemObject.p"),
                "resolved", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(1431666890U), "fileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 13);
  emlrtAssign(&rhs13, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs13, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs13), "rhs", 13);
  emlrtAddField(*info, emlrtAliasP(lhs13), "lhs", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 14);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.length"), "name", 14);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/length.m"),
                "resolved", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(1429650858U), "fileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 14);
  emlrtAssign(&rhs14, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs14, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs14), "rhs", 14);
  emlrtAddField(*info, emlrtAliasP(lhs14), "lhs", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 15);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.pvParse"), "name", 15);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.Crosscorrelator"),
                "dominantType", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "resolved", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(1431666890U), "fileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 15);
  emlrtAssign(&rhs15, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs15, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs15), "rhs", 15);
  emlrtAddField(*info, emlrtAliasP(lhs15), "lhs", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "context", 16);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.length"), "name", 16);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/length.m"),
                "resolved", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(1429650858U), "fileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 16);
  emlrtAssign(&rhs16, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs16, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs16), "rhs", 16);
  emlrtAddField(*info, emlrtAliasP(lhs16), "lhs", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "context", 17);
  emlrtAddField(*info, emlrt_marshallOut("rem"), "name", 17);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "resolved", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(1425470172U), "fileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 17);
  emlrtAssign(&rhs17, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs17, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs17), "rhs", 17);
  emlrtAddField(*info, emlrtAliasP(lhs17), "lhs", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "context", 18);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 18);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(1395949856U), "fileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 18);
  emlrtAssign(&rhs18, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs18, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs18), "rhs", 18);
  emlrtAddField(*info, emlrtAliasP(lhs18), "lhs", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "context", 19);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 19);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929516U), "fileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 19);
  emlrtAssign(&rhs19, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs19, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs19), "rhs", 19);
  emlrtAddField(*info, emlrtAliasP(lhs19), "lhs", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m!firstfi"),
                "context", 20);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 20);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929534U), "fileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 20);
  emlrtAssign(&rhs20, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs20, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs20), "rhs", 20);
  emlrtAddField(*info, emlrtAliasP(lhs20), "lhs", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper"),
                "context", 21);
  emlrtAddField(*info, emlrt_marshallOut("isfi"), "name", 21);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "resolved", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929524U), "fileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 21);
  emlrtAssign(&rhs21, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs21, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs21), "rhs", 21);
  emlrtAddField(*info, emlrtAliasP(lhs21), "lhs", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "context", 22);
  emlrtAddField(*info, emlrt_marshallOut("isnumerictype"), "name", 22);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isnumerictype.m"),
                "resolved", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929524U), "fileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 22);
  emlrtAssign(&rhs22, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs22, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs22), "rhs", 22);
  emlrtAddField(*info, emlrtAliasP(lhs22), "lhs", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper"),
                "context", 23);
  emlrtAddField(*info, emlrt_marshallOut("intmax"), "name", 23);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmax.m"),
                "resolved", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929532U), "fileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 23);
  emlrtAssign(&rhs23, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs23, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs23), "rhs", 23);
  emlrtAddField(*info, emlrtAliasP(lhs23), "lhs", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper"),
                "context", 24);
  emlrtAddField(*info, emlrt_marshallOut("intmin"), "name", 24);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmin.m"),
                "resolved", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929532U), "fileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 24);
  emlrtAssign(&rhs24, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs24, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs24), "rhs", 24);
  emlrtAddField(*info, emlrtAliasP(lhs24), "lhs", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m!firstfi"),
                "context", 25);
  emlrtAddField(*info, emlrt_marshallOut("isfi"), "name", 25);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "resolved", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929524U), "fileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 25);
  emlrtAssign(&rhs25, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs25, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs25), "rhs", 25);
  emlrtAddField(*info, emlrtAliasP(lhs25), "lhs", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "context", 26);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAlloc"), "name",
                26);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "resolved", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929516U), "fileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 26);
  emlrtAssign(&rhs26, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs26, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs26), "rhs", 26);
  emlrtAddField(*info, emlrtAliasP(lhs26), "lhs", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "context", 27);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAllocNoCheck"),
                "name", 27);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAllocNoCheck.m"),
                "resolved", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(1410458690U), "fileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 27);
  emlrtAssign(&rhs27, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs27, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs27), "rhs", 27);
  emlrtAddField(*info, emlrtAliasP(lhs27), "lhs", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "context", 28);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalar.rem"), "name",
                28);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+scalar/rem.m"),
                "resolved", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(1419335426U), "fileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 28);
  emlrtAssign(&rhs28, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs28, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs28), "rhs", 28);
  emlrtAddField(*info, emlrtAliasP(lhs28), "lhs", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/rem.m"),
                "context", 29);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.applyScalarFunction"),
                "name", 29);
  emlrtAddField(*info, emlrt_marshallOut("function_handle"), "dominantType", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"),
                "resolved", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(1422905902U), "fileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 29);
  emlrtAssign(&rhs29, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs29, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs29), "rhs", 29);
  emlrtAddField(*info, emlrtAliasP(lhs29), "lhs", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"),
                "context", 30);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAlloc"), "name",
                30);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "resolved", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929516U), "fileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 30);
  emlrtAssign(&rhs30, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs30, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs30), "rhs", 30);
  emlrtAddField(*info, emlrtAliasP(lhs30), "lhs", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"),
                "context", 31);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalar.rem"), "name",
                31);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+scalar/rem.m"),
                "resolved", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(1419335426U), "fileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 31);
  emlrtAssign(&rhs31, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs31, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs31), "rhs", 31);
  emlrtAddField(*info, emlrtAliasP(lhs31), "lhs", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 32);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.Crosscorrelator"), "name",
                32);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 32);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "resolved", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(1431725912U), "fileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 32);
  emlrtAssign(&rhs32, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs32, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs32), "rhs", 32);
  emlrtAddField(*info, emlrtAliasP(lhs32), "lhs", 32);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 33);
  emlrtAddField(*info, emlrt_marshallOut("get_impl"), "name", 33);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                33);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/get_impl.m"),
                "resolved", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929522U), "fileTimeLo", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 33);
  emlrtAssign(&rhs33, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs33, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs33), "rhs", 33);
  emlrtAddField(*info, emlrtAliasP(lhs33), "lhs", 33);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/get_impl.m"),
                "context", 34);
  emlrtAddField(*info, emlrt_marshallOut("coder_sysobj_get"), "name", 34);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 34);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/shared/system/coder/coder_sysobj_get.m"),
                "resolved", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(1365756022U), "fileTimeLo", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 34);
  emlrtAssign(&rhs34, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs34, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs34), "rhs", 34);
  emlrtAddField(*info, emlrtAliasP(lhs34), "lhs", 34);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 35);
  emlrtAddField(*info, emlrt_marshallOut("getNumInputs"), "name", 35);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                35);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumInputs.m"),
                "resolved", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 35);
  emlrtAssign(&rhs35, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs35, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs35), "rhs", 35);
  emlrtAddField(*info, emlrtAliasP(lhs35), "lhs", 35);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumInputs.m"),
                "context", 36);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 36);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                36);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 36);
  emlrtAssign(&rhs36, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs36, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs36), "rhs", 36);
  emlrtAddField(*info, emlrtAliasP(lhs36), "lhs", 36);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumInputs.m"),
                "context", 37);
  emlrtAddField(*info, emlrt_marshallOut("eml_try_catch"), "name", 37);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 37);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/eml_try_catch.m"), "resolved",
                37);
  emlrtAddField(*info, b_emlrt_marshallOut(1294089542U), "fileTimeLo", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 37);
  emlrtAssign(&rhs37, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs37, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs37), "rhs", 37);
  emlrtAddField(*info, emlrtAliasP(lhs37), "lhs", 37);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 38);
  emlrtAddField(*info, emlrt_marshallOut("setup"), "name", 38);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                38);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/setup.m"), "resolved",
                38);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 38);
  emlrtAssign(&rhs38, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs38, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs38), "rhs", 38);
  emlrtAddField(*info, emlrtAliasP(lhs38), "lhs", 38);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/setup.m"), "context",
                39);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 39);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                39);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 39);
  emlrtAssign(&rhs39, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs39, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs39), "rhs", 39);
  emlrtAddField(*info, emlrtAliasP(lhs39), "lhs", 39);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/setup.m"), "context",
                40);
  emlrtAddField(*info, emlrt_marshallOut("eml_try_catch"), "name", 40);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 40);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/eml_try_catch.m"), "resolved",
                40);
  emlrtAddField(*info, b_emlrt_marshallOut(1294089542U), "fileTimeLo", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 40);
  emlrtAssign(&rhs40, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs40, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs40), "rhs", 40);
  emlrtAddField(*info, emlrtAliasP(lhs40), "lhs", 40);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 41);
  emlrtAddField(*info, emlrt_marshallOut("reset"), "name", 41);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                41);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/reset.m"), "resolved",
                41);
  emlrtAddField(*info, b_emlrt_marshallOut(1391553532U), "fileTimeLo", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 41);
  emlrtAssign(&rhs41, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs41, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs41), "rhs", 41);
  emlrtAddField(*info, emlrtAliasP(lhs41), "lhs", 41);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/reset.m"), "context",
                42);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 42);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                42);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 42);
  emlrtAssign(&rhs42, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs42, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs42), "rhs", 42);
  emlrtAddField(*info, emlrtAliasP(lhs42), "lhs", 42);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 43);
  emlrtAddField(*info, emlrt_marshallOut("getNumOutputs"), "name", 43);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                43);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumOutputs.m"),
                "resolved", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 43);
  emlrtAssign(&rhs43, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs43, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs43), "rhs", 43);
  emlrtAddField(*info, emlrtAliasP(lhs43), "lhs", 43);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumOutputs.m"),
                "context", 44);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 44);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                44);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 44);
  emlrtAssign(&rhs44, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs44, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs44), "rhs", 44);
  emlrtAddField(*info, emlrtAliasP(lhs44), "lhs", 44);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/getNumOutputs.m"),
                "context", 45);
  emlrtAddField(*info, emlrt_marshallOut("eml_try_catch"), "name", 45);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 45);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/eml_try_catch.m"), "resolved",
                45);
  emlrtAddField(*info, b_emlrt_marshallOut(1294089542U), "fileTimeLo", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 45);
  emlrtAssign(&rhs45, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs45, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs45), "rhs", 45);
  emlrtAddField(*info, emlrtAliasP(lhs45), "lhs", 45);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 46);
  emlrtAddField(*info, emlrt_marshallOut("output"), "name", 46);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                46);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/output.m"), "resolved",
                46);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 46);
  emlrtAssign(&rhs46, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs46, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs46), "rhs", 46);
  emlrtAddField(*info, emlrtAliasP(lhs46), "lhs", 46);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/output.m"), "context",
                47);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 47);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                47);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 47);
  emlrtAssign(&rhs47, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs47, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs47), "rhs", 47);
  emlrtAddField(*info, emlrtAliasP(lhs47), "lhs", 47);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/output.m"), "context",
                48);
  emlrtAddField(*info, emlrt_marshallOut("eml_try_catch"), "name", 48);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 48);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/eml_try_catch.m"), "resolved",
                48);
  emlrtAddField(*info, b_emlrt_marshallOut(1294089542U), "fileTimeLo", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 48);
  emlrtAssign(&rhs48, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs48, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs48), "rhs", 48);
  emlrtAddField(*info, emlrtAliasP(lhs48), "lhs", 48);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]/usr/local/MATLAB/R2015b/toolbox/dsp/dsp/compiled/+dspcodegen/Crosscorrelator.p"),
                "context", 49);
  emlrtAddField(*info, emlrt_marshallOut("update"), "name", 49);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                49);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/update.m"), "resolved",
                49);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 49);
  emlrtAssign(&rhs49, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs49, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs49), "rhs", 49);
  emlrtAddField(*info, emlrtAliasP(lhs49), "lhs", 49);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/update.m"), "context",
                50);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 50);
  emlrtAddField(*info, emlrt_marshallOut("dsp.Crosscorrelator"), "dominantType",
                50);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(1415929546U), "fileTimeLo", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 50);
  emlrtAssign(&rhs50, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs50, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs50), "rhs", 50);
  emlrtAddField(*info, emlrtAliasP(lhs50), "lhs", 50);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]/usr/local/MATLAB/R2015b/toolbox/eml/lib/scomp/update.m"), "context",
                51);
  emlrtAddField(*info, emlrt_marshallOut("eml_try_catch"), "name", 51);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 51);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]/usr/local/MATLAB/R2015b/toolbox/eml/eml/eml_try_catch.m"), "resolved",
                51);
  emlrtAddField(*info, b_emlrt_marshallOut(1294089542U), "fileTimeLo", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 51);
  emlrtAssign(&rhs51, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs51, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs51), "rhs", 51);
  emlrtAddField(*info, emlrtAliasP(lhs51), "lhs", 51);
  emlrtDestroyArray(&rhs0);
  emlrtDestroyArray(&lhs0);
  emlrtDestroyArray(&rhs1);
  emlrtDestroyArray(&lhs1);
  emlrtDestroyArray(&rhs2);
  emlrtDestroyArray(&lhs2);
  emlrtDestroyArray(&rhs3);
  emlrtDestroyArray(&lhs3);
  emlrtDestroyArray(&rhs4);
  emlrtDestroyArray(&lhs4);
  emlrtDestroyArray(&rhs5);
  emlrtDestroyArray(&lhs5);
  emlrtDestroyArray(&rhs6);
  emlrtDestroyArray(&lhs6);
  emlrtDestroyArray(&rhs7);
  emlrtDestroyArray(&lhs7);
  emlrtDestroyArray(&rhs8);
  emlrtDestroyArray(&lhs8);
  emlrtDestroyArray(&rhs9);
  emlrtDestroyArray(&lhs9);
  emlrtDestroyArray(&rhs10);
  emlrtDestroyArray(&lhs10);
  emlrtDestroyArray(&rhs11);
  emlrtDestroyArray(&lhs11);
  emlrtDestroyArray(&rhs12);
  emlrtDestroyArray(&lhs12);
  emlrtDestroyArray(&rhs13);
  emlrtDestroyArray(&lhs13);
  emlrtDestroyArray(&rhs14);
  emlrtDestroyArray(&lhs14);
  emlrtDestroyArray(&rhs15);
  emlrtDestroyArray(&lhs15);
  emlrtDestroyArray(&rhs16);
  emlrtDestroyArray(&lhs16);
  emlrtDestroyArray(&rhs17);
  emlrtDestroyArray(&lhs17);
  emlrtDestroyArray(&rhs18);
  emlrtDestroyArray(&lhs18);
  emlrtDestroyArray(&rhs19);
  emlrtDestroyArray(&lhs19);
  emlrtDestroyArray(&rhs20);
  emlrtDestroyArray(&lhs20);
  emlrtDestroyArray(&rhs21);
  emlrtDestroyArray(&lhs21);
  emlrtDestroyArray(&rhs22);
  emlrtDestroyArray(&lhs22);
  emlrtDestroyArray(&rhs23);
  emlrtDestroyArray(&lhs23);
  emlrtDestroyArray(&rhs24);
  emlrtDestroyArray(&lhs24);
  emlrtDestroyArray(&rhs25);
  emlrtDestroyArray(&lhs25);
  emlrtDestroyArray(&rhs26);
  emlrtDestroyArray(&lhs26);
  emlrtDestroyArray(&rhs27);
  emlrtDestroyArray(&lhs27);
  emlrtDestroyArray(&rhs28);
  emlrtDestroyArray(&lhs28);
  emlrtDestroyArray(&rhs29);
  emlrtDestroyArray(&lhs29);
  emlrtDestroyArray(&rhs30);
  emlrtDestroyArray(&lhs30);
  emlrtDestroyArray(&rhs31);
  emlrtDestroyArray(&lhs31);
  emlrtDestroyArray(&rhs32);
  emlrtDestroyArray(&lhs32);
  emlrtDestroyArray(&rhs33);
  emlrtDestroyArray(&lhs33);
  emlrtDestroyArray(&rhs34);
  emlrtDestroyArray(&lhs34);
  emlrtDestroyArray(&rhs35);
  emlrtDestroyArray(&lhs35);
  emlrtDestroyArray(&rhs36);
  emlrtDestroyArray(&lhs36);
  emlrtDestroyArray(&rhs37);
  emlrtDestroyArray(&lhs37);
  emlrtDestroyArray(&rhs38);
  emlrtDestroyArray(&lhs38);
  emlrtDestroyArray(&rhs39);
  emlrtDestroyArray(&lhs39);
  emlrtDestroyArray(&rhs40);
  emlrtDestroyArray(&lhs40);
  emlrtDestroyArray(&rhs41);
  emlrtDestroyArray(&lhs41);
  emlrtDestroyArray(&rhs42);
  emlrtDestroyArray(&lhs42);
  emlrtDestroyArray(&rhs43);
  emlrtDestroyArray(&lhs43);
  emlrtDestroyArray(&rhs44);
  emlrtDestroyArray(&lhs44);
  emlrtDestroyArray(&rhs45);
  emlrtDestroyArray(&lhs45);
  emlrtDestroyArray(&rhs46);
  emlrtDestroyArray(&lhs46);
  emlrtDestroyArray(&rhs47);
  emlrtDestroyArray(&lhs47);
  emlrtDestroyArray(&rhs48);
  emlrtDestroyArray(&lhs48);
  emlrtDestroyArray(&rhs49);
  emlrtDestroyArray(&lhs49);
  emlrtDestroyArray(&rhs50);
  emlrtDestroyArray(&lhs50);
  emlrtDestroyArray(&rhs51);
  emlrtDestroyArray(&lhs51);
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xEntryPoints;
  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 1);
  emlrtSetField(xEntryPoints, 0, "Name", mxCreateString("crossCorrXY"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", mxCreateString("8.6.0.232648 (R2015b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  nameCaptureInfo = NULL;
  emlrtAssign(&nameCaptureInfo, emlrtCreateStructMatrix(52, 1, 0, NULL));
  info_helper(&nameCaptureInfo);
  emlrtNameCapturePostProcessR2013b(&nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_crossCorrXY_info.c) */
