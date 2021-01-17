#!/bin/bash
#------ pjsub option --------#
#PJM -N "MPICH-IMB-fjcoll" # jobname
#PJM -S
#PJM --spath "results/IMB-fjcoll/%n.%j.stat"
#PJM -o "results/IMB-fjcoll/%n.%j.out"
#PJM -e "results/IMB-fjcoll/%n.%j.err"
#
#PJM -L "node=256"
#	PJM -L "node=384"
#	PJM -L "node=64"
#	PJM -L "node=128"
#	PJM -L "node=384"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM -L "elapse=00:10:00"
#PJM -L "elapse=00:13:00"
#
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck2,jobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#
MPIOPT="-of results/IMB-fjcoll/%n.%j.out -oferr results/IMB-fjcoll/%n.%j.err"

#COLLBENCH="Alltoall"	# 00:32 with len4.txt and NP=32
#LENFILE=len4.txt
COLLBENCH="Reduce_scatter"
LENFILE=len6.txt
#MEM=6.5
#MEM=3.5
MEM=4.1
NP=1024
mpiexec -np $NP $MPIOPT ../../IMB-MPI1-fj -mem $MEM -npmin $NP -msglen $LENFILE $COLLBENCH
exit

ldd ../../IMB-MPI1-fj
#mpiexec -np $NP $MPIOPT ../../IMB-MPI1-fj -mem 8.1 -npmin $NP -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 -npmin 64 Allreduce -msglen len.txt

#mpich_exec $MPIOPT ../../IMB-MPI1 -mem 8.1 #GB
