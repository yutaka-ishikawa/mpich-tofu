sh ./generate_run.sh -s threads/coll:resource=$1,unit=$2
sh ./generate_run.sh -s threads/comm:resource=$1,unit=$2
sh ./generate_run.sh -s threads/init:resource=$1,unit=$2
sh ./generate_run.sh -s threads/mpi_t:resource=$1,unit=$2
sh ./generate_run.sh -s threads/pt2pt:resource=$1,unit=$2
sh ./generate_run.sh -s threads/rma:resource=$1,unit=$2
sh ./generate_run.sh -s threads/spawn:resource=$1,unit=$2
sh ./generate_run.sh -s threads/perf:resource=$1,unit=$2

exit
