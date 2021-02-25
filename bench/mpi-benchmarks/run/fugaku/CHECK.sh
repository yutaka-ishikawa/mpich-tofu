#!/bin/bash

for i in core.*
do
 echo $i
#  gdb -x gdb.cmd ../../IMB-MPI1-20210206 $i | grep \\$
  gdb -x gdb2.cmd ../../IMB-MPI1-20210206 $i | grep \\$
done

