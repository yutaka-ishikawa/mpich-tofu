#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-COLL" # jobname
#PJM -S
#PJM --spath "results/IMB-coll/%n.%j.stat"
#PJM -o "results/IMB-coll/%n.%j.out"
#PJM -e "results/IMB-coll/%n.%j.err"
#
#	PJM -L "node=4"
#	PJM -L "node=256"
#	PJM -L "node=32"
#	PJM -L "node=64"
#	PJM -L "node=128"
#PJM -L "node=384"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=32"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck1,jobenv=linux2"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-coll/%n.%j.out -oferr results/IMB-coll/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
##export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_DEBUG=0x200 # DLEVEL_ERR
#export UTF_INJECT_COUNT=1
export UTF_INJECT_COUNT=4	# This works
export UTF_ASEND_COUNT=1	# turn on 2021/01/02

#BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"

OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier" # it takes 14:56
COLLBENCH="Alltoall"	# 384procs takes 2:55 
#COLLBENCH="Alltoall"	# 1536procs takes 3:47
#COLLBENCH="Allreduce"	# 1536procs takes 0:27
#COLLBENCH="Allgather"	# 1536procs takes 0:27
#NP=1536
#NP=384
#NP=512  
#NP=128 # 00:20
#NP=32
#NP=4
#MEM=0.9

# Alltoall: len4, 256/22, 1024/27, 1536/40
COLLBENCH="Alltoall"	# 384procs
MEM=6.5
#NP=1024
NP=1536

mpich_exec $MPIOPT ../../IMB-MPI1 -mem $MEM -npmin $NP -msglen len4.txt $COLLBENCH
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem $MEM -npmin $NP -msglen len5.txt $OKBENCH
exit

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 6.5 -npmin $NP $OKBENCH
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 6.5 -npmin $NP $COLLBENCH
exit
