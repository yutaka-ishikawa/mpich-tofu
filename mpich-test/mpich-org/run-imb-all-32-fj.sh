#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-FJ-ALL-32"
#PJM -S
#PJM --spath "results/mpich-org/imb/all/%n.%j.stat"
#PJM -o "results/mpich-org/imb/all/%n.%j.out"
#PJM -e "results/mpich-org/imb/all/%n.%j.err"
#PJM -L "node=8"
#PJM -g "pz0485"
#PJM -L "rscgrp=debug-o"
#PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:30:00"
#PJM -L proc-core=unlimited
#------- Program execution -------#
MPIOPT="-of results/mpich-org/imb/all/%n.%j.out -oferr results/mpich-org/imb/all/%n.%j.err"

NP=32
NPMIN=32
CMD=../bin-org/FJ-IMB-MPI1
##BENCH="PingPong Bcast Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Barrier"
BENCH=

mpiexec -n $NP $MPIOPT $CMD -npmin $NPMIN $BENCH

exit
