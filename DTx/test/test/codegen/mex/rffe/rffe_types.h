/*
 * rffe_types.h
 *
 * Code generation for function 'rffe'
 *
 */

#ifndef __RFFE_TYPES_H__
#define __RFFE_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_rffeStackData
#define typedef_rffeStackData
typedef struct
{
    struct
    {
        creal_T newRaisedSignal[131072];
        creal_T FFTSig[131072];
        creal_T varargout_1[131072];
        real_T varargin_1[131072];
    } f0;
} rffeStackData;
#endif /*typedef_rffeStackData*/

#endif
/* End of code generation (rffe_types.h) */
