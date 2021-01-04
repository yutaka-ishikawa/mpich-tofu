#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-lliio-72-4rack" # jobname
#PJM -S
#PJM --spath "results/IMB-72rack/%n.%j.stat"
#PJM -o "results/IMB-72rack/%n.%j.out"
#PJM -e "results/IMB-72rack/%n.%j.err"
#
#PJM -L "node=27648"
#	PJM -L "node=24x24x48:strict"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:0:40"
#	PJM -L "elapse=00:50:00"
#PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:3:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-72rack/%n.%j.out -oferr results/IMB-72rack/%n.%j.err"

llio_transfer /home/g9300001/u93027/mpich-tofu/bin/mpich_exec
llio_transfer /home/g9300001/u93027/mpich-tofu/lib/libmpi.so
llio_transfer /home/g9300001/u93027/mpich-tofu/lib/libmpi.so.0
llio_transfer /home/g9300001/u93027/mpich-tofu/lib/libmpi.so.0.0.0
llio_transfer /home/g9300001/u93027/mpich-tofu/lib/libmpi.so.12
llio_transfer /home/g9300001/u93027/mpich-tofu/lib/libutf.so

export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
#export UTF_DEBUG=0xffffff
#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
export UTF_DEBUG=0x200 # DLEVEL_ERR
export UTF_INJECT_COUNT=1
export UTF_ASEND_COUNT=1	# turn on 20210102
export UTF_DEBUG=0x10000	# showing initializing step

#
# IMB: PingPong, PingPing, Sendrecv, Exchange, Allreduce, Reduce, Reduce_local, Reduce_scatter, Reduce_scatter_block
#      Allgather, Allgatherv, Gather, Gatherv, Scatter, Scatterv, Alltoall, Alltoallv, Bcast, Barrier
#
## PASS: Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier
## NO ROOM: Gatherv Alltoallv Reduce_scatter
## DEADLOCK ?: Reduce_local Reduce_scatter_block
##BENCH="Allreduce Reduce Allgather Allgatherv Gather Gatherv Scatter Alltoall Alltoallv Bcast Barrier"
#OKBENCH="Allreduce Reduce Allgather Allgatherv Gather Scatter Alltoall Bcast Barrier"
OKBENCH="Alltoall"

#NP=27648 # with len2.txt + Alltoall 3:46
NP=110592 # with len3.txt + Alltoall ??

echo "**** MPICH TEST ****"
echo "mpich_exec " $MPIOPT "../../IMB-MPI1 -mem 5 -npmin " $NP "-msglen len3.txt " $OKBENCH
mpich_exec $MPIOPT ../../IMB-MPI1 -mem 5 -npmin $NP -msglen len3.txt $OKBENCH #

exit
#echo "mpich_exec " $MPIOPT "../../IMB-MPI1 -mem 5 -npmin " $NP "-msglen len2.txt " $OKBENCH
##mpich_exec $MPIOPT ../../IMB-MPI1 -mem 5 -npmin $NP -msglen len2.txt $OKBENCH #

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt $OKBENCH #
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt $BENCH #
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin $NP -msglen len2.txt Alltoall #

exit
