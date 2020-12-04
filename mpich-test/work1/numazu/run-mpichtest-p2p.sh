#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST-P2P" # jobname
#PJM -S		# output statistics
#PJM --spath "./results/%n.%j.stat"
#PJM -o "./results/%n.%j.out"
#PJM -e "./results/%n.%j.err"
#
#	PJM -L "node=12:noncont"
#	PJM -L "node=4:noncont"
#	PJM --mpi "max-proc-per-node=4"
#	PJM -L "node=2:noncont"
#PJM -L "node=4:noncont"
#PJM --mpi "max-proc-per-node=4"
#	PJM -L "elapse=00:20:00"
#	PJM -L "elapse=00:30:00"
#	PJM -L "elapse=00:10:00"
#	PJM -L "elapse=00:6:00"
#	PJM -L "elapse=00:2:40"
#PJM -L "elapse=00:0:15"
#	PJM -L "elapse=00:2:30"
#PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r1"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvmck1"
#PJM -L proc-core=unlimited
#------- Program execution -------#
#
export LD_LIBRARY_PATH=${HOME}/mpich-tofu/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1
export TEST_INSTDIR=../../../mpich/test/mpi
export MPIEXEC_TIMEOUT=180

##export TOFULOG_DIR=./results
#export UTF_MSGMODE=1	# Rendezous
export UTF_MSGMODE=0	# Eager
#export UTF_TRANSMODE=0	# Chained
export UTF_TRANSMODE=1	# Aggressive
export TOFU_NAMED_AV=1

#export FI_LOG_PROV=tofu
#export FI_LOG_LEVEL=Debug
#export FI_LOG_LEVEL=Core

#export UTF_DEBUG=0x3c	# PROTOCOL EAGER RENDEZOUS RMA
#export UTF_DEBUG=0x41c	# INIFIN PROTOCOL EAGER RENDEZOUS
#export UTF_DEBUG=0xff
#export UTF_DEBUG=0x94
#export TOFU_DEBUG_FD=3
#export TOFU_DEBUG_LVL=3
#export MPITEST=1

echo "LD_LIBRARY_PATH=" $LD_LIBRARY_PATH
echo "TOFU_NAMED_AV = " $TOFU_NAMED_AV
echo "UTF_MSGMODE    = " $UTF_MSGMODE
echo "UTF_TRANSMODE = " $UTF_TRANSMODE "(0: Chained, 1: Aggressive)"
echo "UTF_DEBUG      = " $UTF_DEBUG
echo "TOFULOG_DIR    = " $TOFULOG_DIR
echo "TOFU_DEBUG_FD  = " $TOFU_DEBUG_FD
echo "TOFU_DEBUG_LVL = " $TOFU_DEBUG_LVL
#cho "MPITEST        = " $MPITEST

export MPITEST_VERBOSE=1
export MPIR_CVAR_CH4_OFI_ENABLE_MR_VIRT_ADDRESS=1
export MPIR_CVAR_CH4_OFI_ENABLE_RMA=1
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
#export MPIR_CVAR_CH4_OFI_ENABLE_TAGGED=0
export UTF_DEBUG=0x1000	# COMM

echo "UTF_MSGMODE    = " $UTF_MSGMODE
echo "MPIR_CVAR_CH4_OFI_ENABLE_TAGGED = " $MPIR_CVAR_CH4_OFI_ENABLE_TAGGED

echo "# mpiexec -n 2    ./pt2pt/large_tag "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/large_tag  
echo $?
exit

echo "# mpiexec -n 2  pt2pt/mprobe"
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/mprobe
echo -e "[RETURN-VAL]: $?\n"
exit


echo "#mpiexec -n 4    ./pt2pt/sendall "
timeout --preserve-status -k 2 30s mpiexec -n 4    /home/users/ea01/ea0103/work/mpich-tofu/mpich/test/mpi/pt2pt/sendall
echo $?
exit

echo -e "[TESTNAME]: large_message\n[OUTPUT]:" | tee -a /dev/stderr
mpiexec -n 3  $TEST_INSTDIR/./pt2pt/large_message
echo -e "[RETURN-VAL]: $?\n"

exit

echo "# mpiexec -n 2  pt2pt/multi_psend_derived"
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/multi_psend_derived
echo -e "[RETURN-VAL]: $?\n"

echo "# mpiexec -n 2  pt2pt/mprobe"
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/mprobe
echo -e "[RETURN-VAL]: $?\n"
exit

