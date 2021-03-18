#
#
#
N_1K="rscunit=rscunit_ft01,rscgrp=eap-small"
N_2K="rscunit=rscunit_ft01,rscgrp=eap-large"
##N_2K="rscunit=rscunit_ft01,rscgrp=dvsys-mck6-4,jobenv=linux2"
N_4K=$(N_2K)
N_8K=$(N_2K)
N_16K="rscunit=rscunit_ft01,rscgrp=eap-large"
N_32K="rscunit=rscunit_ft01,rscgrp=eap-large"
N_64K="rscunit=rscunit_ft01,rscgrp=eap-large"
N_72R="rscunit=rscunit_ft01,rscgrp=eap-large"
#
all:
	@echo "Needs argument"

1k-tag:
	pjsub -L $(N_1K) run-imb-1k-tg.sh; date
2k-tag:
	pjsub -L $(N_2K) run-imb-2k-tg.sh; date
4k-tag:
	pjsub -L $(N_4K) run-imb-4k-tg.sh; date
8k-tag:
	pjsub -L $(N_8K) run-imb-8k-tg.sh; date
16k-tag:
	pjsub -L $(N_16K) run-imb-16k-tg.sh; date
32k-tag:
	pjsub -L $(N_32K) run-imb-32k-tg.sh; date
64k-tag:
	pjsub -L $(N_64K) run-imb-64k-tg.sh; date

1k-am:
	pjsub -L $(N_1K) run-imb-1k-am.sh; date
2k-am:
	pjsub -L $(N_2K) run-imb-2k-am.sh; date
4k-am:
	pjsub -L $(N_4K) run-imb-4k-am.sh; date
8k-am:
	pjsub -L $(N_8K) run-imb-8k-am.sh; date
16k-am:
	pjsub -L $(N_16K) run-imb-16k-am.sh; date
32k-am:
	pjsub -L $(N_32K) run-imb-32k-am.sh; date
64k-am:
	pjsub -L $(N_64K) run-imb-64k-am.sh; date
#
72r-am:
	pjsub -L $(N_72R) run-imb-72rack-am.sh; date
#
run-clean:
	rm -f core.*
