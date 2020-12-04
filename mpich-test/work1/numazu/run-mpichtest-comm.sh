#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-COMM" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#	PJM -L "node=12:noncont"
#PJM -L "node=4:noncont"
#	PJM --mpi "max-proc-per-node=48"
#	PJM --mpi "max-proc-per-node=4"
#PJM --mpi "max-proc-per-node=1"
#	PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:6:00"
#	PJM -L "elapse=00:2:40"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:0:40"
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
export TEST_INSTDIR=../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

##export TOFULOG_DIR=./results
##export UTF_MSGMODE=1	# Rendezous
export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug

#export UTF_DEBUG=0x3c	# PROTOCOL EAGER RENDEZOUS RMA
#export UTF_DEBUG=0x43c	# INIFIN PROTOCOL EAGER RENDEZOUS RMA
#export TOFU_DEBUG_FD=3
#export TOFU_DEBUG_LVL=3
#export MPITEST=1

echo "MPIR_CVAR_ALLTOALL_SHORT_MSG_SIZE = "  $MPIR_CVAR_ALLTOALL_SHORT_MSG_SIZE
# ADDED on 2020/09/23
export MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS=-1
echo "MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS= " $MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS
# ADDED on 2020/09/27 # now obsolete
##export MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS=16
##echo "MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS=" $MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS
# ADDED on 2020/10/13
export MPIR_CVAR_CH4_OFI_ENABLE_MR_VIRT_ADDRESS=1	# MPICH 3.4.x
export MPIR_CVAR_CH4_OFI_ENABLE_RMA=1
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1

echo "LD_LIBRARY_PATH=" $LD_LIBRARY_PATH
echo "TOFU_NAMED_AV = " $TOFU_NAMED_AV
echo "UTF_MSGMODE    = " $UTF_MSGMODE
echo "UTF_TRANSMODE = " $UTF_TRANSMODE "(0: Chained, 1: Aggressive)"
echo "UTF_DEBUG      = " $UTF_DEBUG
echo "TOFULOG_DIR    = " $TOFULOG_DIR
echo "TOFU_DEBUG_FD  = " $TOFU_DEBUG_FD
echo "TOFU_DEBUG_LVL = " $TOFU_DEBUG_LVL
#cho "MPITEST        = " $MPITEST

#export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=1
export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=0
#export UTF_DEBUG=0xc3c	# INIFIN PROTOCOL EAGER RENDEZOUS RMA
#export UTF_DEBUG=0x800	# MEMORY

echo -e "[TESTNAME]: ctxalloc\n[OUTPUT]:" | tee -a /dev/stderr
mpiexec -n 2    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxalloc 
echo -e "[RETURN-VAL]: $?\n"
exit

echo -e "[TESTNAME]: ctxsplit\n[OUTPUT]:" | tee -a /dev/stderr
mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 10000
#OK mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 37000
#NG mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 38000
#OK mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 35000
#NG mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 40000
#OK mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 30000
#OK mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 20000
#OK mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 10000
#NG mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 50000
#NG mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit --loopcount 100000
echo -e "[RETURN-VAL]: $?\n"
exit

echo -e "[TESTNAME]: cmsplit2\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 30s mpiexec -n 12    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/cmsplit2 
echo -e "[RETURN-VAL]: $?\n"
exit

# IT's OK for timeout
#echo -e "[TESTNAME]: ctxsplit\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/comm/ctxsplit
#echo -e "[RETURN-VAL]: $?\n"

#echo "# mpiexec -n 6    ./comm/comm_idup_iallreduce"
#mpiexec -n 6    $TEST_INSTDIR/./comm/comm_idup_iallreduce
#echo $?


