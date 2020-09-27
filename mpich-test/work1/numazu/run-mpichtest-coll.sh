#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-COLL" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#PJM -L "node=4:noncont"
#PJM --mpi "max-proc-per-node=4"
#	PJM -L "elapse=00:30:00"
#PJM -L "elapse=00:0:30"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#
export LD_LIBRARY_PATH=${HOME}/mpich-tofu/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1
export MPIR_CVAR_ALLTOALL_SHORT_MSG_SIZE=2147483647 # 32768 in default (integer value)  
export TEST_INSTDIR=../../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

export TOFULOG_DIR=./results

export UTF_MSGMODE=1	# Rendezous
#export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

echo "UTF_MSGMODE = " $UTF_MSGMODE
echo "TOFULOG_DIR = " $TOFULOG_DIR

echo "LD_LIBRARY_PATH=" $LD_LIBRARY_PATH
echo "TOFU_NAMED_AV = " $TOFU_NAMED_AV
echo "UTF_MSGMODE    = " $UTF_MSGMODE
echo "UTF_TRANSMODE = " $UTF_TRANSMODE "(0: Chained, 1: Aggressive)"
echo "UTF_DEBUG      = " $UTF_DEBUG
echo "TOFULOG_DIR    = " $TOFULOG_DIR
echo "TOFU_DEBUG_FD  = " $TOFU_DEBUG_FD
echo "TOFU_DEBUG_LVL = " $TOFU_DEBUG_LVL

echo "# mpiexec -n 10    ./coll/alltoallw2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/alltoallw2 
echo $? 
exit

echo "# mpiexec -n 4    ./coll/allred2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allred2 
echo $? 
exit

echo "# mpiexec -n 7    ./coll/allred" 
mpiexec -n 7    $TEST_INSTDIR/./coll/allred 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/allred 100" 
mpiexec -n 4    $TEST_INSTDIR/./coll/allred 100
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/allredmany " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allredmany 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/allred2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allred2 
echo $? 

#export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allred3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allred3 
#echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/allred4 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allred4 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/allred5 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/allred5 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allred5 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allred5 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/allred6 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allred6 
echo $? 

