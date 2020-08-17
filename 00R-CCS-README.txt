$ git clone git@git.sys.r-ccs.riken.jp:software/mpich-tofu
$ cd mpich-tofu
$ git clone git@git.sys.r-ccs.riken.jp:software/utf
$ cd utf/src
$ export UTF_ARCH=fugaku
$ make INSTDIR=/home/users/ea01/share/mpich-tofu/
$ make install INSTDIR=/home/users/ea01/share/mpich-tofu/
$ cd ../..

$ git clone git@git.sys.r-ccs.riken.jp:software/libfabric
$ cd libfabric/prov/tofu/src
$ ./tool/libfabric-autogen
$ ./tool/libfabric-configure /home/users/ea01/share/mpich-tofu/
$ cd libfabric
$ make CFLAGS=-DUTF_DEBUG
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


