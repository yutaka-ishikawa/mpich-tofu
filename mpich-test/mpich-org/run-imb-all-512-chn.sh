#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-CH-ALL-CHN512"
#PJM -S
#PJM --spath "results/mpich-org/imb/all/%n.%j.stat"
#PJM -o "results/mpich-org/imb/all/%n.%j.out"
#PJM -e "results/mpich-org/imb/all/%n.%j.err"
#PJM -L "node=128"
#PJM -g "pz0485"
#PJM -L "rscgrp=regular-o"
#PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:50:00"
#PJM -L proc-core=unlimited
#------- Program execution -------#

##MPIOPT="-of-proc results/mpich-org/imb/all/%n.%j.out -oferr-proc results/mpich-org/imb/all/%n.%j.err"
MPIOPT="-of results/mpich-org/imb/all/%n.%j.out -oferr results/mpich-org/imb/all/%n.%j.err"
export MPICH_HOME=/data/01/pz0485/z30485/mpich-tofu-org/
export PATH=$PATH:$MPICH_HOME/bin:$PATH
which mpich_exec
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1

#
# UTF_MSGMODE (0: Eager, 1: Rendezous)
#	Eager in default
# UTF_TRANSMODE (0: Chained, 1: Aggressive)
#	Aggressive in default
#
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_MSGMODE=1
export UTF_TRANSMODE=0
export UTF_INFO=1
export UTF_TOFU_SHOW_RCOUNT=1
export UTOFU_SWAP_PROTECT=1

#
# Elpased Time: 32:23
# BENCH="Bcast Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Barrier"
NP=512
NPMIN=512
CMD=../bin-org/IMB-MPI1
BENCH="Bcast Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Barrier"

mpich_exec -n $NP $MPIOPT $CMD -npmin $NPMIN $BENCH

exit
