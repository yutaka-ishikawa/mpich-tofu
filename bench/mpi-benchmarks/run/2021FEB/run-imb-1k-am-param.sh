#!/bin/bash
#------ pjsub option --------#
#PJM -N "M-IMB-1K-AM-PARAM" # jobname
#PJM -S
#PJM --spath "results/IMB-1K/%n.%j.stat"
#PJM -o "results/IMB-1K/%n.%j.out"
#PJM -e "results/IMB-1K/%n.%j.err"
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
#PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

. ./def-am-param.sh

MPIOPT="-of results/IMB-1K/%n.%j.out -oferr results/IMB-1K/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
export UTF_DEBUG=0x200 # DLEVEL_ERR
export UTF_TRANSMODE=0		# Chained mode
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01

NP=1024
LENFILE=len-gather-1024.txt
MEM=7

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM

