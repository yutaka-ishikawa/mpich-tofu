#!/bin/bash


sh ./generate_run.sh -l threads/coll
sh ./generate_run.sh -l threads/comm
sh ./generate_run.sh -l threads/init
sh ./generate_run.sh -l threads/mpi_t
sh ./generate_run.sh -l threads/pt2pt
sh ./generate_run.sh -l threads/rma
sh ./generate_run.sh -l threads/spawn
sh ./generate_run.sh -l threads/perf

exit
