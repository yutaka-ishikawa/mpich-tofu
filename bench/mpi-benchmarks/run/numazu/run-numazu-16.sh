#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB16" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#	PJM -L "node=2:noncont"
#PJM -L "node=8:noncont"
#	PJM -L "node=8:noncont"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=2"
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=4"
#PJM -L "elapse=00:02:20"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack1,jobenv=linux"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#MPIOPT="-of results/%n.%j.out -oferr results/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export UTF_DEBUG=0x1c	# PROTOCOL|EAGER|RENDEZOUS
#export UTF_DEBUG=0x1000	# COM
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
export UTF_DBGTIMER_INTERVAL=120
export UTF_DBGTIMER_ACTION=1

NP=16
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Alltoallv Alltoall Allreduce
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Allreduce Alltoall
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Reduce Allreduce
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Allreduce
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP Reduce OK
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP
exit

##mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP

#ITER=100
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -msglen len.txt -iter $ITER

#ITER=100
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -iter $ITER -msglen len.txt Gatherv # OK on TAGGED 20201227 5 sec

#ITER=1
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -iter $ITER -msglen len.txt Gatherv

#ITER=100
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -iter $ITER	#
#
#ITER=1
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -iter $ITER -msglen len.txt Gatherv
#
# PASS on AM 17sec MPICH-IMB16.32198 2020/12/27
#ITER=1
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -iter $ITER Scatter Scatterv Alltoall Alltoallv Bcast  Barrier
exit

#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len.txt Gatherv Scatter Scatterv Alltoall Alltoallv Bcast  Barrier
#mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len.txt Alltoall
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len.txt
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
