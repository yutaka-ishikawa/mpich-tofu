#!/bin/sh

TEST_DIR=${MPICH_TEST_DIR:-"$MPICH_SRCDIR/mpich-test"}
SRC_DIR=${MPICH_TEST_SRC:-"$MPICH_SRCDIR/mpich/test/mpi"}
INS_DIR=${MPICH_INS_DIR:-"$MPICH_HOME"}
#SINGLE_TIMELMT=${SINGLE_TIMEOUT:-"30s"}	# 30 second
SINGLE_TIMELMT=${SINGLE_TIMEOUT:-"4m"}	        # 4 min.

# Global Variables
default_test="all"
default_timelmt="2h"
default_rscgrp="dvall"
default_rscunt="rscunit_ft01"

usage()
{
	cat << EOF
Usage: ./$0 [OPTION] ...

  -h, --help	Show this help message

  -l, --gen-list <test1> <test2> ...	
		Generate runtest-*.batch for test(s), default test: all
		Avaiable arguments:
			attr   | coll  | comm   | datatype | errhan | group
			info   | init  | mpi_t  | pt2pt    | rma    | topo
			perf   | io    | errors | impls    | all
		For all the supported tests please refer to test/mpi/testlist)
	
  -s, --gen-script <test>:<arg1>=<val1>,<arg2>=<val2>,...
		Generate batch scripts for test(s), default test: all
		Available arguments:
			<r|res|resource>=<resource group>
				specify resource group
			<t|time>=<time><s|sec|seconds,m|min|minutes,h|hours>
				specify time limit
		
		Default test is 'all', default resource group is dvall and
		default time limit is 60 minutes if you specify nothing.
		
		Examples:
		./$0 -s all:r=dvall,t=2h
		# specify rscgroup dvall, time limit 2 hours for 'all'
		./$0 -s spawn
		#specify default resource group and time limit for 'spawn'
		./$0 -s spawn t=30s
		# specify default resource group and time limit 30 seconds 
		# for 'spawn'
		./$0 -s r=dv000
		# specify resource group dv000 and default time limit for 'all'

  -r, --report	<test1> <test2> ...
  		Report test results in a format:
		[TESTNAME]: # Name of the test
		[NUMBER OF TESTS]: # Number of test files
		[NUM_SUCCESS]: # Number of succeeded tests (return value is zero)
		[NUM_FAILED]: # Number of failed tests (return value is non-zero)

EOF
}

parse_time()
{
	local value="$1"
	limit_sec=00
	limit_min=00
	limit_hrs=00

	local tm="`echo ${value//[!0-9]/}`"
	if [ ${#tm} -lt 2 ]; then
		tm="0${tm}"
	fi

	local unit="`echo ${value//[0-9]/}`"
	if [ -z "$unit" ]; then
		unit=m
	fi
	case $unit in
		s|sec|seconds)
			limit_sec=$tm
			;;
		m|min|minutes)
			limit_min=$tm
			;;
		h|hours)
			limit_hrs=$tm
			;;
	esac

}

cleanup_batch_list()
{
	local dir="$1"
	local filename="$2"

	if [ -e "$dir" ] && [ -n "`find ${dir} -name "$filename"`" ]; then
		find ${dir} -name "${filename}" -exec rm {} \;
	fi
}

gen_batch_testlist()
{
	local runtests="$TEST_DIR/script/runtests"
	if [ ! -e "$runtests" ]; then
		echo -e "\e[1;31m[${FUNCNAME[0]} ERROR]\e[0m: runtests file is missing"
		exit
	fi

	if [ -z "$*" ]; then
		tests="all"
	else
		tests="$@"
	fi

	for each in $tests; do
		local batchdir="$TEST_DIR/$each/runlists"
		local testfile=""
		local srcdir=""
		
		cleanup_batch_list "$TEST_DIR/$each" runtests*.batch
		cleanup_batch_list $batchdir runtests*.batch

		if [ "$each" = "all" ]; then
			srcdir="${SRC_DIR}"
			testfile="${SRC_DIR}/testlist"
		else
			srcdir="${SRC_DIR}/${each}"
			testfile="${SRC_DIR}/$each/testlist"
		fi
		if [ ! -e ${testfile} ]; then
			echo -e "\e[1;31m[${FUNCNAME[0]} ERROR]\e[0m: Can't find testlist"
			exit	
		fi
#		local runtests_parm="-srcdir=${srcdir} \
#			-batchdir=${batchdir} -batch \
#			-tests=${testfile} -mpiexec=mpiexec -timelimitarg=${SINGLE_TIMELMT}"
		local runtests_parm="-srcdir=${srcdir} \
			-batchdir=${batchdir} -batch \
			-tests=${testfile} -mpiexec=mpich_exec -timelimitarg=${SINGLE_TIMELMT}"

		perl $runtests $runtests_parm
	done
}

