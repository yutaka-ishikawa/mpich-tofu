#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-COLL" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#PJM -L "node=16"
#PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=1"
#	PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:6:00"
#	PJM -L "elapse=00:2:40"
#PJM -L "elapse=00:0:30"
#	PJM -L "elapse=00:2:30"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-sin,jobenv=linux"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#
export LD_LIBRARY_PATH=${HOME}/mpich-tofu/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1
export TEST_INSTDIR=../../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

export UTF_MSGMODE=1	# Rendezous
#export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug

#export UTF_DEBUG=0x100
#export UTF_DEBUG=0xc
#export UTF_DEBUG=0x2c
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


echo -e "[TESTNAME]: nonblocking2\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 5m mpiexec -n 10    /home/g9300001/u93027/work/mpich-tofu/mpich/test/mpi/coll/nonblocking2 
echo -e "[RETURN-VAL]: $?\n"

echo -e "[TESTNAME]: nonblocking3\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 5m mpiexec -n 10    /home/g9300001/u93027/work/mpich-tofu/mpich/test/mpi/coll/nonblocking3 
echo -e "[RETURN-VAL]: $?\n"

#echo "# mpiexec -n 10    ./coll/nonblocking3"
#mpiexec -n 10   $TEST_INSTDIR/./coll/nonblocking3
#echo $?
