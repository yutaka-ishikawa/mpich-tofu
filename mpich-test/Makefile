.PHONY: all

all:
	@echo "make run or make run-clean"
run-comm:
	pjsub comm/batch-scripts/run-mpichtest-*.sh 
run:
	pjsub attr/batch-scripts/run-mpichtest-*.sh 
	pjsub coll/batch-scripts/run-mpichtest-16.sh
#	pjsub pt2pt/batch-scripts/run-mpichtest-10-1.sh 
#	pjsub pt2pt/batch-scripts/run-mpichtest-10-2.sh 
	pjsub pt2pt/batch-scripts/run-mpichtest-10.sh 
	pjsub comm/batch-scripts/run-mpichtest-*.sh 
	pjsub datatype/batch-scripts/run-mpichtest-*.sh 
	pjsub errhan/batch-scripts/run-mpichtest-*.sh 
	pjsub errors/batch-scripts/run-mpichtest-8.sh 
##	pjsub errors/batch-scripts/run-mpichtest-8-1.sh 
##	pjsub errors/batch-scripts/run-mpichtest-8-2.sh 
	pjsub group/batch-scripts/run-mpichtest-*.sh 
	pjsub impls/batch-scripts/run-mpichtest-*.sh 
	pjsub info/batch-scripts/run-mpichtest-*.sh 
	pjsub init/batch-scripts/run-mpichtest-*.sh 
	pjsub mpi_t/batch-scripts/run-mpichtest-*.sh 
	pjsub perf/batch-scripts/run-mpichtest-*.sh 
##	pjsub rma/batch-scripts/run-mpichtest-*.sh 
	pjsub topo/batch-scripts/run-mpichtest-*.sh 

run-clean:
	rm -f */results/*.err* */results/*.out* */results/*.stat core.*
