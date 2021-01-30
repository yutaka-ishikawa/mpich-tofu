#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB64" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=8:noncont"
#	PJM -L "node=8:noncont"
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=2"
#PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:2:00"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack1,jobenv=linux"
#PJM -L proc-core=unlimited
#------- Program execution -------#
MPIOPT="-of results/%n.%j.out -oferr results/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1 # MPICH-Tofu parameters are shown by mpich_exec script
export UTF_INFO=0x1	# utf parameters are shown at begining
#export TOFU_INFO=1	# showing internal structures on all procs at finalization
#export UTF_COMDEBUG=1	# showing internal structures on all procs at finalization
#export TOFU_COMDEBUG=1 # showing internal structures on all procs at finalization
#export UTF_DBGTIMER_INTERVAL=10
#export UTF_DBGTIMER_ACTION=1

#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
#export TOFU_MIN_MULTI_RECV=1047552
##export TOFU_MIN_MULTI_RECV=1048064

#export UTF_DEBUG=0x200		# DLEVEL_ERR
#export UTF_INJECT_COUNT=4	#
export UTF_INJECT_COUNT=1	#
export UTF_ASEND_COUNT=1	#

MEM=3.5
# All
# PingPong PingPing Sendrecv Exchange Allreduce Reduce Reduce_local Reduce_scatter Reduce_scatter_block Allgather
# Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Bcast Barrier

#BENCH=Allreduce Reduce Reduce_scatter Allgather Allgatherv Gather Gatherv Scatter Scatterv Alltoall Alltoallv Bcast Barrier
BENCH="Reduce Allreduce Reduce_scatter Allgather Barrier"

NP=64
#
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH  # 3:05 using AM 2021/01/13
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH # 4:17 using TAGGED 2021/01/13
exit
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len2.txt $BENCH	# 1:51 using TAGGED
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len2.txt $BENCH	# 1:17 using AM

#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len2.txt $BENCH	#
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP $BENCH	#
exit
