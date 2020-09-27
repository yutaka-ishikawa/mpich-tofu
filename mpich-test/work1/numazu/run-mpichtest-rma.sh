#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-RMA" # jobname
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
#PJM -L "elapse=00:4:30"
#	PJM -L "elapse=00:2:00"
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

export TOFULOG_DIR=./results
#export UTF_MSGMODE=1	# Rendezous
export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug

#export UTF_DEBUG=0xc
#export UTF_DEBUG=0xff
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

# This does not work because MPIDI_OFI_MAX_NUM_AM_BUFFERS limits this value. see src/mpid/ch4/netmod/ofi/ofi_types.h
# Modified and use it
export MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS=16
echo "MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS=" $MPIR_PARAM_CH4_OFI_NUM_AM_BUFFERS
export MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS=0
echo "MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS =" $MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS

echo -e "[TESTNAME]: strided_acc_onelock\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 30s mpiexec -n 2    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/strided_acc_onelock 
echo -e "[RETURN-VAL]: $?\n"
exit 0

echo -e "[TESTNAME]: manyrma2\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 30s mpiexec -n 2    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/manyrma2 
echo -e "[RETURN-VAL]: $?\n"

echo -e "[TESTNAME]: manyrma2_shm\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 30s mpiexec -n 2    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/manyrma2_shm 
echo -e "[RETURN-VAL]: $?\n"

echo -e "[TESTNAME]: rma_contig\n[OUTPUT]:" | tee -a /dev/stderr
timeout --preserve-status -k 2 30s mpiexec -n 2    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/rma_contig 
echo -e "[RETURN-VAL]: $?\n"

#manyrma2 manyrma2_shm rma_contig badrma acc_ordering fence_shm get_struct at_complete aint acc_pairtype acc_pairtype_shm manyget large_small_acc rget_unlock rget_testall 

# MPICH PROBLEM on MPI_Win_Attach MPI_Win_create_dynamic ? remote key has not been shared
#echo -e "[TESTNAME]: linked_list\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/linked_list
#echo -e "[RETURN-VAL]: $?\n"

# MPICH PROBLEM on MPI_Win_create_dynamic ? remote key has not been shared
#echo -e "[TESTNAME]: linked_list_fop\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/linked_list_fop 
#echo -e "[RETURN-VAL]: $?\n"

# OK with export MPIR_CVAR_CH4_OFI_ENABLE_ATOMICS=0
#echo -e "[TESTNAME]: reqops\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/reqops 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: win_shared_noncontig_put\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/win_shared_noncontig_put 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: win_zero\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/win_zero 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: putfidx\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/putfidx 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: accfence2\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/accfence2 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: win_shared_put_flush_load\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/win_shared_put_flush_load 
#echo -e "[RETURN-VAL]: $?\n"

# OK
# large_acc_flush_local takes more than 5 min
#echo -e "[TESTNAME]: large_acc_flush_local\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 30s mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/large_acc_flush_local 
#mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/large_acc_flush_local 
#echo -e "[RETURN-VAL]: $?\n"

# ERROR, MPICH Problem ? (handle_acc_cmpl iov[0].iov_len=2 basic_sz=6)
#echo -e "[TESTNAME]: atomic_get_short_int\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_get_short_int 
#echo -e "[RETURN-VAL]: $?\n"

# OK, takes about 60sec
#echo -e "[TESTNAME]: atomic_get_long_int\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 300s mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_get_long_int 
#echo -e "[RETURN-VAL]: $?\n"

# OK, takes about 60sec
#echo -e "[TESTNAME]: atomic_get_double_int\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 300s mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_get_double_int 
#echo -e "[RETURN-VAL]: $?\n"

# OK, takes about 60sec
#echo -e "[TESTNAME]: atomic_get_long_double_int\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 300s mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_get_long_double_int 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: atomic_rmw_gacc\n[OUTPUT]:" | tee -a /dev/stderr
#timeout --preserve-status -k 2 50s mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_rmw_gacc 
#echo -e "[RETURN-VAL]: $?\n"

# OK
#echo -e "[TESTNAME]: atomic_rmw_cas\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/atomic_rmw_cas 
#echo -e "[RETURN-VAL]: $?\n"

#echo -e "[TESTNAME]: lockcontention\n[OUTPUT]:" | tee -a /dev/stderr
#mpiexec -n 3    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/rma/lockcontention 
#echo -e "[RETURN-VAL]: $?\n"
