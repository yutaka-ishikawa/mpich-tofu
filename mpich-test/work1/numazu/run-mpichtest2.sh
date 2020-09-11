#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#PJM -L "node=4"
#PJM --mpi "max-proc-per-node=1"
#PJM -L "elapse=00:00:30"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r1"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvmck"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#
export LD_LIBRARY_PATH=${HOME}/riken-mpich/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1
export UTF_MSGMODE=1
export TEST_INSTDIR=../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

echo "# mpiexec -n 2    ./attr/attrt "
mpiexec -n 2    $TEST_INSTDIR/./attr/attrt
# ERROR
#echo "# mpiexec -n 4    ./attr/attric "
#mpiexec -n 4    $TEST_INSTDIR/./attr/attric

echo "# mpiexec -n 1    ./attr/attrerr "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrerr
echo "# mpiexec -n 1    ./attr/attrend "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrend
echo "# mpiexec -n 4    ./attr/attrend "
mpiexec -n 4    $TEST_INSTDIR/./attr/attrend
echo "# mpiexec -n 1    ./attr/attrend2 "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrend2
echo "# mpiexec -n 5    ./attr/attrend2 "
mpiexec -n 5    $TEST_INSTDIR/./attr/attrend2
echo "# mpiexec -n 1    ./attr/attrerrcomm "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrerrcomm
echo "# mpiexec -n 1    ./attr/attrerrtype "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrerrtype
echo "# mpiexec -n 1    ./attr/attrdeleteget "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrdeleteget
echo "# mpiexec -n 1    ./attr/attr2type "
mpiexec -n 1    $TEST_INSTDIR/./attr/attr2type
echo "# mpiexec -n 1    ./attr/attrorder "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrorder
echo "# mpiexec -n 1    ./attr/attrordercomm "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrordercomm
echo "# mpiexec -n 1    ./attr/attrordertype "
mpiexec -n 1    $TEST_INSTDIR/./attr/attrordertype
echo "# mpiexec -n 1    ./attr/baseattr2 "
mpiexec -n 1    $TEST_INSTDIR/./attr/baseattr2
echo "# mpiexec -n 1    ./attr/baseattrcomm "
mpiexec -n 1    $TEST_INSTDIR/./attr/baseattrcomm
echo "# mpiexec -n 1    ./attr/fkeyval "
mpiexec -n 1    $TEST_INSTDIR/./attr/fkeyval
echo "# mpiexec -n 1    ./attr/fkeyvalcomm "
mpiexec -n 1    $TEST_INSTDIR/./attr/fkeyvalcomm
echo "# mpiexec -n 1    ./attr/keyval_double_free "
mpiexec -n 1    $TEST_INSTDIR/./attr/keyval_double_free
echo "# mpiexec -n 1    ./attr/keyval_double_free_comm "
mpiexec -n 1    $TEST_INSTDIR/./attr/keyval_double_free_comm
echo "# mpiexec -n 1    ./attr/keyval_double_free_type "
mpiexec -n 1    $TEST_INSTDIR/./attr/keyval_double_free_type
echo "# mpiexec -n 1    ./attr/keyval_double_free_win "
mpiexec -n 1    $TEST_INSTDIR/./attr/keyval_double_free_win

#export PMIX_DEBUG=1
## CONF_TOFU_INJECTSIZE=1856 (MSG_EAGER_SIZE = 1878)
#	-x UTF_DEBUG=16 \
#	-x TOFULOG_DIR=./results \
#	-x FI_LOG_PROV=tofu \
#	-x MPICH_DBG=FILE \
#	-x MPICH_DBG_CLASS=COLL \
#	-x MPICH_DBG_LEVEL=TYPICAL \
#
#	-x PMIX_DEBUG=1 \
#	-x FI_LOG_LEVEL=Debug \
#
