#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB32" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#	PJM -L "node=2:noncont"
#PJM -L "node=4:noncont"
#	PJM -L "node=8:noncont"
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=2"
#PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=4"
#	PJM -L "elapse=00:10:15"
#PJM -L "elapse=00:16:30"
#	PJM -L "elapse=00:2:30"
#	PJM -L "elapse=00:22:00"
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
NP=32
#LENFILE=len3.txt # 32 sec for all  collectives
#LENFILE=len2.txt  # 1:32 sec for all  collectives
#LENFILE=len2-2.txt  # 
LENFILE=len4.txt
#ITER=1000
#ITER=100
OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier"

mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM # 9:35 in Tagged mode
exit
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM # 06:40 in AM mode
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH # 05:25 in Tagged mode
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM Alltoallv Alltoall Bcast Barrier # 2:15
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE -iter $ITER Alltoallv # 3sec, iter=100
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM # All
exit

#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM Gatherv #
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE Allgatherv Gather # does work with len2.txt
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE # deadlock around Gather
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen len2.txt Gather # does not work with len2.txt
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE Gatherv # does not work with len2.txt
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE
exit


mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Alltoallv Alltoall	# 1:31
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len.txt Gatherv Scatter Scatterv Alltoall Alltoallv Bcast  Barrier
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len.txt Alltoall
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len.txt
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
