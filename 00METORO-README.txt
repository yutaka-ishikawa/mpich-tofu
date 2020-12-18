What we have done

##### download and initial setting
$ cd /home/g9300001/data/
$ mkdir -p mpich-tofu/work
$ cd mpich-tofu/work
$ git clone git@git.sys.r-ccs.riken.jp:software/mpich-tofu
$ cd mpich-tofu
$ git clone git@git.sys.r-ccs.riken.jp:software/utf
$ git clone git@git.sys.r-ccs.riken.jp:software/libfabric
$ (cd libfabric; git checkout newdev2)
$ (cd libfabric/prov/tofu/src/; ln -s ../../../../utf .)

##### utf installation
$ cd utf/src
$ export UTF_ARCH=fugaku
$ edit Makefile and add the following line:
  HOME=/home/g9300001/data/
$ make
$ make install
$ cd mpi_vbg
  # Note that HOME should be changed to MPICH_HOME in mpich.env
$ make; make install HOME=/home/g9300001/data/
$ ls /home/g9300001/data/mpich-tofu
  # include and lib directories are shown
$ cd ../..
  # CWD is /home/g9300001/data/mpich-tofu/work/mpich-tofu

##### libfabric installation
$ ./tool/libfabric-autogen
$ tool/libfabric-configure /home/g9300001/data/mpich-tofu
$ (cd libfabric; make V=1 CFLAGS=-DUTF_DEBUG >&../log/cmp-libfabric.txt)
$ (cd libfabric; make install >&../log/inst-libfabric.txt)

##### MPICH
# Please copy /home/g9300001/data/mpich-tofu/work/mpich-tofu/mpich-exp
$ cp -rp /home/g9300001/data/mpich-tofu/work/mpich-tofu/mpich-exp ./
$ tool/mpich3.4-configure exp ./mpich-exp/ /home/g9300001/data/mpich-tofu
$ (cd mpich-exp; make V=1 >& ../log/cmp-mpi-exp.txt)
$ cd mpich-exp; make install

#############################################################
$ cd /home/g9300001/data/mpich-tofu/work/mpich-tofu/utf/mpitest/src
$ export PATH=/home/g9300001/data/mpich-tofu/bin:$PATH
$ which mpicc
  /home/g9300001/data/mpich-tofu/bin/mpicc
$ make
$ make install
$ which mpich_exec
  /home/g9300001/data/mpich-tofu/bin/mpich_exec
$ cd ../run
$ mkdir results/vbg
$ edit run-fugaku-coll-vbg.sh and add the following line:
  export MPICH_HOME=/home/g9300001/data/mpich-tofu/
  # Note that this variable must be used in /home/g9300001/data/mpich-tofu/lib/mpich.env
$ pjsub run-fugaku-coll-vbg.sh 
