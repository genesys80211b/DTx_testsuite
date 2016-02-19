# dTx_V40_testsuite
steps:
1. set/find your USRP IP address
2. run with correct IP address
codegen transceive103 -args {complex(zeros(1408,1)),true,txGain,rxGain,centerFreqTx,centerFreqRx,intFactor,decFactor,0}
