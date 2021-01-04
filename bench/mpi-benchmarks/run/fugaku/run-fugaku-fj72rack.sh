#!/bin/bash
#------ pjsub option --------#
#PJM -N "FJ-IMB-fj72rack" # jobname
#PJM -S
#PJM --spath "results/IMB-fj72rack/%n.%j.stat"
#PJM -o "results/IMB-fj72rack/%n.%j.out"
#PJM -e "results/IMB-fj72rack/%n.%j.err"
#
#PJM -L "node=27648"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:50:00"
#	PJM -L "elapse=00:3:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-fj72rack/%n.%j.out -oferr results/IMB-fj72rack/%n.%j.err"

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
export UTF_DEBUG=0x4200 # DLEVEL_ERR|DLEVEL_STATISTICS  
export UTF_INJECT_COUNT=1

#NP=27648 # with len2.txt
NP=110592 # with len2.txt, elapsetime=10min

#
# IMB: PingPong, PingPing, Sendrecv, Exchange, Allreduce, Reduce, Reduce_local, Reduce_scatter, Reduce_scatter_block
#      Allgather, Allgatherv, Gather, Gatherv, Scatter, Scatterv, Alltoall, Alltoallv, Bcast, Barrier
#
# This is for comparion purpose
OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier" # 7:10sec 20210101

echo "mpiexec " $MPIOPT "../../IMB-MPI1-fj -mem 5 -npmin " $NP "-msglen len2.txt " $OKBENCH
mpiexec $MPIOPT ../../IMB-MPI1-fj -mem 5 -npmin $NP -msglen len2.txt $OKBENCH #

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt $OKBENCH #
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt $BENCH #
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt Alltoall #

exit
