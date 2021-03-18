#!/bin/bash
#------ pjsub option --------#
#PJM -N "MB-2K-TG" # jobname
#PJM -S
#PJM --spath "results/IMB-2K/%n.%j.stat"
#PJM -o "results/IMB-2K/%n.%j.out"
#PJM -e "results/IMB-2K/%n.%j.err"
#
#PJM -L "node=512"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:40:40"
#PJM -L "elapse=03:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:4:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-tg.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-2K/%n.%j.out -oferr results/IMB-2K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1

###
#	2021/02/15 00:22:18 (1338), JOBID: 5133569
###

#export UTF_DEBUG=0x100000 # DLEVEL_LOG2
#export UTF_DEBUG=0x000100  # DLEVEL_ADHOC (delay)
#export UTF_DBGTIMER_INTERVAL=2360	# 39:20
#export UTF_DBGTIMER_ACTION=1

export MPIR_CVAR_DEVICE_COLLECTIVES=none	#
export MPIR_CVAR_GATHERV_INTER_SSEND_MIN_PROCS=608256 #
export MPIR_CVAR_BARRIER_INTRA_ALGORITHM=dissemination

export UTF_BG_REDUCE_MAXLEN=128 # default
export UTF_BG_BCAST_MAXLEN=128  # default
export UTF_BG_SHOW_MAXLEN=1

#OKBENCH="Allreduce Reduce Alltoall Bcast Barrier Allgather Allgatherv Gather Scatter Scatterv Gatherv"
#OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
#OKBENCH2="Allgather Allgatherv Gather Scatter"
#OKBENCH3="Gatherv Scatterv"
OKBENCH1="Allreduce"
OKBENCH2="Reduce"
OKBENCH3="Alltoall"
OKBENCH4="Bcast Barrier"
OKBENCH5="Allgather"
OKBENCH6="Allgatherv"
OKBENCH7="Gather"
OKBENCH8="Scatter"
OKBENCH9="Gatherv"
OKBENCH0="Scatterv"

#############
# 2021/02/14,
#############

NP=2048
LENFILE=len/len-gather-2048.txt
MEM=7

#run_bench "Allreduce" $NP $MEM $LENFILE
##run_bench "$OKBENCH" $NP $MEM $LENFILE
#exit

run_bench "$OKBENCH1" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH2" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH4" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH5" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH6" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH7" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH8" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH9" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH0" $NP $MEM $LENFILE

exit
