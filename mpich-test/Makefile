.PHONY: all

all:
	@echo "make run or make run-clean"
run-comm:
	pjsub comm/batch-scripts/run-mpichtest-*.sh 
run-threads:
	pjsub threads/coll/batch-scripts/run-mpichtest-*.sh
	pjsub threads/comm/batch-scripts/run-mpichtest-*.sh
	pjsub threads/init/batch-scripts/run-mpichtest-*.sh
	pjsub threads/mpi_t/batch-scripts/run-mpichtest-*.sh
	pjsub threads/perf/batch-scripts/run-mpichtest-*.sh
	pjsub threads/pt2pt/batch-scripts/run-mpichtest-*.sh
	pjsub threads/rma/batch-scripts/run-mpichtest-*.sh
	pjsub threads/spawn/batch-scripts/run-mpichtest-*.sh
run-frt:
	pjsub f77/attr/batch-scripts/run-mpichtest-*.sh
	pjsub f77/coll/batch-scripts/run-mpichtest-*.sh
	pjsub f77/pt2pt/batch-scripts/run-mpichtest-*.sh
	pjsub f77/comm/batch-scripts/run-mpichtest-*.sh
	pjsub f77/datatype/batch-scripts/run-mpichtest-*.sh
	pjsub f77/ext/batch-scripts/run-mpichtest-*.sh
	pjsub f77/info/batch-scripts/run-mpichtest-*.sh
	pjsub f77/init/batch-scripts/run-mpichtest-*.sh
	pjsub f77/rma/batch-scripts/run-mpichtest-*.sh
	pjsub f77/topo/batch-scripts/run-mpichtest-*.sh
	pjsub f90/attr/batch-scripts/run-mpichtest-*.sh
	pjsub f90/coll/batch-scripts/run-mpichtest-*.sh
	pjsub f90/pt2pt/batch-scripts/run-mpichtest-*.sh
	pjsub f90/comm/batch-scripts/run-mpichtest-*.sh
	pjsub f90/datatype/batch-scripts/run-mpichtest-*.sh
	pjsub f90/ext/batch-scripts/run-mpichtest-*.sh
	pjsub f90/info/batch-scripts/run-mpichtest-*.sh
	pjsub f90/init/batch-scripts/run-mpichtest-*.sh
	pjsub f90/rma/batch-scripts/run-mpichtest-*.sh
	pjsub f90/topo/batch-scripts/run-mpichtest-*.sh
run-c:
	pjsub attr/batch-scripts/run-mpichtest-*.sh
	pjsub coll/batch-scripts/run-mpichtest-*.sh
	pjsub pt2pt/batch-scripts/run-mpichtest-*.sh
	pjsub comm/batch-scripts/run-mpichtest-*.sh
	pjsub datatype/batch-scripts/run-mpichtest-*.sh
	pjsub info/batch-scripts/run-mpichtest-*.sh
	pjsub init/batch-scripts/run-mpichtest-*.sh
	pjsub rma/batch-scripts/run-mpichtest-*.sh
	pjsub topo/batch-scripts/run-mpichtest-*.sh
	pjsub errhan/batch-scripts/run-mpichtest-*.sh
	pjsub group/batch-scripts/run-mpichtest-*.sh
	pjsub mpi_t/batch-scripts/run-mpichtest-*.sh
	pjsub perf/batch-scripts/run-mpichtest-*.sh
	pjsub errors/batch-scripts/run-mpichtest-*.sh
	pjsub impls/batch-scripts/run-mpichtest-*.sh
run-clean:
	rm -f */results/*.err* */results/*.out* */results/*.stat core.*
