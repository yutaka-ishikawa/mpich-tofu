#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-48-8rack" # jobname
#PJM -S
#PJM --spath "results/IMB-48rack/%n.%j.stat"
#PJM -o "results/IMB-48rack/%n.%j.out"
#PJM -e "results/IMB-48rack/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#PJM -L "node=18432"
#	PJM -L "node=24x24x32:strict"
#	PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=4"
#PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:40:00"
#	PJM -L "elapse=00:10:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-48rack/%n.%j.out -oferr results/IMB-48rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
##export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_INJECT_COUNT=1
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
#export UTF_DEBUG=0x10200	# showing initializing step and DLELEL_ERR
export UTF_TRANSMODE=0		# Chained mode

#BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#BENCH="Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier" #
##OKBENCH="Alltoall" # OK, step3-4=67.521144sec, elapse=06:42

OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"
OKBENCH3="Gatherv Scatterv"

########
#  00:27:15 (1635), 4976925, 2021/02/02
########

#NP=147456
NP=131072
LENFILE=len-gather-131072.txt
MEM=3

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1 #
echo
echo
echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2 #
echo
echo
echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH3 #
exit


