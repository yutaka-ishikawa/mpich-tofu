#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB64-2" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=16:noncont"
#	PJM -L "node=8:noncont"
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=2"
#	PJM --mpi "max-proc-per-node=8"
#PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:10:50"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-all,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
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
#export UTF_DBGTIMER_INTERVAL=30
#export UTF_DBGTIMER_ACTION=1
#export UTF_INJECT_COUNT=4
export UTF_INJECT_COUNT=1
export UTF_ASEND_COUNT=1 # added on 2021/01/02
#export UTF_DEBUG=0x4200	# DLEVEL_ERR|DLEVEL_STATISTICS
export UTF_DEBUG=0x200	# DLEVEL_ERR

#BENCH=Allreduce Reduce Reduce_scatter Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Bcast Barrier
#BENCH="Reduce Allreduce Reduce_scatter Allgather Barrier"	# 7 min
BENCH="Reduce Allreduce"	# 25sec
export UTF_COMDEBUG=1

NP=64
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len2.txt $BENCH	#
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH	#
exit

#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len2.txt $BENCH	#
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH	#
exit
