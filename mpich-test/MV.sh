#!/bin/bash

DST=eagr
PROG="attr coll pt2pt comm datatype errhan erros group impls info init mpi_t perf rma topo"

for name in $PROG
do
    mkdir -p $name/results/$DST
    mv $name/results/*.*  $name/results/$DST/
done

exit
