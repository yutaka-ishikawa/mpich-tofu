#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB2" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=2:noncont"
#PJM --mpi "max-proc-per-node=1"
#PJM -L "elapse=00:00:10"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack1,jobenv=linux"
#PJM -L proc-core=unlimited
#------- Program execution -------#
MPIOPT="-of results/%n.%j.out -oferr results/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
#export UTF_DBGTIMER_INTERVAL=200
#export UTF_DBGTIMER_ACTION=1

#BENCH = Allreduce Reduce Reduce_scatter Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Bcast Barrier
BENCH=PingPong
NP=2
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH	#
exit
