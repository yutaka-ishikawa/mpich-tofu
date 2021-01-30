#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB512ALL" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=12:noncont"
#PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:50:30"
#	PJM -L "elapse=00:17:50"
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

##export UTF_TRANSMODE=1	# AGGRESSIVE
export UTF_TRANSMODE=0	# CHAINED

# All: PingPong PingPing Sendrecv Exchange Allreduce Reduce Reduce_local
#  Reduce_scatter Reduce_scatter_block Allgather Allgatherv Gather Gatherv
#  Scatter Scatterv Alltoall Alltoallv Bcast Barrier
#

MEM=0.3	# MEM must be more than 1.005, but 48 ppn cannot allocate such size
NP=512	#
LEN=len5.txt
echo mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -iter $LEN -npmin $NP -mem $MEM
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM
exit
