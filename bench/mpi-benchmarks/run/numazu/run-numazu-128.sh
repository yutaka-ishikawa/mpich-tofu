#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB128" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=8:noncont"
#PJM --mpi "max-proc-per-node=16"
#PJM -L "elapse=00:03:30"
#	PJM -L "elapse=00:15:50"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-all,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
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
#export UTF_DBGTIMER_INTERVAL=20
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

# All: PingPong PingPing Sendrecv Exchange Allreduce Reduce Reduce_local
#  Reduce_scatter Reduce_scatter_block Allgather Allgatherv Gather Gatherv
#  Scatter Scatterv Alltoall Alltoallv Bcast Barrier
#
# PingPong PingPing Sendrecv Exchange: no more room because processes not participating benchmarking waits for
# Reduce_scatter, Gatherv: no more room using 256 procs
#BENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Scatterv Alltoall Alltoallv Bcast Barrier"
#BENCH="Alltoall"
#BENCH="Scatterv"
BENCH="Allgather"

MEM=1.5	# MEM must be more than 1.005, but 32 ppn cannot allocate such size
NP=128
echo mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $BENCH #
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $BENCH	#
exit
