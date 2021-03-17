#!/bin/bash

sh ./generate_run.sh -r threads/coll > tmp.$$
sh ./generate_run.sh -r threads/comm >> tmp.$$
sh ./generate_run.sh -r threads/init >> tmp.$$
sh ./generate_run.sh -r threads/mpi_t >> tmp.$$
sh ./generate_run.sh -r threads/pt2pt >> tmp.$$
sh ./generate_run.sh -r threads/rma >> tmp.$$
sh ./generate_run.sh -r threads/spawn >> tmp.$$
sh ./generate_run.sh -r threads/perf >> tmp.$$

###FNAME=summary-`date +%Y_%m_%d_%T`.csv
if [[ $MARKDOWN -eq 1 ]]; then
    FNAME=summary-threads-`date +%Y-%m-%d_%H-%M-%S`.md
else
    FNAME=summary-threads-`date +%Y-%m-%d_%H-%M-%S`.csv
fi
LC_TIME=C
LC_LANG=C
date > $FNAME
awk -f SUMMARY.awk <tmp.$$ >> $FNAME

rm tmp.$$
exit 0
