$ ./tool/mpich3.4-configure normal /home/users/ea01/ea0103/work/mpich-tofu/mpich
$ (cd mpich; make V=1 >& ../log/cmp-mpich-normal.txt)

$  ./tool/mpich3.4-configure perf /home/users/ea01/ea0103/work/mpich-tofu/mpich-fast
$ (cd mpich-fast; make V=1 >& ../log/cmp-mpich-fast.txt)


$ git clone git@git.sys.r-ccs.riken.jp:software/mpich-tofu

(1) UTF installation
$ cd mpich-tofu
$ git clone git@git.sys.r-ccs.riken.jp:software/utf
$ export UTF_ARCH=fugaku
$ (cd utf/src; make INSTDIR=/home/users/ea01/share/mpich-tofu/; make install INSTDIR=/home/users/ea01/share/mpich-tofu/)

(2) LIBFABRIC installation
$ git clone git@git.sys.r-ccs.riken.jp:software/libfabric
$ (cd libfabric; git checkout newdev2)
$ (cd libfabric/prov/tofu/src; ln -s ../../../../utf)
$ 
In the following each step, a log file is created under the log
directory.  Please see it if some errors have been reported.
$ ./tool/libfabric-autogen
$ ./tool/libfabric-configure /home/users/ea01/share/mpich-tofu/
$ (cd libfabric; make clean; make V=1 >&../log/cmp-libfabric.txt)
$ (cd libfabric; make install >&../log/inst-libfabric.txt)

$ mpich is copied

In the following each step, a log file is created under the log
directory.  Please see it if some errors have been reported.
$ ./tool/mpich-autogen
$ ./tool/mpich-configure disable-fast /home/users/ea01/share/mpich-tofu/
	# ./tool/mpich-configure disable-fast /home/users/ea01/ea0103/mpich-tofu/
$ (cd mpich; patch -p1 <../MPICH.diff)
$ (cd mpich; make V=1 >& ../log/cmp-mpich.txt)
$ (cd mpich; make install >& ../log/inst-mpich.txt)

$ export PATH=$PATH:/home/users/ea01/share/mpich-tofu/bin
$ cd libfabric/prov/tofu/src/utf/mpitest/src
$ make
$ make install