#export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/allred6 " 
mpiexec -n 7    $TEST_INSTDIR/./coll/allred6 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/reduce " 
mpiexec -n 5    $TEST_INSTDIR/./coll/reduce 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/reduce " 
mpiexec -n 10    $TEST_INSTDIR/./coll/reduce 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./coll/reduce_local " 
mpiexec -n 2    $TEST_INSTDIR/./coll/reduce_local 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./coll/op_commutative " 
mpiexec -n 2    $TEST_INSTDIR/./coll/op_commutative 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/red3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/red3 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/red4 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/red4 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/alltoall1 " 
mpiexec -n 8    $TEST_INSTDIR/./coll/alltoall1 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/alltoallv " 
mpiexec -n 10    $TEST_INSTDIR/./coll/alltoallv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/alltoallv0 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/alltoallv0 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/alltoallw1 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/alltoallw1 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/alltoallw2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/alltoallw2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./coll/alltoallw_zeros " 
mpiexec -n 1    $TEST_INSTDIR/./coll/alltoallw_zeros 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./coll/alltoallw_zeros " 
mpiexec -n 2    $TEST_INSTDIR/./coll/alltoallw_zeros 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/alltoallw_zeros " 
mpiexec -n 5    $TEST_INSTDIR/./coll/alltoallw_zeros 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/alltoallw_zeros " 
mpiexec -n 8    $TEST_INSTDIR/./coll/alltoallw_zeros 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allgather2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allgather2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allgather3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allgather3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allgatherv2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allgatherv2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allgatherv3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allgatherv3 
echo $? 
export MPIEXEC_TIMEOUT=600
echo "# mpiexec -n 4    ./coll/allgatherv4 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/allgatherv4 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/allgather_struct " 
mpiexec -n 10    $TEST_INSTDIR/./coll/allgather_struct 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/bcasttest " 
mpiexec -n 4    $TEST_INSTDIR/./coll/bcasttest 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/bcasttest " 
mpiexec -n 8    $TEST_INSTDIR/./coll/bcasttest 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/bcasttest " 
mpiexec -n 10    $TEST_INSTDIR/./coll/bcasttest 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./coll/bcastzerotype " 
mpiexec -n 1    $TEST_INSTDIR/./coll/bcastzerotype 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/bcastzerotype " 
mpiexec -n 4    $TEST_INSTDIR/./coll/bcastzerotype 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/bcastzerotype " 
mpiexec -n 5    $TEST_INSTDIR/./coll/bcastzerotype 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/bcastzerotype " 
mpiexec -n 10    $TEST_INSTDIR/./coll/bcastzerotype 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/coll2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/coll2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/gatherv " 
mpiexec -n 5    $TEST_INSTDIR/./coll/gatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll4 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll4 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll5 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll5 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/coll6 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/coll6 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./coll/coll7 " 
mpiexec -n 1    $TEST_INSTDIR/./coll/coll7 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./coll/coll7 " 
mpiexec -n 2    $TEST_INSTDIR/./coll/coll7 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/coll7 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/coll7 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll8 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll8 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll9 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll9 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll10 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll10 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll11 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll11 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll12 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll12 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/coll13 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/coll13 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/longuser " 
mpiexec -n 4    $TEST_INSTDIR/./coll/longuser 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/redscat " 
mpiexec -n 4    $TEST_INSTDIR/./coll/redscat 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 6    ./coll/redscat " 
mpiexec -n 6    $TEST_INSTDIR/./coll/redscat 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/redscat2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/redscat2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/redscat2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/redscat2 
echo $? 

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/redscat2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/redscat2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/redscat3 " 
mpiexec -n 8    $TEST_INSTDIR/./coll/redscat3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/redscatinter " 
mpiexec -n 8    $TEST_INSTDIR/./coll/redscatinter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/red_scat_block " 
mpiexec -n 4    $TEST_INSTDIR/./coll/red_scat_block 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/red_scat_block " 
mpiexec -n 5    $TEST_INSTDIR/./coll/red_scat_block 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/red_scat_block " 
mpiexec -n 8    $TEST_INSTDIR/./coll/red_scat_block 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/red_scat_block2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/red_scat_block2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/red_scat_block2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/red_scat_block2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/red_scat_block2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/red_scat_block2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/redscatblk3 " 
mpiexec -n 8    $TEST_INSTDIR/./coll/redscatblk3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/redscatblk3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/redscatblk3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/redscatbkinter " 
mpiexec -n 8    $TEST_INSTDIR/./coll/redscatbkinter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/redscatbkinter " 
mpiexec -n 10    $TEST_INSTDIR/./coll/redscatbkinter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/scantst " 
mpiexec -n 4    $TEST_INSTDIR/./coll/scantst 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/exscan " 
mpiexec -n 10    $TEST_INSTDIR/./coll/exscan 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/exscan2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/exscan2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/gather " 
mpiexec -n 4    $TEST_INSTDIR/./coll/gather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/gather2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/gather2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/scattern " 
mpiexec -n 4    $TEST_INSTDIR/./coll/scattern 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/scatter2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/scatter2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/scatter3 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/scatter3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/scatterv " 
mpiexec -n 4    $TEST_INSTDIR/./coll/scatterv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/icbcast " 
mpiexec -n 4    $TEST_INSTDIR/./coll/icbcast 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/icbcast " 
mpiexec -n 10    $TEST_INSTDIR/./coll/icbcast 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icallreduce " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icallreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icallreduce " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icallreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icreduce " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icreduce " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icscatter " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icscatter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icscatter " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icscatter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icgather " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icgather " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icallgather " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icallgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icallgather " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icallgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icbarrier " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icbarrier 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icbarrier " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icbarrier 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icallgatherv " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icallgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icallgatherv " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icallgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icgatherv " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icgatherv " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icscatterv " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icscatterv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icscatterv " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icscatterv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icalltoall " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icalltoall 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icalltoall " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icalltoall 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icalltoallv " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icalltoallv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icalltoallv " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icalltoallv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/icalltoallw " 
mpiexec -n 5    $TEST_INSTDIR/./coll/icalltoallw 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 7    ./coll/icalltoallw " 
mpiexec -n 7    $TEST_INSTDIR/./coll/icalltoallw 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opland " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opland 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/oplor " 
mpiexec -n 4    $TEST_INSTDIR/./coll/oplor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/oplxor " 
mpiexec -n 4    $TEST_INSTDIR/./coll/oplxor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/oplxor " 
mpiexec -n 5    $TEST_INSTDIR/./coll/oplxor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opband " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opband 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opbor " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opbor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opbxor " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opbxor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/opbxor " 
mpiexec -n 5    $TEST_INSTDIR/./coll/opbxor 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/opprod " 
mpiexec -n 5    $TEST_INSTDIR/./coll/opprod 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 6    ./coll/opprod " 
mpiexec -n 6    $TEST_INSTDIR/./coll/opprod 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opsum " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opsum 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opmin " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opmin 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/opminloc " 
mpiexec -n 4    $TEST_INSTDIR/./coll/opminloc 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/opmax " 
mpiexec -n 5    $TEST_INSTDIR/./coll/opmax 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/opmaxloc " 
mpiexec -n 5    $TEST_INSTDIR/./coll/opmaxloc 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/uoplong " 
mpiexec -n 4    $TEST_INSTDIR/./coll/uoplong 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 11    ./coll/uoplong " 
mpiexec -n 11    $TEST_INSTDIR/./coll/uoplong 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 16    ./coll/uoplong " 
mpiexec -n 16    $TEST_INSTDIR/./coll/uoplong 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/nonblocking " 
mpiexec -n 4    $TEST_INSTDIR/./coll/nonblocking 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/nonblocking " 
mpiexec -n 5    $TEST_INSTDIR/./coll/nonblocking 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./coll/nonblocking " 
mpiexec -n 10    $TEST_INSTDIR/./coll/nonblocking 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./coll/nonblocking2 " 
mpiexec -n 1    $TEST_INSTDIR/./coll/nonblocking2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/nonblocking2 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/nonblocking2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/nonblocking2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/nonblocking2 
echo $? 
export MPIEXEC_TIMEOUT=420
echo "# mpiexec -n 10    ./coll/nonblocking2 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/nonblocking2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./coll/nonblocking3 " 
mpiexec -n 1    $TEST_INSTDIR/./coll/nonblocking3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/nonblocking3 " 
mpiexec -n 4    $TEST_INSTDIR/./coll/nonblocking3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/nonblocking3 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/nonblocking3 
echo $? 
export MPIEXEC_TIMEOUT=600
echo "# mpiexec -n 10    ./coll/nonblocking3 " 
mpiexec -n 10    $TEST_INSTDIR/./coll/nonblocking3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./coll/iallred " 
mpiexec -n 2    $TEST_INSTDIR/./coll/iallred 
echo $? 
export MPIEXEC_TIMEOUT=30
echo "# mpiexec -n 2    ./coll/ibarrier " 
mpiexec -n 2    $TEST_INSTDIR/./coll/ibarrier 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nballtoall1 " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nballtoall1 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./coll/nbcoll2 " 
mpiexec -n 5    $TEST_INSTDIR/./coll/nbcoll2 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/nbredscat " 
mpiexec -n 4    $TEST_INSTDIR/./coll/nbredscat 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbredscat " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbredscat 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbredscat3 " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbredscat3 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbredscatinter " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbredscatinter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicbcast " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicbcast 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicallreduce " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicallreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicreduce " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicreduce 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicscatter " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicscatter 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicgather " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicallgather " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicallgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicbarrier " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicbarrier 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicallgatherv " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicallgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicgatherv " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicscatterv " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicscatterv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicalltoall " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicalltoall 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicalltoallv " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicalltoallv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./coll/nbicalltoallw " 
mpiexec -n 8    $TEST_INSTDIR/./coll/nbicalltoallw 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/neighb_allgather " 
mpiexec -n 4    $TEST_INSTDIR/./coll/neighb_allgather 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/neighb_allgatherv " 
mpiexec -n 4    $TEST_INSTDIR/./coll/neighb_allgatherv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/neighb_alltoall " 
mpiexec -n 4    $TEST_INSTDIR/./coll/neighb_alltoall 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/neighb_alltoallv " 
mpiexec -n 4    $TEST_INSTDIR/./coll/neighb_alltoallv 
echo $? 
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./coll/neighb_alltoallw " 
mpiexec -n 4    $TEST_INSTDIR/./coll/neighb_alltoallw 
echo $? 
