If you already read this file, you have already cloned riken-mpich

 $ git clone git@git.sys.r-ccs.riken.jp:software/mpich-fugaku
 $ cd mpich-fugaku
 $ git clone --recursive https://github.com/pmodels/mpich.git
   # $ git clone http://git.mpich.org/mpich.git
   # $ (cd mpich; git submodule update --init)
 $ (cd mpich; git checkout d6091ffb3fd6a63d190c8e0fff5450c13ef1ea08)
   # $ (cd mpich; git checkout 1b6d26b8ea270b699ddc2b600e97ff73ba0d9dd1)
 $ edit mpich/src/mpid/ch4/src/ch4_init.c (line 469)
 $ git clone git@git.sys.r-ccs.riken.jp:software/libfabric

(0) Building utofu simulation environment (Skip for Fugaku)
  - for fx100
     $ git clone git@git.sys.r-ccs.riken.jp:work/mhatanaka/utofu-on-fx100
     $ (cd utofu-on-fx100/utofu_fx100/lib64; cp -p libutofu.so INST/lib/)
     $ (cd new-simu-tofu; make; make install)
  - for others (Except Fugaku)
     $ cd new-sim-utofu
     $ make
     $ make install
(1) Installation
    Note that installation directory is $HOME/riken-mpich/ in default.
 0) pmix for MPICH on Fugaku (skip in the case of utofu simulation environment)
     $ (cd pmix-wrapper; make; make install)
 1) libfabric
     $ (cd libfabric; git checkout newdev)
     ##$ (cd libfabric; git checkout dev1)
     $ ./tool/libfabric-autogen
     $ ./tool/libfabric-configure
     	"fi_tofu_setdopt"  and "fi_tofu_cntrl" are added in libfabric.map
		fi_tofu_setdopt;
		fi_tofu_cntrl;
     $ (cd libfabric; make clean>/dev/null)
     $ (cd libfabric; make V=1 >../log/cmp-libfabric.txt 2>&1)
     $ (cd libfabric; make install >../log/ins-libfabric.txt 2>&1)
     $ ./tool/fabtests-autogen
     $ ./tool/fabtests-configure
     $ (cd libfabric/fabtests; make)
     $ (cd libfabric/fabtests; make install)
     $ $HOME/riken-mpich/bin/fi_getinfo_test -p tofu
 2) mpich
   1. Configuration
      $ ./tool/mpich-autogen
     See gen-mpi.txt to check if configuration files have been sucessfully done.
     The default install path is ~/riken-mpich. If you want to change the
     default, declare INSTDIR environment variable before configuration.
   2. Skip this step for Fugaku
     2.1 Copy and Configure mpiexec.hydra
       $ cp -p mpich mpich.hydra
       $ ./tool/mpich-hydra-configure
       See cnf-mpi-hydra.txt to check if configuration has been sucessfully done.
     2.2 Installing mpiexec.hydra binary;
       $ (cd mpich.hydra; make clean > /dev/null)
       $ (cd mpich.hydra; date; make V=1 >../log/cmp-mpi-hydra.txt 2>&1; date)
       $ (cd mpich.hydra; date; make install >../log/ins-mpi-hydra.txt 2>&1; date)
   3. Configure mpiexec for utofu
      $ ./tool/mpich-configure
     See cnf-mpi.txt to check if configuration has been sucessfully done.
   4. Installing mpiexec for utofu
     $ (cd mpich; make clean > /dev/null)
     $ (cd mpich; date; make V=1 >../log/cmp-mpi.txt 2>&1; date)
     $ (cd mpich; date; make install >../log/ins-mpi.txt 2>&1; date)
     $ export LD_LIBRARY_PATH=$HOME/riken-mpich/lib:$LD_LIBRARY_PATH

3) The following shell environment selects the Tofu provider:
     $ export MPIR_CVAR_OFI_USE_PROVIDER=tofu
   If you want to debug libfabric
     $ export FI_LOG_LEVEL=Debug
     $ export FI_LOG_PROV=tofu

MEMO:
---------
AM_CPPFLAGS += -I$(top_srcdir)/src/mpid/ch4/src -I$(top_srcdir)/src/pmi/include
