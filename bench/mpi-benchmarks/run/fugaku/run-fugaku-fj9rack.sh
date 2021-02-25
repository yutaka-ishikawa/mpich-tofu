#!/bin/bash
#------ pjsub option --------#
#PJM -N "FJ-IMB-fj9rack" # jobname
#PJM -S
#PJM --spath "results/IMB-fj9rack/%n.%j.stat"
#PJM -o "results/IMB-fj9rack/%n.%j.out"
#PJM -e "results/IMB-fj9rack/%n.%j.err"
#
#PJM -L "node=3456"
#	PJM --mpi "max-proc-per-node=1"
#PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=8"
#	PJM --mpi "max-proc-per-node=16"
#	PJM --mpi "max-proc-per-node=48"
#	PJM -L "elapse=00:0:40"
#PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:3:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-llio"
#PJM -L proc-core=unlimited
#------- Program execution -------#

MPIOPT="-of results/IMB-fj9rack/%n.%j.out -oferr results/IMB-fj9rack/%n.%j.err"

BENCH="Alltoall"
NP=8192

echo "mpiexec -n " $NP $MPIOPT "../../IMB-MPI1-fj -mem 5 -npmin " $NP "-msglen len2.txt " $BENCH
mpiexec -n $NP $MPIOPT ../../IMB-MPI1-fj -mem 5 -npmin $NP -msglen len2.txt $BENCH #

exit
