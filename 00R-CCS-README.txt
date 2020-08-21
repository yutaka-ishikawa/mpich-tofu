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
$ ./tool/libfabric-autogen
$ ./tool/libfabric-configure /home/users/ea01/share/mpich-tofu/
$ (cd libfabric; make V=1 CFLAGS=-DUTF_DEBUG >&../log/cmp-libfabric.txt)
$ (cd libfabric; make install >&../log/inst-libfabric.txt)
$ make install

$ mpich is copied
$ cd mpich
$ ./tool/mpich-autogen
$ ./tool/mpich-configure disable-fast /home/users/ea01/share/mpich-tofu/
$ make
$ make install
$ cd ..

$ export PATH=$PATH:/home/users/ea01/share/mpich-tofu/bin
$ cd libfabric/prov/tofu/src/utf/mpitest/src
$ make
$ make install


