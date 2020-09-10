BEGIN {
    printf "test name, # of tests, # of successes, # of failes\n"
}
/\[TESTNAME\]:/ { name = $2; }
/\[NUM_TESTS\]:/ { ntests = $2; }
/\[NUM_SUCCESS\]:/ { nsuccess = $2; }
/\[NUM_FAILED\]:/ { nfails = $2; }
/\[FAILED_TESTS\]:/ {
    printf "%s, %d, %d, %d, ", name,ntests,nsuccess,nfails;
    if (nfails != 0) {
	pos = 2;
	for (i = 0; i < nfails; i++) {
	    printf "%s, ", $pos;
	    pos++;
	}
    }
    printf "\n";
}
