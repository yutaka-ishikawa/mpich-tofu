#!/bin/bash
#------ pjsub option --------#
#PJM -N "FJIMBNOCK-PINGPONG"
#PJM -S
#PJM --spath "results/mpich-org/imb/pp/%n.%j.stat"
#PJM -o "results/mpich-org/imb/pp/%n.%j.out"
#PJM -e "results/mpich-org/imb/pp/%n.%j.err"
#	#PJM -L "node=4"
#	PJM -L "node=8"
#PJM -L "node=2"
#PJM -g "pz0485"
#PJM -L "rscgrp=debug-o"
#PJM --mpi "max-proc-per-node=1"
#PJM -L "elapse=00:3:0"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#MPIOPT="-of-proc results/mpich-org/imb/pp/%n.%j.out -oferr-proc results/mpich-org/imb/pp/%n.%j.err"
MPIOPT="-of results/mpich-org/imb/pp/%n.%j.out -oferr results/mpich-org/imb/pp/%n.%j.err"

NP=2
CMD=../bin-org/FJ-IMB-MPI1-NOCHK
BENCH="PingPong"
LENFILE=len-pingpong.txt
MEM=3	# in GB
MSGLOG="0:30"

mpiexec -n $NP $MPIOPT $CMD -msglen $LENFILE -mem $MEM -msglog $MSGLOG $BENCH
exit
