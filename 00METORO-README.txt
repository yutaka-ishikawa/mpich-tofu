
#############################################################################
	Test Plan
	   			    	    	     	2021/03/02
#############################################################################
- MPICH-tofu must be built on compute node for creating F90 lirary.
  pjsub -L rscunit=rscunit_ft01,rscgrp=eap-int,node=1,elapse=6:00:00 --interact --sparam wait-time=600
- Please test F77 using mpich-tofu-fc(cross comipled) today.



-----------------+---------+---------+-------------------+------------------
                 | IMB     | IMB+VBG | MPICH-Test C      |MPICH-Test F77&F90  
-----------------+---------+---------+-------------------+------------------
mpich-tofu       | Full    | Full    | attr, coll, pt2pt |
                 |         |         | comm, datatype    |
                 |         |         | errhan, errors    |
                 |         |         | group, impls, info|   
                 |         |         | init, mpi_t, perf |                  
                 |         |         | topo, (rma)       |                  
-----------------+---------+---------+-------------------+------------------
mpich-tofu-mt    | Partial | Partial | Same as above     |
-----------------+---------+---------+-------------------+------------------
mpich-tofu-nv    | Full    | Full    | Same as above     | attr, coll, comm 
                 |         |         |                   | datatype, ext,   
                 |         |         |                   | info, init, pt2pt
                 |         |         |                   | rma, topo       
-----------------+---------+---------+-------------------+------------------
mpich-tofu-nv-mt | Full    | Full    | Same as above     | Same as above    
-----------------+---------+---------+-------------------+------------------

-----------------+---------+---------+-------------------+------------------
mpich-tofu-fc    | Full    | Full    | Same as above     | Same as above    
-----------------+---------+---------+-------------------+------------------
mpich-tofu-fc-mt | Partial | Partial | Same as above     | Same as above    
-----------------+---------+---------+-------------------+------------------

UTF_ARCH
 - fugaku: compiler=gcc/g++, c, c++, no multi-thread(MT) safe
 - fugaku-mt:  compiler=gcc/g++, c, c++, MT safe
 - fugaku-fccpx: compiler=fccpx/FCCpx/frtpx, c, c++, fortran, no MT safe
 - fugaku-fccpx-mt: compiler=fccpx/FCCpx/frt, c, c++, fortran, MT safe
( - fugaku-native: compiler=fcc/FCC/frt, c, c++, fortran, no MT safe
  - fugaku-native-mt: compiler=fcc/FCC/frt, c, c++, fortran, MT safe
)
default INSTDIR
	~/mpich-tofu/
	~/mpich-tofu-mt/
	~/mpich-tofu-fc/
	~/mpich-tofu-fc-mt/
	~/mpich-tofu-nv/
	~/mpich-tofu-nv-mt/

IMB, test


#####################################################################
	How to build MPICH test scripts
	   			    	    	     	2021/03/01
#####################################################################
The MPICH source distribution has test programs under the test directory.
(1) In order to use them, run scripts are generated under the mpich-tofu
   directory as follows:
  $ cd $HOME/work/mpich-tofu/mpich-test
  $ cd script
  # See CREATE_FORT_LIST.sh and modify it for your local environment
  # Then,
  $ sh ./CREATE_FORT_LIST.sh
  $ cd ..
  # You will find the f77 and f90 directories.
  $ ls f77/attr/runlists
    runtests-1.batch  runtests.batch
(2) Batch scripts are generated as follows:
  $ cd $HOME/work/mpich-tofu/mpich-test/
  $ cd script
  # See CREATE_FORT_BATCH.sh and modify it for your local environment
  # Then,
  $ sh ./CREATE_FORT_BATCH.sh
  $ cd ..
  # You will find batch scripts as follows:
  $ ls f77/*/batch-scripts/ f90/*/batch-scripts/

#####################################################################
	How to build Intel MPI Benchmarks
	   			    	    	     	2021/02/26
#####################################################################
(1) In case of MPICH is built by gcc
  1) export MPICH_HOME=XXXXX
  2) (export CC=$MPICH_HOME/bin/mpicc -g; \
	export CXX=$MPICH_HOME/bin/mpic++; make IMB-MPI1)

(2) In case of MPICH is built by Fujitsu comiler
  1) export MPICH_HOME=XXXXX
  2) Using g++ as a backend C++ compiler instead of FCCpx
   $ (PATH=/opt/FJSVxos/devkit/aarch64/bin/:$PATH; \
	export MPICH_CXX=aarch64-linux-gnu-g++; \
	export CC=$MPICH_HOME/bin/mpicc; \
	export CXX=$MPICH_HOME/bin/mpic++; make IMB-MPI1)
   # several Fujitsu shared libraries cound not be found in this case, so keeping
   # all generated object files and relinked by FCCpx
  3) relink using FCCpx
   $ rm IMB-MPI1
   $ (export CC=$MPICH_HOME/bin/mpicc; \
	export CXX=$MPICH_HOME/bin/mpic++; make IMB-MPI1)

#####################################################################
	An installation example for Fujitsu compiler on Fugaku environment
	   			    	    	     	2021/02/25
#####################################################################
(0) How to use ssh-agent in your local machine
    $ ssh-agent bash
    $ ssh-add <private-key-file>
    $ ssh -A u93XXXX@fugaku.riken.jp
      # make sure ssh-key is fowarded in the login node
      $ ssh-add -L
