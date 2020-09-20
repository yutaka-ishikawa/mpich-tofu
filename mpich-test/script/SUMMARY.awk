BEGIN {
    printf "test name, # of tests, # of successes, # of failes\n"
    tot_test = 0; tot_success = 0; tot_failed = 0;
    ok[0] = "unpub"; ok[1] = "lookup_name";
    ok[2] = "reduceop"; ok[3] = "ireduceop";
    ok[4] = "allgatherlength"; ok[5] = "iallgatherlength";
    ok[6] = "allgatherlength"; ok[7] = "connect_timeout_no_accept";
    ok[8] = "connect_timeout_mismatch"; ok[9] = "badport";
    ok[10] = "connect_timeout__no_accept"; ok[11] = "connect_timeout_mismatch";
    ##ok[12] = ""; ok[11] = "";
    ok_ent = 12;
}
/\[TESTNAME\]:/ { name = $2; }
/\[NUM_TESTS\]:/ { ntest = $2; tot_test += ntest; }
/\[NUM_SUCCESS\]:/ { nsuccess = $2; tot_success += nsuccess; }
/\[NUM_FAILED\]:/ { nfailed = $2;  tot_failed += nfailed; }
/\[FAILED_TESTS\]:/ {
    real_failed = 0;
    if (nfailed != 0) {
	pos = 2;
	for (i = 0; i < nfailed; i++) {
	    skip = 0;
	    for (j = 0; j < ok_ent; j++) {
		if (ok[j] ~ $pos) {
		    skip = 1;
		    break;
		}
	    }
	    if (skip == 0) {
		real_failed++;
	    }
	    pos++;
	}
    }

    printf "%s, %d, %d, %d, ", name, ntest, nsuccess, real_failed;

    if (nfailed != 0) {
	pos = 2;
	for (i = 0; i < nfailed; i++) {
	    skip = 0;
	    for (j = 0; j < ok_ent; j++) {
		#printf "j = %d, PNAME(%s) POS(%s)\n", j, err_ok[j], $pos;
		if (ok[j] ~ $pos) {
		    skip = 1;
		    break;
		}
	    }
	    if (skip == 0) {
		printf "%s ", $pos;
	    }
	    pos++;
	}
    }
    printf "\n";
}

END {
    printf "TOTAL, %d, %d, %d\n", tot_test, tot_success, tot_failed;
}
