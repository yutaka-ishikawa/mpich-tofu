.PHONY: all

all:
	@echo "make run or make run-clean"
run-comm:
	pjsub comm/batch-scripts/run-mpichtest-*.sh 
run:
	pjsub f77/attr/batch-scripts/run-mpichtest-*.sh
	pjsub f77/coll/batch-scripts/run-mpichtest-7.sh
	pjsub f77/pt2pt/batch-scripts/run-mpichtest-2.sh
	pjsub f77/comm/batch-scripts/run-mpichtest-*.sh
	pjsub f77/datatype/batch-scripts/run-mpichtest-*.sh
	pjsub f77/ext/batch-scripts/run-mpichtest-1.sh
	pjsub f77/info/batch-scripts/run-mpichtest-*.sh
	pjsub f77/init/batch-scripts/run-mpichtest-*.sh
	pjsub f77/rma/batch-scripts/run-mpichtest-*.sh
	pjsub f77/topo/batch-scripts/run-mpichtest-*.sh
	pjsub f90/attr/batch-scripts/run-mpichtest-*.sh
	pjsub f90/coll/batch-scripts/run-mpichtest-7.sh
	pjsub f90/pt2pt/batch-scripts/run-mpichtest-2.sh
	pjsub f90/comm/batch-scripts/run-mpichtest-*.sh
	pjsub f90/datatype/batch-scripts/run-mpichtest-*.sh
	pjsub f90/ext/batch-scripts/run-mpichtest-1.sh
	pjsub f90/info/batch-scripts/run-mpichtest-*.sh
	pjsub f90/init/batch-scripts/run-mpichtest-*.sh
	pjsub f90/rma/batch-scripts/run-mpichtest-*.sh
	pjsub f90/topo/batch-scripts/run-mpichtest-*.sh
run-clean:
	rm -f */results/*.err* */results/*.out* */results/*.stat core.*