(1)
    $ cd $HOME
    $ mkdir work
    $ cd work
    $ git clone git@git.sys.r-ccs.riken.jp:software/mpich-tofu
    $ cd mpich-tofu
    $ git clone git@git.sys.r-ccs.riken.jp:software/utf
    $ cd utf/src
    $ export UTF_ARCH=fugaku-fccpx
    $ make clean; make
    $ make INSTDIR=$HOME/mpich-tofu-fc install
(2)
   Copy mpich-exp to mpich-exp-fc under $HOME/work/mpich-tofu
   Modify src/include/mpir_op_util.h and
	  src/binding/fortran/use_mpi_f08/mpi_c_interface.f90
   Apply patch two files under the tool/cross.
(3)
    $ cd $HOME/work/mpich-tofu/
    $ ./tool/mpich3.4-fc-configure 
    # It takes about 5 minutes
    # Look at the following file to check if the configure has successfuly
    # finished.
    #	$HOME/work/mpich-tofu/log/cnf-mpi-fc.txt
(4) Edit mpich-exp-fc/libtool
    1) Search for "TAG CONFIG: FC"
    2) Search again for "pic_flag"
    3) Relace it with the following one:
         pic_flag="-fPIC"
    4) Search for "wl" and replace it with the folloing one:
         wl="-Wl,"
    5) Search for "TAG CONFIG: F77" and repeat 2) through 4)
    6) Search for fjhpctag.o and remove it.
	# Two places.
    7) Search for fjhpctag.o and remove this entry.
	# Two places.
(3) Compile
    $ (cd mpich-exp-fc; make clean; make V=1 >& ../log/cmp-mpi-fc.txt)
    # It takes about 1 hour 30 minutes.
    # Look at the following file to check if the configure has successfuly
    # finished.
    #	$HOME/work/mpich-tofu/log/cmp-mpi-fc.txt
(4) Install
    $ (cd mpich-exp-fc; make V=1 install)
(5) Compile test programs
    $ (cd mpich-exp-fc/test; make V=1 >& ../../log/cmp-mpi-fc-test.txt)
    # It takes about 10 minutes.
    # Error Occurs in test/commands/rtest.c 
(6) Setup mpi_vbg
    $ cd $HOME/work/mpich-tofu/utf/src/mpi_vbg
    $ make clean; make
    $ make INSTDIR=$HOME/mpich-tofu-fc install

(7) set MPICH_HOME
    $ export MPICH_HOME=$HOME/mpich-tofu-fc/

#####################################################################
	An installation example on Numazu environment	2020/01/06
#####################################################################

##### download modules, initial setting, and utf installation
$ EXAMPLE_HOME=/home/users/ea01/share/
$ cd $EXAMPLE_HOME
$ mkdir -p mpich-tofu/work
$ cd mpich-tofu/work
$ git clone git@git.sys.r-ccs.riken.jp:software/mpich-tofu
$ cd mpich-tofu
$ mkdir -p work/mpich-tofu; cd work/mpich-tofu
$ git clone git@git.sys.r-ccs.riken.jp:software/utf
$ (cd utf; git checkout fast)
# Make sure if you use the fast branch
$ cd utf; git branch -a
  * fast
    master
$ cd src
$ export UTF_ARCH=fugaku
$ make HOME=/home/users/ea01/share/
$ make HOME=/home/users/ea01/share/ install
$ ls /home/users/ea01/share/
$ cd mpi_vbg
  # Note that HOME should be changed to MPICH_HOME in mpich.env
$ make; make install HOME=/home/users/ea01/share/
$ ls /home/users/ea01/share/mpich-tofu
  # include and lib directories are shown
$ cd ../../..
  # CWD is /home/users/ea01/share/mpich-tofu/work/mpich-tofu

##### MPICH initial setup on Numazu
# Please copy /home/users/ea01/share/mpich-tofu/work/mpich-tofu/mpich-exp/
$ cp -rp /home/users/ea01/share/mpich-tofu/work/mpich-tofu/mpich-exp .
# The copied files include the libfaric module downloaded from riken's repository
$ (cd mpich-exp/modules/libfabric; git branch -a)
  ## You should see the following branches.
  * fast
    master
    newdev2
# Make mpich and libfabric
$ tool/mpich3.4-configure exp ./mpich-exp/ /home/users/ea01/share/mpich-tofu
   ### Checking the modification time of mpich-exp/src/util/mpir_cvars.c.
   ### It should be Dec 24.
$ (cd mpich-exp; make clean; make V=1 >& ../log/cmp-mpi-exp.txt)
# It will take about 30 min.
$ cd mpich-exp; make install

#############################################################
$ cd /home/users/ea01/share/mpich-tofu/work/mpich-tofu/utf/mpitest/src
$ export PATH=/home/users/ea01/share/mpich-tofu/bin:$PATH
$ which mpicc
  /home/users/ea01/share/mpich-tofu/bin/mpicc
$ make
$ make install
$ which mpich_exec
  /home/users/ea01/share/mpich-tofu/bin/mpich_exec
$ cd ../run
$ If needed, edit run-numazu-coll-vbg.sh and add the following line:
  export MPICH_HOME=/home/g9300001/data/mpich-tofu/
  # Note that this variable must be used in /home/g9300001/data/mpich-tofu/lib/mpich.env
$ pjsub run-numazu-coll-vbg.sh 


#######################################################################################################################
# OLD
#######################################################################################################################
##### libfabric installation
$ ./tool/libfabric-autogen
$ tool/libfabric-configure /home/g9300001/data/mpich-tofu
$ (cd libfabric; make V=1 CFLAGS=-DUTF_DEBUG >&../log/cmp-libfabric.txt)
$ (cd libfabric; make install >&../log/inst-libfabric.txt)

