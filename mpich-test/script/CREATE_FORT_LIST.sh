#!/bin/bash
#
export MPICH_TEST_DIR=$HOME/work/mpich-tofu/mpich-test/
export MPICH_TEST_SRC=$HOME/work/mpich-tofu/mpich-exp-fc/test/mpi
export MPICH_INS_DIR=${MPICH_INS_DIR:-"$HOME/work/mpich-tofu-fc"}
echo "MPICH_TEST_DIR=" $MPICH_TEST_DIR
echo "MPICH_TEST_SRC=" $MPICH_TEST_SRC
echo "MPICH_INS_DIR=" $MPICH_INS_DIR

sh ./generate_run.sh -l f77/attr
sh ./generate_run.sh -l f77/coll
sh ./generate_run.sh -l f77/comm
sh ./generate_run.sh -l f77/datatype
sh ./generate_run.sh -l f77/ext
sh ./generate_run.sh -l f77/info
sh ./generate_run.sh -l f77/init
sh ./generate_run.sh -l f77/pt2pt
sh ./generate_run.sh -l f77/rma
sh ./generate_run.sh -l f77/topo

sh ./generate_run.sh -l f90/attr
sh ./generate_run.sh -l f90/coll
sh ./generate_run.sh -l f90/comm
sh ./generate_run.sh -l f89/datatype
sh ./generate_run.sh -l f08/ext
sh ./generate_run.sh -l f08/info
sh ./generate_run.sh -l f08/init
sh ./generate_run.sh -l f08/misc
sh ./generate_run.sh -l f08/pt2pt
sh ./generate_run.sh -l f08/rma
sh ./generate_run.sh -l f08/timer
sh ./generate_run.sh -l f08/topo

exit

sh ./generate_run.sh -l f08/attr
sh ./generate_run.sh -l f08/coll
sh ./generate_run.sh -l f08/comm
sh ./generate_run.sh -l f08/datatype
sh ./generate_run.sh -l f08/ext
sh ./generate_run.sh -l f08/info
sh ./generate_run.sh -l f08/init
sh ./generate_run.sh -l f08/misc
sh ./generate_run.sh -l f08/pt2pt
sh ./generate_run.sh -l f08/rma
sh ./generate_run.sh -l f08/subarray
sh ./generate_run.sh -l f08/timer
sh ./generate_run.sh -l f08/topo
