SRC_DIR=.
SRC_MPICH=/home/z30485/mpich-tofu-org
DST_HOMEDIR=/data/01/pz0485/z30485
DST_RUNDIR=$(DST_HOMEDIR)/work/mpich-org

all:
copy:
	cp $(SRC_DIR)/*.sh $(DST_RUNDIR)
	cp $(SRC_DIR)/*.txt $(DST_RUNDIR)
	cp $(SRC_DIR)/Makefile $(DST_RUNDIR)
##bin-org-copy:
##	cp -rp $(SRC_DIR)/../bin $(DST_RUNDIR)/../bin-org
##	cd ../src; make org-install
mpich-copy:
#	cp -rp $(SRC_MPICH) $(DST_HOMEDIR)
	cp -r $(SRC_MPICH) $(DST_HOMEDIR)
clean:
	rm -f results/mpich-org/bcast/*
	rm -f results/mpich-org/imb/bcast/*