###################################################################
echo "# mpiexec -n 2    ./errors/rma/cas_type_check "
mpiexec -n 2    $TEST_INSTDIR/./errors/rma/cas_type_check  
echo $?
#echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_free_at "
#mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_free_at  
#echo $?
#
#ldd $TEST_INSTDIR/./errors/rma/win_sync_free_at
#exit

#for i in  `seq 1 100`
#for i in  `seq 1 10`
#do
# echo "*****" $i "******"
#echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_free_at "
#mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_free_at  
#echo $?
#echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_lock_at "
#mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_lock_at  
#echo $?
#echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_lock_fence "
#mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_lock_fence  
#echo $?
#done

echo "# mpiexec -n 2    ./pt2pt/sendrecv2 "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/sendrecv2  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/sendrecv3 "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/sendrecv3  
echo $?

export MPIEXEC_TIMEOUT=600
echo "# mpiexec -n 8    ./pt2pt/sendflood "
mpiexec -n 8    $TEST_INSTDIR/./pt2pt/sendflood
echo $?

export MPIEXEC_TIMEOUT=180
echo "#mpiexec -n 4    ./pt2pt/sendall "
mpiexec -n 4    $TEST_INSTDIR/./pt2pt/sendall  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/anyall "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/anyall  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/eagerdt "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/eagerdt  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/bottom "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/bottom  
echo $?
export MPIEXEC_TIMEOUT=180

echo "# mpiexec -n 1    ./pt2pt/bsend1 "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/bsend1  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/bsend2 "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/bsend2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/bsend3 "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/bsend3  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/bsend4 "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/bsend4  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./pt2pt/bsend5 "
mpiexec -n 4    $TEST_INSTDIR/./pt2pt/bsend5  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/bsendalign "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/bsendalign  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/bsendpending "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/bsendpending  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/isendself "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/isendself  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./pt2pt/isendirecv "
mpiexec -n 10    $TEST_INSTDIR/./pt2pt/isendirecv  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/bsendfrag "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/bsendfrag  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./pt2pt/icsend "
mpiexec -n 4    $TEST_INSTDIR/./pt2pt/icsend  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/rqstatus "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/rqstatus  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./pt2pt/rqfreeb "
mpiexec -n 4    $TEST_INSTDIR/./pt2pt/rqfreeb  
echo $?
export MPIEXEC_TIMEOUT=180

#echo "#  cancel is not implmented mpiexec -n 1    ./pt2pt/greq1 "
#	mpiexec -n 1    $TEST_INSTDIR/./pt2pt/greq1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./pt2pt/probe_unexp "
mpiexec -n 4    $TEST_INSTDIR/./pt2pt/probe_unexp  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/probenull "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/probenull  
echo $?

export MPIEXEC_TIMEOUT=180
echo "#  cancel is not implmentedmpiexec -n 2    ./pt2pt/rcancel "
#	mpiexec -n 2    $TEST_INSTDIR/./pt2pt/rcancel  
#echo $?
#export MPIEXEC_TIMEOUT=180

echo "#  cancel is not implmented mpiexec -n 2    ./pt2pt/cancelanysrc "
#	mpiexec -n 2    $TEST_INSTDIR/./pt2pt/cancelanysrc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/isendselfprobe "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/isendselfprobe  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/inactivereq "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/inactivereq  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/waittestnull "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/waittestnull  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./pt2pt/waitany_null "
mpiexec -n 1    $TEST_INSTDIR/./pt2pt/waitany_null  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# takes about 7 sec in not optimized rendezvous mode: mpiexec -n 3    ./pt2pt/large_message "
mpiexec -n 3    $TEST_INSTDIR/./pt2pt/large_message  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# Is this really true ?? mpiexec -n 2    ./pt2pt/mprobe "
#	mpiexec -n 2    $TEST_INSTDIR/./pt2pt/mprobe  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# cancel is not implmented: mpiexec -n 1    ./pt2pt/big_count_status "
#	mpiexec -n 1    $TEST_INSTDIR/./pt2pt/big_count_status  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 3    ./pt2pt/many_isend "
mpiexec -n 3    $TEST_INSTDIR/./pt2pt/many_isend  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/manylmt "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/manylmt  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/huge_underflow "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/huge_underflow  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/huge_anysrc "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/huge_anysrc  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/huge_dupcomm "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/huge_dupcomm  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/huge_ssend "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/huge_ssend  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/multi_psend_derived "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/multi_psend_derived  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/dtype_send "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/dtype_send  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/recv_any "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/recv_any  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/irecv_any "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/irecv_any  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./pt2pt/large_tag "
mpiexec -n 2    $TEST_INSTDIR/./pt2pt/large_tag  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# (0.8sec) mpiexec -n 2    ./rma/winname "
mpiexec -n 2    $TEST_INSTDIR/./rma/winname  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./rma/allocmem "
mpiexec -n 2    $TEST_INSTDIR/./rma/allocmem  
echo $?

