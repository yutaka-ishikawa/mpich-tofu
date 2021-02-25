#!/bin/bash
#------ pjsub option --------#
#PJM -N "MB-1K-TG" # jobname
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
#PJM -L "elapse=00:40:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6-4,jobenv=linux2"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-tg.sh

#MPIOPT is used in script-am.sh
MPIOPT="-of results/IMB-1K/%n.%j.out -oferr results/IMB-1K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1-20210206

export MPIR_CVAR_DEVICE_COLLECTIVES=none	#
export MPIR_CVAR_GATHERV_INTER_SSEND_MIN_PROCS=608256 #
export MPIR_CVAR_BARRIER_INTRA_ALGORITHM=dissemination

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Scatterv Gatherv"

#############
# 2021/02/14, MB-1K-TG.5127527, 19:58
#############

NP=1024
LENFILE=len/len-gather-1024.txt
MEM=7

run_bench "$OKBENCH1" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH2" $NP $MEM $LENFILE
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE

exit
