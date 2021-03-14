#!/bin/bash
#------ pjsub option --------#
#PJM -N "M-IMB-72R-AM" # jobname
#PJM -S
#PJM --spath "results/IMB-72R/%n.%j.stat"
#PJM -o "results/IMB-72R/%n.%j.out"
#PJM -e "results/IMB-72R/%n.%j.err"
#
#PJM -L "node=27648"
#		72 Rack
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./script-am.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-72R/%n.%j.out -oferr results/IMB-72R/%n.%j.err"

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"
NP=27648
LENFILE=len/len-gather-131072.txt
MEM=8

run_bench "$OKBENCH1" $NP $MEM
echo
echo
echo "*****************************"
echo "*    Skipping $OKBENCH2 and 3"
echo "*****************************"
echo
#run_bench "$OKBENCH2" $NP $MEM
#run_bench "$OKBENCH3" $NP $MEM $LENFILE


exit
