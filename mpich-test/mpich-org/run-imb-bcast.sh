#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-MPICH-BCAST"
#PJM -S
#PJM --spath "results/mpich-org/imb/bcast/%n.%j.stat"
#PJM -o "results/mpich-org/imb/bcast/%n.%j.out"
#PJM -e "results/mpich-org/imb/bcast/%n.%j.err"
#	#PJM -L "node=4"
#	PJM -L "node=8"
#PJM -L "node=16"
#PJM -g "pz0485"
#PJM -L "rscgrp=debug-o"
#PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:01:00"
#PJM -L proc-core=unlimited
#------- Program execution -------#

##MPIOPT="-of-proc results/mpich-org/imb/bcast/%n.%j.out -oferr-proc results/mpich-org/imb/bcast/%n.%j.err"
MPIOPT="-of results/mpich-org/imb/bcast/%n.%j.out -oferr results/mpich-org/imb/bcast/%n.%j.err"
export MPICH_HOME=/data/01/pz0485/z30485/mpich-tofu-org/
export PATH=$PATH:$MPICH_HOME/bin:$PATH
which mpich_exec
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1

#
#
# UTF_MSGMODE (0: Eager, 1: Rendezous)
#	Eager in default
# UTF_TRANSMODE (0: Chained, 1: Aggressive)
#	Aggressive in default
export MPICH_TOFU_SHOW_PARAMS=1
## export UTF_TRANSMODE=0  # looks work, really ??
export UTF_TRANSMODE=1
export UTF_MSGMODE=0

#NP=32
NP=64
CMD=../bin-org/IMB-MPI1
BENCH="Bcast"
LENFILE=len-bcast.txt
MEM=3	# in GB
##MSGLOG="0:31"
MSGLOG="0:30"
NPMIN=64

mpich_exec -n $NP $MPIOPT \
	   $CMD -msglen $LENFILE -mem $MEM -msglog $MSGLOG -npmin $NPMIN \
	   $BENCH
#
#mpich_exec -n $NP $MPIOPT \
#	   $CMD -msglen $LENFILE -mem $MEM $BENCH
exit
