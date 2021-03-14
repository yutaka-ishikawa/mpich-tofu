#!/bin/bash
#------ pjsub option --------#
#PJM -N "M-IMB-4K-AM" # jobname
#PJM -S
#PJM --spath "results/IMB-4K/%n.%j.stat"
#PJM -o "results/IMB-4K/%n.%j.out"
#PJM -e "results/IMB-4K/%n.%j.err"
#
#PJM -L "node=1024"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#       PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-am.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-4K/%n.%j.out -oferr results/IMB-4K/%n.%j.err"
BENCH_PROG=../../IMB-MPI1

###
#	2021/02/11 00:24:18 (1458), JOBID: 5092985
###

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"
NP=4096
LENFILE=len/len-gather-4096.txt
MEM=7

run_bench "$OKBENCH1" $NP $MEM
echo
run_bench "$OKBENCH2" $NP $MEM
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE

exit