#export MPIEXEC_TIMEOUT=180
echo "# Not yet implemented for fi_writemsg mpiexec -n 4    ./rma/putfidx "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/putfidx  
#echo $?

#export MPIEXEC_TIMEOUT=180
echo "# Not yet implemented for fi_writemsg mpiexec -n 3    ./rma/adlb_mimic1 "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/adlb_mimic1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/accfence2 "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/accfence2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 4    ./rma/getgroup "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/getgroup  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose1 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose2 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose3 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose3_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose3_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose5 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose5  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 1    ./rma/transpose6 "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/transpose6  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/transpose7 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose7  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test1 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test2 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test2_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test2_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test3 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test3_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test3_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexe mpiexec -n 2    ./rma/test4 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test4  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test5 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test5  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/lockcontention "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/lockcontention  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/lockcontention2 "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/lockcontention2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 8    ./rma/lockcontention2 "
#	mpiexec -n 8    $TEST_INSTDIR/./rma/lockcontention2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 8    ./rma/lockcontention3 "
#	mpiexec -n 8    $TEST_INSTDIR/./rma/lockcontention3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/lockopts "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/lockopts  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/transpose4 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/transpose4  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/fetchandadd "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/fetchandadd  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/fetchandadd_tree "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/fetchandadd_tree  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/wintest "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/wintest  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/wintest_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/wintest_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/contig_displ "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/contig_displ  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test1_am "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test1_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test2_am "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test2_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test2_am_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test2_am_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test3_am "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test3_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test3_am_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test3_am_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test4_am "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test4_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test5_am "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test5_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/fetchandadd_am "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/fetchandadd_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/fetchandadd_tree_am "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/fetchandadd_tree_am  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/accfence2_am "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/accfence2_am  
#echo $?

export MPIEXEC_TIMEOUT=30
echo "# NOT YET for RMA mpiexec -n 2    ./rma/test1_dt "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/test1_dt  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/nullpscw "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/nullpscw  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 7    ./rma/nullpscw_shm "
#	mpiexec -n 7    $TEST_INSTDIR/./rma/nullpscw_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/attrorderwin "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/attrorderwin  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/wincall "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/wincall  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/baseattrwin "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/baseattrwin  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/fkeyvalwin "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/fkeyvalwin  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/selfrma "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/selfrma  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/mixedsync "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/mixedsync  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/locknull "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/locknull  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rmanull "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rmanull  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rmazero "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rmazero  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/strided_acc_indexed "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/strided_acc_indexed  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/strided_acc_onelock "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/strided_acc_onelock  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/strided_acc_subarray "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/strided_acc_subarray  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/strided_get_indexed "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/strided_get_indexed  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/strided_putget_indexed "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/strided_putget_indexed  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/strided_putget_indexed_shared "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/strided_putget_indexed_shared  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/strided_getacc_indexed "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/strided_getacc_indexed  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/strided_getacc_indexed_shared "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/strided_getacc_indexed_shared  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/window_creation "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/window_creation  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/window_allocation "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/window_allocation  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/window_noncontig_allocation "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/window_noncontig_allocation  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/contention_put "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/contention_put  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/contention_putget "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/contention_putget  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/put_base "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/put_base  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/put_bottom "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/put_bottom  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_flavors "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_flavors  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_flavors "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_flavors  
#echo $?

export MPIEXEC_TIMEOUT=500
echo "# NOT YET for RMA mpiexec -n 2    ./rma/manyrma2 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/manyrma2  
#echo $?

