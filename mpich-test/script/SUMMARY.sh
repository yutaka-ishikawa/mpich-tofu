#!/bin/bash

sh ./generate_run.sh -r attr > tmp.$$
sh ./generate_run.sh -r coll >> tmp.$$
sh ./generate_run.sh -r comm >> tmp.$$
sh ./generate_run.sh -r datatype >> tmp.$$
sh ./generate_run.sh -r errhan >> tmp.$$
sh ./generate_run.sh -r group >> tmp.$$
sh ./generate_run.sh -r info >> tmp.$$
sh ./generate_run.sh -r init >> tmp.$$
sh ./generate_run.sh -r mpi_t >> tmp.$$
sh ./generate_run.sh -r pt2pt >> tmp.$$
sh ./generate_run.sh -r rma >> tmp.$$
sh ./generate_run.sh -r topo >> tmp.$$
sh ./generate_run.sh -r perf >> tmp.$$
##sh ./generate_run.sh -r io
sh ./generate_run.sh -r errors >> tmp.$$
sh ./generate_run.sh -r impls >> tmp.$$

###FNAME=summary-`date +%Y_%m_%d_%T`.csv
FNAME=summary-`date +%Y-%m-%d_%I-%M-%S`.csv
date > $FNAME
awk -f SUMMARY.awk <tmp.$$ >> $FNAME

rm tmp.$$
exit 0
