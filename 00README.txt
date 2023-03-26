If you already read this file, you have already cloned mpich-tofu

(0) Here are assumptions
 1) build directories are
   $HOME/work/gcc       - for single thread compiled by cross gcc
   $HOME/work/gcc-mt    - for multiple thread compiled by cross gcc
   $HOME/work/native    - for single thread compiled by Fujitsu fcc on compute node
   $HOME/work/native-mt - for multiple thread compiled by Fujitsu fcc on compute node
 2) installation directories are
   $HOME/mpich-tofu       - for single thread compiled by cross gcc
   $HOME/mpich-tofu-mt    - for multiple thread compiled by cross gcc
   $HOME/mpich-tofu-nv    - for single thread compiled by Fujitsu fcc on compute node
   $HOME/mpich-tofu-nv-mt - for multiple thread compiled by Fujitsu fcc on compute node
 3) configuration scripts are
   mpich3.4-gcc-configure       - for single thread compiled by cross gcc
   mpich3.4-gcc-mt-configure    - for multiple thread compiled by cross gcc
   mpich3.4-native-configure    - for single thread compiled by Fujitsu fcc on compute node
   mpich3.4-native-mt-configure - for multiple thread compiled by Fujitsu fcc on compute node
 4) shell variable for UTF build
   export UTF_ARCH=fugaku		for single thread compiled by cross gcc
   export UTF_ARCH=fugaku-mt		for multiple thread compiled by cross gcc
   export UTF_ARCH=fugaku-native	for single thread compiled by Fujitsu fcc on compute node
   export UTF_ARCH=fugaku-native-mt	for multiple thread compiled by Fujitsu fcc on compute node

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
##   $ git checkout fast
## The debug0 branch is currently stable
   $ git checkout debug0
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu
 3) mpich
   $ git clone --recursive https://github.com/pmodels/mpich.git
   # izem module might be missing
     $ cd mpich/modules
     $ git clone https://github.com/pmodels/izem
     $ cd ../..
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
   $ patch -p1 < ../tool/diff/MPICH-UTF.patch
      ### $ patch -p1 < ../tool/diff/MPICH-FC.patch
   $ patch -p1 < ../tool/diff/MPICH3.4-UTF-FCCONF.patch
   $ cd ..
   $ ./tool/mpich-autogen
     # check if the autogen has successfuly finished:
	  the log is log/gen-mpi.txt
   # mpich3.4-gcc-configure       - for single thread compiled by cross gcc
   # mpich3.4-gcc-mt-configure    - for multiple thread compiled by cross gcc
   # mpich3.4-native-configure    - for single thread compiled by Fujitsu fcc on compute node
   # mpich3.4-native-mt-configure - for multiple thread compiled by Fujitsu fcc on compute node
   $ ./tool/mpich3.4-gcc-configure
     # check if the configure has successfuly finished:
	  the log is log/gen-mpich-gcc.txt, or
		     log/gen-mpich-gcc-mt.txt,
		     log/gen-mpich-native.txt,
		     log/gen-mpich-native-mt.txt
   $ mv mpich/src/util/mpir_cvars.c mpich/src/util/mpir_cvars.c.org
   $ cp tool/diff/utf-mpir_cvars.c mpich/src/util/mpir_cvars.c
   $ (cd mpich; date; make -j 4 V=1 >../log/cmp-mpich-gcc.txt 2>&1; date)
     # check if the compilation has successfuly finished:
	  the log is log/cmp-mpich-gcc.txt
   $ (cd mpich; make V=1 install > ../log/inst-mpich-gcc.txt 2>&1; date)
3) mpich execution wrapper and VBG
   # export UTF_ARCH=fugaku or others
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/utf/src/mpi_vbg
   $ make
   $ make install

(3) Runtime Environment
   $ export MPICH_HOME=$HOME/mpich-tofu/
   $ export PATH=$PATH:$MPICH_HOME/bin:$PATH

(4) Test
   # export UTF_ARCH=fugaku or others
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/utf/test
   $ cd base
   $ make clean; make
   $ mkdir results
   $ pjsub run-numazu-test_p2p.sh


(5) MPICH-Test
   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/mpich/test
   $ make V=1 >& ../../log/cmp-mpichtest.txt
     # The following error might be observed.
    rtest.c: In function 'main':
    rtest.c:9:12: error: 'testname' undeclared (first use in this function); did you mean 'tempnam'?
         printf(testname);
	        ^~~~~~~~
                 tempnam
    rtest.c:9:12: note: each undeclared identifier is reported only once for each function it appears in

   $ cd $EXAMPLE_HOME/work/gcc/mpich-tofu/mpich-test/script
   $ (export MPICH_SRCDIR=$EXAMPLE_HOME/work/gcc/mpich-tofu/mpich; \
      export MPICH_HOME=$HOME/mpich-tofu/; \
      export SINGLE_TIMEOUT=2m; \
      sh ./CREATE_LIST.sh)
   $ (export MPICH_SRCDIR=$EXAMPLE_HOME/work/gcc/mpich-tofu/mpich; \
      export MPICH_HOME=$HOME/mpich-tofu/; \
      sh ./CREATE_BATCH.sh dvsys-spack2 rscunit_ft02)

------
   $ (export MPICH_SRCDIR=$HOME/work2/mpich-tofu/; export MPICH_HOME=$HOME/mpich-tofu/; \
     export SINGLE_TIMEOUT=2m; \
     sh ./CREATE_LIST.sh)
   $ (export MPICH_SRCDIR=$HOME/work2/mpich-tofu/; export MPICH_HOME=$HOME/mpich-tofu/; \
     sh ./CREATE_BATCH.sh dvsys-spack2 rscunit_ft02)