gen_batch_script()
{
	# Default values
	parse_time ${default_timelmt}

	local testname=${default_test}
	local timelmt="${limit_hrs}:${limit_min}:${limit_sec}"
	local rscgroup=${default_rscgrp}
	local rscunit=${default_rscunt}
	local option=

	for option; do
		case $option in
			-n)
				shift
				testname="$1"
				shift
				;;
			-t)
				shift
				timelmt="$1"
				shift
				;;
			-r)
				shift
				rscgroup="$1"
				shift
				;;
			-u)
				shift
				rscunit="$1"
				shift
				;;
			-*)
				echo -e "\e[1;31m[${FUNCNAME[0]} ERROR]\e[0m:"\
					"Invalid option value $option"
				exit
				;;
		esac
	done

	local testname2=`echo $testname | sed -e 's/\//_/g'`
	
	# Generate batch-scripts under testname folder
	local subdir="${TEST_DIR}/$testname"
	local bspt_dir="$subdir/batch-scripts"
	local runlists_dir="$subdir/runlists"
	local result_dir="$subdir/results"

	if [ ! -d "$subdir" ] || [ ! -d "$runlists_dir" ] \
		|| [ -z "`find $runlists_dir -name "runtests-*.batch"`" ]; then
		echo -e "\e[1;33m[WARNING]\e[0m: required files missing, generating them automatically..."
		sh $0 -l $testname
	fi
	if [ ! -d "$bspt_dir" ]; then
		mkdir "$bspt_dir" ||\
		{ echo -e "\e[1;31m[ERROR]\e[0m: Failed create directory $bspt_dir" && exit; }
	fi

	cleanup_batch_list $bspt_dir run-mpichtest*.sh

	if [ ! -d "$result_dir" ]; then
		mkdir $result_dir || 
		{ echo -e "\e[1;31m[ERROR]\e[0m: Failed create directory $result_dir" && exit; }
	fi

	local NPs=(`cat $runlists_dir/runtests.batch | egrep -o "\-n\s+[0-9]+\s+" |\
	       	cut -d' ' -f2 |sort -u -n -r`)

	# choose which NP to use (default: largest np)
	for np in ${NPs[0]}; do
		local f="$bspt_dir/run-mpichtest-${np}.sh"
		cat << EOF > ${f}
#!/bin/bash
#
#------ pjsub option --------#
#PJM -N "${testname2}" # jobname
#PJM -S		# output statistics
#PJM --spath "$result_dir/%n.%j.stat"
#PJM -o "$result_dir/%n.%j.out"
#PJM -e "$result_dir/%n.%j.err"
#
#PJM -L "node=${np}"
#	PJM -L "node=${np}:noncont"
#PJM --mpi "max-proc-per-node=1"
#	PJM --mpi "max-proc-per-node=4"
#	PJM --mpi "max-proc-per-node=48"
#PJM -L "elapse=${timelmt}"
#PJM -L "rscunit=${rscunit},rscgrp=${rscgroup}"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=dvsys-mck6,hobenv=linux2"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-small"
#	PJM -L "rscunit=rscunit_ft01,rscgrp=eap-large"
#	PJM -L "rscunit=rscunit_ft02,rscgrp=dvsys-mck2_and_spack2,jobenv=linux" 
#PJM -L proc-core=unlimited
#------- Program execution -------#

export PLE_MPI_STD_EMPTYFILE=off
##export LD_LIBRARY_PATH=\$HOME/${INS_DIR/$HOME\//}/lib:\$LD_LIBRARY_PATH
export MPICH_HOME=$MPICH_HOME
export MPIR_CVAR_CH4_OFI_CAPABILITY_SETS_DEBUG=1
export MPICH_TOFU_SHOW_PARAMS=1
export UTF_INFO=0x1
export PATH=\$MPICH_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$MPICH_HOME/lib:\$LD_LIBRARY_PATH
export UTF_BG_LOAD=1

`find "${runlists_dir}" -name "runtests-*.batch" -exec echo "sh" {} \;`

EOF
	done
	chmod -R +x ${bspt_dir}
	echo "batch scripts generated in ${bspt_dir}"
}