export MPIEXEC_TIMEOUT=500
echo "# NOT YET for RMA mpiexec -n 2    ./rma/manyrma2_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/manyrma2_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/manyrma3 "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/manyrma3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_create_allocshm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_create_allocshm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_create_no_allocshm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_create_no_allocshm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_noncontig "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_noncontig  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_noncontig_put "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_noncontig_put  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_zero "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_zero  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_dynamic_acc "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_dynamic_acc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 1    ./rma/get_acc_local "
#	mpiexec -n 1    $TEST_INSTDIR/./rma/get_acc_local  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_fop "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_fop  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/compare_and_swap "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/compare_and_swap  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_char "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_char  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_short "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_short  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_int "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_int  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_long "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_long  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_double "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_double  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/fetch_and_op_long_double "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/fetch_and_op_long_double  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_double "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_double  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_double_derived "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_double_derived  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_int "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_int  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_int_derived "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_int_derived  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_long "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_long  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_long_derived "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_long_derived  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_short "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_short  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_accumulate_short_derived "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_accumulate_short_derived  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/flush "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/flush  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/reqops "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/reqops  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/req_example "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/req_example  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/req_example_shm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/req_example_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rput_local_comp "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rput_local_comp  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/racc_local_comp "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/racc_local_comp  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_info "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_info  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_lockall "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_lockall  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/pscw_ordering "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/pscw_ordering  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/pscw_ordering_shm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/pscw_ordering_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_bench_lock_all "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_bench_lock_all  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_bench_lock_excl "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_bench_lock_excl  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_bench_lock_shr "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_bench_lock_shr  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/linked_list_bench_lock_shr_nocheck "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/linked_list_bench_lock_shr_nocheck  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/mutex_bench "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/mutex_bench  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/mutex_bench_shared "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/mutex_bench_shared  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/mutex_bench_shm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/mutex_bench_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/mutex_bench_shm_ordered "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/mutex_bench_shm_ordered  
#echo $?

export MPIEXEC_TIMEOUT=720
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rma_contig "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rma_contig  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/badrma "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/badrma  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/acc_loc "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/acc_loc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/acc_ordering "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/acc_ordering  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/fence_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/fence_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_zerobyte "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_zerobyte  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_put_flush_get "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_put_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/get_struct "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/get_struct  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/at_complete "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/at_complete  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_rmw_fop "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_rmw_fop  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_rmw_cas "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_rmw_cas  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_rmw_gacc "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_rmw_gacc  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_short_int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_short_int  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_2int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_2int  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_long_int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_long_int  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_float_int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_float_int  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_double_int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_double_int  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 3    ./rma/atomic_get_long_double_int "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/atomic_get_long_double_int  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/aint "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/aint  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/acc_pairtype "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/acc_pairtype  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/acc_pairtype_shm "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/acc_pairtype_shm  
#echo $?

export MPIEXEC_TIMEOUT=300
echo "# NOT YET for RMA mpiexec -n 2    ./rma/manyget "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/manyget  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/derived_acc_flush_local "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/derived_acc_flush_local  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/large_acc_flush_local "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/large_acc_flush_local  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/large_small_acc "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/large_small_acc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_shared_put_flush_load "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_shared_put_flush_load  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_shared_acc_flush_load "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_shared_acc_flush_load  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_shared_gacc_flush_load "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_shared_gacc_flush_load  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_shared_fop_flush_load "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_shared_fop_flush_load  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/win_shared_cas_flush_load "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/win_shared_cas_flush_load  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/put_flush_get "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/put_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/acc_flush_get "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/acc_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/gacc_flush_get "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/gacc_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/fop_flush_get "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/fop_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/cas_flush_get "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/cas_flush_get  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rget_unlock "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rget_unlock  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/overlap_wins_put "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/overlap_wins_put  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/overlap_wins_acc "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/overlap_wins_acc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/overlap_wins_gacc "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/overlap_wins_gacc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/overlap_wins_fop "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/overlap_wins_fop  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/overlap_wins_cas "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/overlap_wins_cas  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 3    ./rma/lock_nested "
#	mpiexec -n 3    $TEST_INSTDIR/./rma/lock_nested  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 2    ./rma/rget_testall "
#	mpiexec -n 2    $TEST_INSTDIR/./rma/rget_testall  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_flushlocal "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_flushlocal  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/get_flushlocal_shm "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/get_flushlocal_shm  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT YET for RMA mpiexec -n 4    ./rma/win_shared_query_null "
#	mpiexec -n 4    $TEST_INSTDIR/./rma/win_shared_query_null  
#echo $?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/namepub "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/namepub  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawn1 "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawn1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawn2 "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawn2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawninfo1 "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawninfo1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawnminfo1 "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawnminfo1  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawnintra "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawnintra  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/spawnintra "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/spawnintra  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawnargv "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawnargv  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spawnmanyarg "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spawnmanyarg  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/spawnmult2 "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/spawnmult2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spaconacc "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spaconacc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/spaconacc2 "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/spaconacc2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/selfconacc "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/selfconacc  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/spaiccreate "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/spaiccreate  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/spaiccreate2 "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/spaiccreate2  
#echo $?

