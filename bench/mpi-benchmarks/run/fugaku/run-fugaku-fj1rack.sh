#!/bin/bash
#------ pjsub option --------#
#PJM -N "FJ" # jobname
#PJM -S
#PJM --spath "results/IMB-fj1rack/%n.%j.stat"
#PJM -o "results/IMB-fj1rack/%n.%j.out"
#PJM -e "results/IMB-fj1rack/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#PJM -L "node=384"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM -L "elapse=00:10:00"
#PJM -L "elapse=00:5:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-fj1rack/%n.%j.out -oferr results/IMB-fj1rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug

BENCH="AllGatherv"
#NP=16
NP=1536
MEM=7

mpiexec -np $NP $MPIOPT ../../IMB-MPI1-fj -mem $MEM -npmin $NP $BENCH

#ldd ../../IMB-MPI1-fj
#mpiexec -np $NP $MPIOPT ../../IMB-MPI1-fj -mem 8.1 -npmin $NP -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