process_result()
{
	local testname="$1"
	local subdir="${TEST_DIR}/$testname"
	local result_dir="$subdir/results"
	if [ ! -d "$result_dir" ]; then
		echo -e "\e[1,31m[ERROR]\e[0m: ${result_dir} does not exist!"
		exit
	fi
	local result_files=(`find $result_dir -name "*.out"`)
	if [ ${#result_files[@]} -eq 0 ]; then
		echo -e "\e[1,31m[ERROR]\e[0m: No data file found!"
		exit
	fi

	for each in ${result_files[@]}; do
		local filename=${each##*/}
		local output=${filename%.*}.summary
		
		local test_num=`grep TESTNAME ${each} | wc -l`
		local err_num=`grep "RETURN-VAL" ${each} | cut -d" " -f2 | awk '/^[^0]/'| wc -l`
		local success_num=`grep "RETURN-VAL" ${each} | cut -d" " -f2 | awk '/0/'| wc -l`
		local test_names=(`grep "TESTNAME" ${each} | cut -d" " -f2`)
		local return_vals=(`grep "RETURN-VAL" ${each} | cut -d" " -f2`)
		
		local failed_tests=()
		for idx in ${!return_vals[@]}; do
			if [ ${return_vals[$idx]} -ne 0 ]; then
				failed_tests+=(${test_names[$idx]})
			fi
		done
		cat << EOF
[FILENAME]: $each
[TESTNAME]: $testname
[NUM_TESTS]: $test_num
[NUM_SUCCESS]: $success_num
[NUM_FAILED]: $err_num
[FAILED_TESTS]: `echo ${failed_tests[@]}`
EOF
	done
}

# START
if [ -z "$*" ]; then 
	usage; exit
fi

for opts in $@; do
	case $opts in
		-l|--gen-list)
			shift
			arglists=()
			arg=$1
			
			while [ -n "$arg" -a "`echo ${arg::1}`" != "-" ]; do
				arglists+=($arg)
				shift
				arg=$1
			done
			gen_batch_testlist ${arglists[@]}
			;;
		-s|--gen-script)
			shift
			default_args="t=${default_timelmt},r=${default_rscgrp}"
			arglists=()
			arg=$1
			
			while [ -n "$arg" -a "`echo ${arg::1}`" != "-" ]; do
				arglists+=($arg)
				shift
				arg=$1
			done
			
			if [ ${#arglists[@]} -eq 0 ]; then
				arglists+=("${default_test}:${default_args}") # Default
			fi

			# input arguments like 
			# <testname>:<t|time>=<value><unit>,<r|res|resource>=<res_grp>
			for each in ${arglists[@]}; do
				if [ -n "`echo $each | awk '/:/'`" ]; then
					testname=`echo ${each%:*}`
					subargs=(`echo ${each#*:} | tr ',' ' '`)
				else
					if [ -n "`echo $each | awk '/=/'`" ]; then
						testname="${default_test}"
						subargs=(`echo ${each} | tr ',' ' '`)
					else
						testname="$each"
						subargs=(`echo ${default_args} | tr ',' ' '`)
					fi
				fi
				
				rscgroup=${default_rscgrp}
				rscunit=${default_rscunt}
				parse_time ${default_timelmt}

				for arg in ${subargs[@]}; do
					name=`echo ${arg%=*}`
					value=`echo ${arg#*=}`
					case $name in
						r|res|resource)
							rscgroup="$value"	
							;;
						t|unit)
							rscunit="$value"	
							;;
						t|time)
							parse_time "$value"
							;;
						*)
							echo -e "\e[1;31m[ERROR]\e[0m: Invalid arguments $name"
							usage && exit
							;;
					esac
				done
				
				timelmt="$limit_hrs:$limit_min:$limit_sec"
				echo "Batch script configuarion details:"
				echo -e "\e[1;32m[TEST NAME]:\e[0m$testname"
			      	echo -e "\e[1;32m[TIME LIMIT]:\e[0m$timelmt"
				echo -e "\e[1;32m[RESOURCE GROUP]:\e[0m$rscgroup"
				
				gen_batch_script -n ${testname} -t ${timelmt} -r ${rscgroup} -u ${rscunit}
			done
			;;
		-r|--report)
			shift
			arglists=()
			arg=$1
			while [ -n "$arg" -a "`echo ${arg::1}`" != "-" ]; do
				arglists+=($arg)
				shift
				arg=$1
			done

			if [ ${#arglist[@]} -eq 0 ]; then
				arglists+=("all") # Default
			fi
			for each in ${arglists}; do
				process_result $each
			done
			;;
		-h|--help)
			usage && exit
			;;
		-*)
			echo -e "\e[1;31m[ERROR]\e[0m: Invalid option value $opts"
			usage && exit
			;;
	esac 
done
