#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-9R-CHN" # jobname
#PJM -S
#PJM --spath "results/IMB-9rack/%n.%j.stat"
#PJM -o "results/IMB-9rack/%n.%j.out"
#PJM -e "results/IMB-9rack/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#	PJM -L "node=384"
#PJM -L "node=3456"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=16"
#	PJM -L "elapse=00:0:40"
#	PJM -L "elapse=00:10:00"
#PJM -L "elapse=00:50:00"
#	PJM -L "elapse=00:40:00"
#	PJM -L "elapse=00:10:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-9rack/%n.%j.out -oferr results/IMB-9rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
export UTF_DEBUG=0x200 # DLEVEL_ERR
export UTF_TRANSMODE=0		# Chained mode
#export UTF_ARMA_COUNT=2	# must be defined in mpich.env 2021/02/01

##export UTF_DEBUG=0x040000	# STAG
####export MPIR_CVAR_SCATTERV_INTRA_ALGORITHM=linear, now defined in mpich.env
NP=8192
LENFILE=len-gather-8192.txt
MEM=7

#export UTF_DBGTIMER_INTERVAL=120
#export UTF_DBGTIMER_ACTION=1
##export UTF_DEBUG=0x10000	# showing initializing step

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE
exit
