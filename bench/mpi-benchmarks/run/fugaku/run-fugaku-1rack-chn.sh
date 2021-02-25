#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-1R-CHN" # jobname
#PJM -S
#PJM --spath "results/IMB-1rack/%n.%j.stat"
#PJM -o "results/IMB-1rack/%n.%j.out"
#PJM -e "results/IMB-1rack/%n.%j.err"
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
#	PJM -L "elapse=00:15:40"
#PJM -L "elapse=00:60:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-1rack/%n.%j.out -oferr results/IMB-1rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
export UTF_DEBUG=0x200 # DLEVEL_ERR
export UTF_TRANSMODE=0		# Chained mode
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01

NP=1024
MEM=7

mpich_exec $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM #
exit
