#!/bin/bash

. ./script-am.sh

#MPIOPT is used in script-am.sh
#
MPIOPT="-of results/IMB-2K/%n.%j.out -oferr results/IMB-2K/%n.%j.err"
#
DRY_RUN=1

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"
NP=2048
LENFILE=len/len-gather-2048.txt
MEM=7


run_bench "$OKBENCH1" $NP $MEM
echo
run_bench "$OKBENCH2" $NP $MEM
echo
run_bench "$OKBENCH3" $NP $MEM $LENFILE

exit
