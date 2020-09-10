BEGIN {
    printf "test name, # of tests, # of successes, # of failes\n"
    tot_test = 0; tot_success = 0; tot_failed = 0;
}
/\[TESTNAME\]:/ { name = $2; }
/\[NUM_TESTS\]:/ { ntest = $2; tot_test += ntest; }
/\[NUM_SUCCESS\]:/ { nsuccess = $2; tot_success += nsuccess; }
/\[NUM_FAILED\]:/ { nfailed = $2;  tot_failed += nfailed; }
/\[FAILED_TESTS\]:/ {
    printf "%s, %d, %d, %d, ", name,ntest,nsuccess,nfailed;
    if (nfailed != 0) {
	pos = 2;
	for (i = 0; i < nfailed; i++) {
	    printf "%s ", $pos;
	    pos++;
	}
    }
    printf "\n";
}

END {
    printf "TOTAL, %d, %d, %d\n", tot_test, tot_success, tot_failed;
}
