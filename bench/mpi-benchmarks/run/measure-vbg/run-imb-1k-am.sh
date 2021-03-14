#!/bin/bash
#------ pjsub option --------#
#PJM -N "M-IMB-1K-AM" # jobname
#PJM -S
#PJM --spath "results/IMB-1K/%n.%j.stat"
#PJM -o "results/IMB-1K/%n.%j.out"
#PJM -e "results/IMB-1K/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#PJM -L "node=256"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#
. ./script-am.sh

MPIOPT="-of results/IMB-1K/%n.%j.out -oferr results/IMB-1K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1

###
#	2021/02/11 00:24:38 (1538), JOBID: 5092039
###

#export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
#export MPICH_TOFU_SHOW_PARAMS=1
#export UTF_INFO=0x1
#export UTF_DEBUG=0x82200 # DLEVEL_ERR | DLEVEL_WARN | DLEVEL_LOG
#export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
#export UTF_TRANSMODE=0		# Chained mode
#export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01

#NP=1024
#LENFILE=len-gather-1024.txt
#MEM=7



# 44:24, 2021/02/10
# PingPong, PingPing, Sendrecv, Exchange, Allreduce, Reduce, Reduce_local, Reduce_scatter
# Reduce_scatter_block, Allgather, Allgatherv, Gather, Gatherv, Scatter, Scatterv
# Alltoall, Alltoallv, Bcast, Barrier

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"

NP=1024
LENFILE=len/len-gather-1024.txt
MEM=7

run_bench "$OKBENCH1" $NP $MEM
echo
run_bench "$OKBENCH2" $NP $MEM
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE

#echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM"
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM
exit
