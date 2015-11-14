MATLAB="/usr/local/MATLAB/R2014b"
Arch=glnxa64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/home/bdroz/.matlab/R2014b"
OPTSFILE_NAME="./setEnv.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for rffe" > rffe_mex.mki
echo "CC=$CC" >> rffe_mex.mki
echo "CFLAGS=$CFLAGS" >> rffe_mex.mki
echo "CLIBS=$CLIBS" >> rffe_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> rffe_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> rffe_mex.mki
echo "CXX=$CXX" >> rffe_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> rffe_mex.mki
echo "CXXLIBS=$CXXLIBS" >> rffe_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> rffe_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> rffe_mex.mki
echo "LD=$LD" >> rffe_mex.mki
echo "LDFLAGS=$LDFLAGS" >> rffe_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> rffe_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> rffe_mex.mki
echo "Arch=$Arch" >> rffe_mex.mki
echo OMPFLAGS= >> rffe_mex.mki
echo OMPLINKFLAGS= >> rffe_mex.mki
echo "EMC_COMPILER=gcc" >> rffe_mex.mki
echo "EMC_CONFIG=optim" >> rffe_mex.mki
"/usr/local/MATLAB/R2014b/bin/glnxa64/gmake" -B -f rffe_mex.mk