export MPIEXEC_TIMEOUT=600
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/taskmaster "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/taskmaster  
#echo $?

export MPIEXEC_TIMEOUT=600
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/taskmaster "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/taskmaster  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./spawn/join "
#	mpiexec -n 2    $TEST_INSTDIR/./spawn/join  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect_reconnect "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect_reconnect  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect_reconnect2 "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect_reconnect2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect_reconnect3 "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect_reconnect3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/multiple_ports "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/multiple_ports  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 4    ./spawn/multiple_ports2 "
#	mpiexec -n 4    $TEST_INSTDIR/./spawn/multiple_ports2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect2 "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect2  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 3    ./spawn/disconnect3 "
#	mpiexec -n 3    $TEST_INSTDIR/./spawn/disconnect3  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./spawn/concurrent_spawns "
#	mpiexec -n 1    $TEST_INSTDIR/./spawn/concurrent_spawns  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 4    ./spawn/pgroup_connect_test "
#	mpiexec -n 4    $TEST_INSTDIR/./spawn/pgroup_connect_test  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 4    ./spawn/pgroup_intercomm_test "
#	mpiexec -n 4    $TEST_INSTDIR/./spawn/pgroup_intercomm_test  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 10    ./spawn/spawn_rootargs "
#	mpiexec -n 10    $TEST_INSTDIR/./spawn/spawn_rootargs  
#echo $?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/cartmap1 "
mpiexec -n 4    $TEST_INSTDIR/./topo/cartmap1  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/cartzero "
mpiexec -n 4    $TEST_INSTDIR/./topo/cartzero  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/cartshift1 "
mpiexec -n 4    $TEST_INSTDIR/./topo/cartshift1  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/cartsuball "
mpiexec -n 4    $TEST_INSTDIR/./topo/cartsuball  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/cartcreates "
mpiexec -n 4    $TEST_INSTDIR/./topo/cartcreates  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/dims1 "
mpiexec -n 4    $TEST_INSTDIR/./topo/dims1  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./topo/dims2 "
mpiexec -n 1    $TEST_INSTDIR/./topo/dims2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./topo/dims3 "
mpiexec -n 1    $TEST_INSTDIR/./topo/dims3  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./topo/dims4 "
mpiexec -n 1    $TEST_INSTDIR/./topo/dims4  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./topo/dims5 "
mpiexec -n 1    $TEST_INSTDIR/./topo/dims5  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/graphmap1 "
mpiexec -n 4    $TEST_INSTDIR/./topo/graphmap1  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/topotest "
mpiexec -n 4    $TEST_INSTDIR/./topo/topotest  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/topodup "
mpiexec -n 4    $TEST_INSTDIR/./topo/topodup  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/graphcr "
mpiexec -n 4    $TEST_INSTDIR/./topo/graphcr  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/graphcr2 "
mpiexec -n 4    $TEST_INSTDIR/./topo/graphcr2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/distgraph1 "
mpiexec -n 4    $TEST_INSTDIR/./topo/distgraph1  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./topo/dgraph_unwgt "
mpiexec -n 4    $TEST_INSTDIR/./topo/dgraph_unwgt  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./perf/sendrecvl "
mpiexec -n 2    $TEST_INSTDIR/./perf/sendrecvl  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./perf/non_zero_root "
mpiexec -n 4    $TEST_INSTDIR/./perf/non_zero_root  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./perf/timer "
mpiexec -n 1    $TEST_INSTDIR/./perf/timer  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 16    ./perf/commcreatep "
mpiexec -n 16    $TEST_INSTDIR/./perf/commcreatep  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./cxx/attr/attrtx "
mpiexec -n 2    $TEST_INSTDIR/./cxx/attr/attrtx  
echo $?
export MPIEXEC_TIMEOUT=180

