If you already read this file, you have already cloned mpich-tofu

(1) creating the build environment
 0) 
   $ EXAMPLE_HOME=/home/g0000/u0000/
   $ cd $EXAMPLE_HOME
   $ mkdir -p work
   $ cd work
   $ mkdir gcc gcc-mt native native-mt
   #	work/gcc       - for single thread compiled by cross gcc
   #	work/gcc-mt    - for multiple thread compiled by cross gcc
   #	work/native    - for single thread compiled by Fujitsu fcc on compute node
   #	work/native-mt - for multiple thread compiled by Fujitsu fcc on compute node
   $ cd gcc
 1) tools of mpich-tofu
   $ git clone https://github.com/yutaka-ishikawa/mpich-tofu.git
 2) utf
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu
   $ git clone https://github.com/yutaka-ishikawa/utf.git
   $ cd utf
   $ git checkout fast
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu
 3) mpich
   $ git clone --recursive https://github.com/pmodels/mpich.git
   $ cd mpich
   $ git checkout 169740255305011686c1781e3554f83eea448212
   $ cd modules/json-c
   $ git checkout 366f1c6c0ea2ca2f1077c1296f5cb744336fac38
   $ cd ../yaksa
   $ git checkout 110f306ac5fc63af3a5d21ed63a70e053a4c483a
 4) libfabric
  $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/mpich/modules
  $ rm -rf libfabric
   $ git clone https://github.com/yutaka-ishikawa/libfabric.git
  $ cd libfabric/prov/tofu/src
  $ git checkout fast
  $ ln -s ../../../../../../utf .

(2) Installation
 1) utf
   # export UTF_ARCH=fugaku		for single thread compiled by cross gcc
   # export UTF_ARCH=fugaku-mt		for multiple thread compiled by cross gcc
   # export UTF_ARCH=fugaku-native	for single thread compiled by Fujitsu fcc on compute node
   # export UTF_ARCH=fugaku-native-mt	for multiple thread compiled by Fujitsu fcc on compute node
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/utf/src
   $ export UTF_ARCH=fugaku
   $ make
   $ make install
 2) mpich
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/mpich
   $ patch -p1 < ../tool/diff/MPICH-UTF.diff 
   $ patch -p1 < ../tool/diff/MPICH-FC.diff 
   $ cd ..
   $ ./tool/mpich-autogen
     # check if the autogen has successfuly finished:
	  the log is log/gen-mpi.txt
   $ ./tool/mpich3.4-gcc-configure
     # check if the configure has successfuly finished:
	  the log is log/gen-mpich-gcc.txt
   $ mv mpich/src/util/mpir_cvars.c mpich/src/util/mpir_cvars.c.org
   $ cp tool/diff/utf-mpir_cvars.c mpich/src/util/mpir_cvars.c
   $ (cd mpich; date; make -j 4 V=1 >../log/cmp-mpich-gcc.txt 2>&1; date)
     # check if the compilation has successfuly finished:
	  the log is log/cmp-mpich-gcc.txt
   $ (cd mpich; make V=1 install > ../log/inst-mpich-gcc.txt 2>&1; date)
3) mpich execution wrapper and VBG
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/utf/src/mpi_vbg
   $ make
   $ make install

(3) Runtime Environment
   $ export MPICH_HOME=$(HOME)/mpich-tofu/
   $ export PATH=$PATH:$(MPICH_HOME)/bin:$PATH

(4) Test
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/utf/test
   $ cd base
   $ make clean; make
   $ mkdir results
   $ pjsub run-numazu-test_p2p.sh

