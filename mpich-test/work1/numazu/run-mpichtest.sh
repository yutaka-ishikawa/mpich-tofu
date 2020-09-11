#!/bin/bash
#
#  pjsub -L rscunit=rscunit_ft01,rscgrp=dvint,jobenv=linux,node=12,elapse=00:30:00 --interact --sparam wait-time=20
#------ pjsub option --------#
#PJM -N "MPICH-TEST" # jobname
#PJM -S		# output statistics
#PJM --spath "results/%n.%j.stat"
#PJM -o "results/%n.%j.out"
#PJM -e "results/%n.%j.err"
#
#PJM -L "node=12"
#PJM --mpi "max-proc-per-node=1"
#PJM -L "elapse=00:10:00"
#PJM -L "rscunit=rscunit_ft01,rscgrp=dvsin-r1"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvmck"
#	PJM -L proc-core=unlimited
#------- Program execution -------#

export LD_LIBRARY_PATH=${HOME}/riken-mpich/lib:$LD_LIBRARY_PATH
export MPIR_CVAR_OFI_USE_PROVIDER=tofu
export MPICH_CH4_OFI_ENABLE_SCALABLE_ENDPOINTS=1

export TEST_INSTDIR=../../mpich/test/mpi
. ./runtests.batch


#export PMIX_DEBUG=1
## CONF_TOFU_INJECTSIZE=1856 (MSG_EAGER_SIZE = 1878)
#	-x UTF_DEBUG=16 \
#	-x TOFULOG_DIR=./results \
#	-x FI_LOG_PROV=tofu \
#	-x MPICH_DBG=FILE \
#	-x MPICH_DBG_CLASS=COLL \
#	-x MPICH_DBG_LEVEL=TYPICAL \
#
#	-x PMIX_DEBUG=1 \
#	-x FI_LOG_LEVEL=Debug \
#