echo "# mpiexec -n 4    ./cxx/attr/attricx "
mpiexec -n 4    $TEST_INSTDIR/./cxx/attr/attricx  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/attr/baseattrcommx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/attr/baseattrcommx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/attr/fkeyvalcommx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/attr/fkeyvalcommx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./cxx/pt2pt/bsend1cxx "
mpiexec -n 2    $TEST_INSTDIR/./cxx/pt2pt/bsend1cxx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./cxx/pt2pt/sendrecvx "
mpiexec -n 2    $TEST_INSTDIR/./cxx/pt2pt/sendrecvx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/comm/commname2 "
mpiexec -n 4    $TEST_INSTDIR/./cxx/comm/commname2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/coll/arcomplex "
mpiexec -n 4    $TEST_INSTDIR/./cxx/coll/arcomplex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/uallredx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/uallredx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/uallreduce "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/uallreduce  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/ureduce "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/ureduce  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/ureducelocal "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/ureducelocal  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/uscan "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/uscan  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/uexscan "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/uexscan  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./cxx/coll/alltoallw2x "
mpiexec -n 10    $TEST_INSTDIR/./cxx/coll/alltoallw2x  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/coll/icbcastx "
mpiexec -n 4    $TEST_INSTDIR/./cxx/coll/icbcastx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 10    ./cxx/coll/icbcastx "
mpiexec -n 10    $TEST_INSTDIR/./cxx/coll/icbcastx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icallreducex "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icallreducex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icreducex "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icreducex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icscatterx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icscatterx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icgatherx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icgatherx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icallgatherx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icallgatherx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icbarrierx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icbarrierx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icallgathervx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icallgathervx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icgathervx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icgathervx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icscattervx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icscattervx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/icalltoallx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/icalltoallx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 5    ./cxx/coll/reduceboolx "
mpiexec -n 5    $TEST_INSTDIR/./cxx/coll/reduceboolx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/coll/redscatblk "
mpiexec -n 4    $TEST_INSTDIR/./cxx/coll/redscatblk  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./cxx/errhan/commcallx "
mpiexec -n 2    $TEST_INSTDIR/./cxx/errhan/commcallx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/init/baseenv "
mpiexec -n 1    $TEST_INSTDIR/./cxx/init/baseenv  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/init/initstatx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/init/initstatx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/init/initstat2x myarg1 myarg2"
mpiexec -n 1    $TEST_INSTDIR/./cxx/init/initstat2x myarg1 myarg2 
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/info/infodupx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/info/infodupx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/info/infodelx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/info/infodelx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/info/infovallenx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/info/infovallenx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/info/infoorderx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/info/infoorderx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/datatype/typecntsx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/datatype/typecntsx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/datatype/typenamex "
mpiexec -n 1    $TEST_INSTDIR/./cxx/datatype/typenamex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/datatype/typemiscx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/datatype/typemiscx  
echo $?
export MPIEXEC_TIMEOUT=180

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

echo "# NOT SUPPORTED mpiexec -n 2    ./cxx/spawn/namepubx "
#	mpiexec -n 2    $TEST_INSTDIR/./cxx/spawn/namepubx  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT SUPPORTED mpiexec -n 1    ./cxx/spawn/spawnintrax "
#	mpiexec -n 1    $TEST_INSTDIR/./cxx/spawn/spawnintrax  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT SUPPORTED mpiexec -n 2    ./cxx/spawn/spawnintrax "
#	mpiexec -n 2    $TEST_INSTDIR/./cxx/spawn/spawnintrax  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT SUPPORTED mpiexec -n 1    ./cxx/spawn/spawnargvx "
#	mpiexec -n 1    $TEST_INSTDIR/./cxx/spawn/spawnargvx  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# NOT SUPPORTED mpiexec -n 2    ./cxx/spawn/selfconaccx "
#	mpiexec -n 2    $TEST_INSTDIR/./cxx/spawn/selfconaccx  
#echo $?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/rma/winnamex "
mpiexec -n 1    $TEST_INSTDIR/./cxx/rma/winnamex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/rma/wincallx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/rma/wincallx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/rma/getgroupx "
mpiexec -n 4    $TEST_INSTDIR/./cxx/rma/getgroupx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/rma/winfencex "
mpiexec -n 4    $TEST_INSTDIR/./cxx/rma/winfencex  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/rma/winscale1x "
mpiexec -n 4    $TEST_INSTDIR/./cxx/rma/winscale1x  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./cxx/rma/winscale2x "
mpiexec -n 4    $TEST_INSTDIR/./cxx/rma/winscale2x  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./cxx/rma/fkeyvalwinx "
mpiexec -n 1    $TEST_INSTDIR/./cxx/rma/fkeyvalwinx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/attr/keyvalmis "
mpiexec -n 1    $TEST_INSTDIR/./errors/attr/keyvalmis  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/coll/noalias "
mpiexec -n 2    $TEST_INSTDIR/./errors/coll/noalias  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/coll/nb_noalias "
mpiexec -n 2    $TEST_INSTDIR/./errors/coll/nb_noalias  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/noalias2 "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/noalias2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/noalias3 "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/noalias3  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/coll/rerr "
mpiexec -n 2    $TEST_INSTDIR/./errors/coll/rerr  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/coll/nb_rerr "
mpiexec -n 2    $TEST_INSTDIR/./errors/coll/nb_rerr  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/coll/reduce_local "
mpiexec -n 1    $TEST_INSTDIR/./errors/coll/reduce_local  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# Must be fixed mpiexec -n 4    ./errors/coll/bcastlength "
#	mpiexec -n 4    $TEST_INSTDIR/./errors/coll/bcastlength  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/ibcastlength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/ibcastlength  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/reducelength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/reducelength  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/ireducelength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/ireducelength  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/allreducelength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/allreducelength  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/iallreducelength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/iallreducelength  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/reduceop "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/reduceop  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/ireduceop "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/ireduceop  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/gatherlength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/gatherlength  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/igatherlength "
mpiexec -n 4    $TEST_INSTDIR/./errors/coll/igatherlength  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# Something wrong needs to investigate mpiexec -n 4    ./errors/coll/scatterlength"
#mpiexec -n 4    $TEST_INSTDIR/./errors/coll/scatterlength  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# Something wrong needs to investigate mpiexec -n 4    ./errors/coll/iscatterlength "
#mpiexec -n 4    $TEST_INSTDIR/./errors/coll/iscatterlength  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/allgatherlength "
 mpiexec -n 4    $TEST_INSTDIR/./errors/coll/allgatherlength  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# Something wrong needs to investigate mpiexec -n 4    ./errors/coll/iallgatherlength "
