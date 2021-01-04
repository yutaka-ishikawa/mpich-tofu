#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-LLIO-1rack" # jobname
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
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#PJM --llio sharedtmp-size=1Gi,localtmp-size=8Gi
#------- Program execution -------#

MPIOPT="-of results/IMB-1rack/%n.%j.out -oferr results/IMB-1rack/%n.%j.err"

echo "llio_transfer /home/g9300001/u93027/work/mpich-tofu/mpi-benchmarks/IMB-MPI1 \
    /home/g9300001/u93027/mpich-tofu/bin/mpich_exec \
    /home/g9300001/u93027/mpich-tofu/lib/libmpicxx.so.0 \
    /home/g9300001/u93027/mpich-tofu/lib/libmpi.so.0 \
    /home/g9300001/u93027/mpich-tofu/lib/libutf.so \
    /home/g9300001/u93027/mpich-tofu/lib/libfabric.so.1"
llio_transfer /home/g9300001/u93027/work/mpich-tofu/mpi-benchmarks/IMB-MPI1 \
    /home/g9300001/u93027/mpich-tofu/bin/mpich_exec \
    /home/g9300001/u93027/mpich-tofu/lib/libmpicxx.so.0 \
    /home/g9300001/u93027/mpich-tofu/lib/libmpi.so.0 \
    /home/g9300001/u93027/mpich-tofu/lib/libutf.so \
    /home/g9300001/u93027/mpich-tofu/lib/libfabric.so.1

echo -e "[llio_transfer]: $?\n"

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

BENCH="Alltoall"
echo "Testing lliotransfer"

NP=1536
mpich_exec $MPIOPT ../../IMB-MPI1 -mem 5 -npmin $NP -msglen len4.txt $BENCH
#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 5 -npmin $NP -msglen len2.txt $BENCH

echo "ldd"
export LD_LIBRARY_PATH=${HOME}/mpich-tofu/lib:$LD_LIBRARY_PATH
ldd ../../IMB-MPI1
exit
