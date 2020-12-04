#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-ERRORS" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#	PJM -L "node=12:noncont"
#	PJM -L "node=4:noncont"
#	PJM --mpi "max-proc-per-node=4"
#PJM -L "node=4:noncont"
#PJM --mpi "max-proc-per-node=2"
#	PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:6:00"
#	PJM -L "elapse=00:2:40"
#PJM -L "elapse=00:0:30"
#	PJM -L "elapse=00:2:30"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r1"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvmck1"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#
export LD_LIBRARY_PATH=${HOME}/mpich-tofu/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1
export MPIR_CVAR_ALLTOALL_SHORT_MSG_SIZE=2147483647 # 32768 in default (integer value)  
export TEST_INSTDIR=../../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

#export TOFULOG_DIR=./results
export UTF_MSGMODE=1	# Rendezous
#export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug

#export UTF_DEBUG=0xc
#export UTF_DEBUG=0xf7f
#export UTF_DEBUG=0x94
#export TOFU_DEBUG_FD=3
#export TOFU_DEBUG_LVL=3
#export MPITEST=1

echo "LD_LIBRARY_PATH=" $LD_LIBRARY_PATH
echo "TOFU_NAMED_AV = " $TOFU_NAMED_AV
echo "UTF_MSGMODE    = " $UTF_MSGMODE
echo "UTF_TRANSMODE = " $UTF_TRANSMODE "(0: Chained, 1: Aggressive)"
echo "UTF_DEBUG      = " $UTF_DEBUG
echo "TOFULOG_DIR    = " $TOFULOG_DIR
echo "TOFU_DEBUG_FD  = " $TOFU_DEBUG_FD
echo "TOFU_DEBUG_LVL = " $TOFU_DEBUG_LVL
#cho "MPITEST        = " $MPITEST

echo -e "[TESTNAME]: alltoalllength\n[OUTPUT]:" | tee -a /dev/stderr
mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/errors/coll/alltoalllength 
echo -e "[RETURN-VAL]: $?\n"
ldd /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/errors/coll/alltoalllength
printenv
exit

echo -e "[TESTNAME]: too_many_icomms\n[OUTPUT]:" | tee -a /dev/stderr
mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/errors/comm/too_many_icomms 
echo -e "[RETURN-VAL]: $?\n"

#echo -e "[TESTNAME]: reducelength\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/errors/coll/reducelength 
#echo -e "[RETURN-VAL]: $?\n"
#exit