# mpiexec -n 4    $TEST_INSTDIR/./errors/coll/iallgatherlength  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/coll/alltoalllength "
 mpiexec -n 4    $TEST_INSTDIR/./errors/coll/alltoalllength  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/cfree "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/cfree  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 8    ./errors/comm/ccreate1 "
 mpiexec -n 8    $TEST_INSTDIR/./errors/comm/ccreate1  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/userdup "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/userdup  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/manysplit "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/manysplit  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/too_many_comms "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/too_many_comms  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/too_many_icomms "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/too_many_icomms  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/too_many_comms2 "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/too_many_comms2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/too_many_comms3 "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/too_many_comms3  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/comm/too_many_icomms2 "
 mpiexec -n 4    $TEST_INSTDIR/./errors/comm/too_many_icomms2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_create_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_create_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_create_group_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_create_group_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_get_info_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_get_info_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_group_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_group_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_size_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_size_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_split_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_split_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/comm_split_type_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/comm_split_type_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/comm/intercomm_create_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/comm/intercomm_create_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_contiguous_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_contiguous_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_extent_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_extent_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_get_extent_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_get_extent_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_get_true_extent_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_get_true_extent_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_get_true_extent_x_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_get_true_extent_x_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_lb_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_lb_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_ub_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_ub_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_size_x_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_size_x_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/datatype/type_vector_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/datatype/type_vector_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/gerr "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/gerr  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_difference_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_difference_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_intersection_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_intersection_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_range_excl_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_range_excl_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_range_incl_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_range_incl_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_rank_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_rank_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_size_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_size_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_translate_ranks_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_translate_ranks_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/group/group_union_nullarg "
 mpiexec -n 1    $TEST_INSTDIR/./errors/group/group_union_nullarg  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/pt2pt/proberank "
 mpiexec -n 1    $TEST_INSTDIR/./errors/pt2pt/proberank  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/truncmsg1 "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/truncmsg1  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/truncmsg2 "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/truncmsg2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/errinstatts "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/errinstatts  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/errinstatta "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/errinstatta  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/errinstatws "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/errinstatws  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/pt2pt/errinstatwa "
 mpiexec -n 2    $TEST_INSTDIR/./errors/pt2pt/errinstatwa  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 4    ./errors/topo/cartsmall "
 mpiexec -n 4    $TEST_INSTDIR/./errors/topo/cartsmall  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/winerr "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/winerr  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/winerr2 "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/winerr2  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/cas_type_check "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/cas_type_check  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/win_sync_unlock "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_unlock  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/win_sync_free_pt "
mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_free_pt  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_free_at "
#mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_free_at  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/win_sync_complete "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_complete  
echo $?
export MPIEXEC_TIMEOUT=180

echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_lock_at "
# mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_lock_at  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/win_sync_lock_pt "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_lock_pt  
echo $?
export MPIEXEC_TIMEOUT=180

echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_lock_fence "
# mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_lock_fence  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# Something wrong needs to investigate mpiexec -n 2    ./errors/rma/win_sync_nested "
# mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_nested  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/rma/win_sync_op "
 mpiexec -n 2    $TEST_INSTDIR/./errors/rma/win_sync_op  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./errors/spawn/badport "
 #	mpiexec -n 2    $TEST_INSTDIR/./errors/spawn/badport  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./errors/spawn/unpub "
 #	mpiexec -n 1    $TEST_INSTDIR/./errors/spawn/unpub  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 1    ./errors/spawn/lookup_name "
 #	mpiexec -n 1    $TEST_INSTDIR/./errors/spawn/lookup_name  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./errors/spawn/connect_timeout_no_accept "
 #	mpiexec -n 2    $TEST_INSTDIR/./errors/spawn/connect_timeout_no_accept  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 2    ./errors/spawn/connect_timeout_mismatch "
 #	mpiexec -n 2    $TEST_INSTDIR/./errors/spawn/connect_timeout_mismatch  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 5    ./errors/spawn/connect_timeout_no_accept "
 #	mpiexec -n 5    $TEST_INSTDIR/./errors/spawn/connect_timeout_no_accept  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# SPAWN is not supported mpiexec -n 5    ./errors/spawn/connect_timeout_mismatch "
 #	mpiexec -n 5    $TEST_INSTDIR/./errors/spawn/connect_timeout_mismatch  
echo $?

export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/cxx/errhan/errgetx "
 mpiexec -n 1    $TEST_INSTDIR/./errors/cxx/errhan/errgetx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/cxx/errhan/errsetx "
 mpiexec -n 1    $TEST_INSTDIR/./errors/cxx/errhan/errsetx  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 1    ./errors/cxx/errhan/throwtest "
 mpiexec -n 1    $TEST_INSTDIR/./errors/cxx/errhan/throwtest  
echo $?
export MPIEXEC_TIMEOUT=180
echo "# mpiexec -n 2    ./errors/cxx/errhan/commerrx "
 mpiexec -n 2    $TEST_INSTDIR/./errors/cxx/errhan/commerrx  
echo $?
export MPIEXEC_TIMEOUT=600

echo "# Not yet supported  mpiexec -n 2    ./threads/pt2pt/threads "
# mpiexec -n 2    $TEST_INSTDIR/./threads/pt2pt/threads  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# # Not yet supported mpiexec -n 2    ./threads/pt2pt/threaded_sr "
# mpiexec -n 2    $TEST_INSTDIR/./threads/pt2pt/threaded_sr  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# Not yet supported mpiexec -n 4    ./threads/pt2pt/alltoall "
# mpiexec -n 4    $TEST_INSTDIR/./threads/pt2pt/alltoall  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 1    ./threads/pt2pt/sendselfth "
# mpiexec -n 1    $TEST_INSTDIR/./threads/pt2pt/sendselfth  
#echo $?

export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 2    ./threads/pt2pt/multisend "
# mpiexec -n 2    $TEST_INSTDIR/./threads/pt2pt/multisend  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 5    ./threads/pt2pt/multisend2 "
# mpiexec -n 5    $TEST_INSTDIR/./threads/pt2pt/multisend2  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 5    ./threads/pt2pt/multisend3 "
# mpiexec -n 5    $TEST_INSTDIR/./threads/pt2pt/multisend3  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 5    ./threads/pt2pt/multisend4 "
# mpiexec -n 5    $TEST_INSTDIR/./threads/pt2pt/multisend4  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 5    ./threads/pt2pt/multisend4 -mode=1"
# mpiexec -n 5    $TEST_INSTDIR/./threads/pt2pt/multisend4 -mode=1 
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 1    ./threads/pt2pt/greq_wait "
# mpiexec -n 1    $TEST_INSTDIR/./threads/pt2pt/greq_wait  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 1    ./threads/pt2pt/greq_test "
# mpiexec -n 1    $TEST_INSTDIR/./threads/pt2pt/greq_test  
#echo $?
export MPIEXEC_TIMEOUT=180
echo "# Not yet supported  mpiexec -n 2    ./threads/pt2pt/ibsend "
# mpiexec -n 2    $TEST_INSTDIR/./threads/pt2pt/ibsend  
#echo $?
