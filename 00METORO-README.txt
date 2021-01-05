	An installation example on Numazu environment	2020/01/06

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

