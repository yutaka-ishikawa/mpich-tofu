#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-1rack-TAGGED" # jobname
#PJM -S
#PJM --spath "results/IMB-1rack/%n.%j.stat"
#PJM -o "results/IMB-1rack/%n.%j.out"
#PJM -e "results/IMB-1rack/%n.%j.err"
#
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#PJM -L "node=384"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=00:10:40"
#	PJM -L "elapse=00:50:40"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-1rack/%n.%j.out -oferr results/IMB-1rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
##export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_ASEND_COUNT=1	# turn on 2021/01/02
export UTF_TRANSMODE=0		# Chained mode
export UTF_ARMA_COUNT=2		# must be defined in mpich.env 2021/02/01
export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=1

#BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#BENCH="Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"

# UTF_INJECT_COUNT=1, UTF_ASEND_COUNT=1
# up to 18432 procs (384 nodes x 48 ppn) equiv to 12 racks x 4 ppn
# PASS with -msglen len2.txt, 5:58, 20210102/MPICH-IMB-1rack.4761870.out and 4761869.out
# PASS with -mem 0.5, 16:09,  20210102/MPICH-IMB-1rack.4761901.out
#
# UTF_INJECT_COUNT=4, UTF_ASEND_COUNT=1
# PASS with -mem 0.5, 17:40,  20210102/MPICH-IMB-1rack.4761932.out
#

# PASS with -mem 7
#	Allreduce, Reduce, Gather, Bcast, Barrier
# Error with -mem 7
# Allgather, Allgatherv: SigSeg in 2097152 byte on 2021/01/14
# Scatter:  address error in 2097152 byte on 2021/01/14, MPICH-IMB-1rack.4849213.out
# Alltoall: no more RMA in 16384 byte on 2021/01/14
#

NP=1024
LENFILE=len-gather-1024.txt
MEM=7
BENCH="Gatherv Scatter Scatterv Alltoall Alltoallv Bcast Barrier"

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $BENCH"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $BENCH
exit


OKBENCH1="Allreduce Reduce Alltoall Bcast Barrier"
OKBENCH2="Allgather Allgatherv Gather Scatter"

NP=1024
LENFILE=len-gather-1024.txt
MEM=7

echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH1 #
echo
echo
echo "mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2"
mpich_exec -n $NP $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $LENFILE $OKBENCH2 #
exit

#ERRBENCH="AllGatherv"	# 1:06 with len-gather.txt on 1024 procs
ERRLENFILE=len-gather.txt
#mpich_exec $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $ERRLENFILE $OKBENCH #
exit
#mpich_exec $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM -msglen $ERRLENFILE $ERRBENCH #

#mpich_exec $MPIOPT ../../IMB-MPI1 -npmin $NP -mem $MEM $OKBENCH #
exit

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 0.5 -npmin 18432 $OKBENCH # 0.5GiB * 48 = 24 GiB
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 18432 -msglen len2.txt $OKBENCH #
exit
#
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 18432 $OKBENCH # Memory Exceeds
#

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 18432 -msglen len2.txt Alltoall # 1:15
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 3072 -msglen len2.txt Alltoall # 1:03
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 1536 -msglen len2.txt Alltoall # 54 sec
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 384 -msglen len2.txt Alltoall # 25 sec
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len2.txt Alltoall
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 32 -msglen len2.txt Gatherv

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
