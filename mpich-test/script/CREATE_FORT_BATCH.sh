#!/bin/bash
#export MPICH_HOME=$HOME/mpich-tofu-fc

#RESOURCE=eap-small
#UNIT=rscunit_ft01

sh ./generate_run.sh -s f77/attr:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/coll:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/comm:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/datatype:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/ext:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/info:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/init:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/pt2pt:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/rma:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f77/topo:resource=$RESOURCE,unit=$UNIT

sh ./generate_run.sh -s f90/attr:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/coll:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/comm:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/datatype:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/ext:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/info:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/init:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/pt2pt:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/rma:resource=$RESOURCE,unit=$UNIT
sh ./generate_run.sh -s f90/topo:resource=$RESOURCE,unit=$UNIT
