#!/bin/bash
#------ pjsub option --------#
#PJM -N "IMB-PINGPONG"
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

#MPIOPT="-of results/mpich-org/imb/all/%n.%j.out -oferr results/mpich-org/imb/all/%n.%j.err"
MPIOPT="-of-proc results/mpich-org/imb/pp/%n.%j.out -oferr-proc results/mpich-org/imb/pp/%n.%j.err"
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
export UTF_TOFU_SHOW_RCOUNT=1
export UTOFU_SWAP_PROTECT=1

export UTF_TRANSMODE=1
export UTF_MSGMODE=0	### NEEDS FOR TAGGED
export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=1
export MPIR_CVAR_CH4_OFI_ENABLE_AM=0
# EAGER(0x8) PROTOCOL(0x4) UTOFU(0x2)
#export UTF_DEBUG=0x000e
# EAGER(0x8) PROTOCOL(0x4) COMM(0x001000)
#export UTF_DEBUG=0x00100c
# COMM(0x001000)
#export UTF_DEBUG=0x001000

NP=2
CMD=../bin-org/IMB-MPI1
BENCH="PingPong"
LENFILE=len-pingpong.txt
MEM=3	# in GB
MSGLOG="0:30"

mpich_exec -n $NP $MPIOPT $CMD -msglen $LENFILE -mem $MEM -msglog $MSGLOG $BENCH
exit
