#!/bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -j oe
#PBS -m abe -M vandan.patel@okstate.edu


cd $PBS_O_WORKDIR
module load matlab

matlab -nodesktop -r Main_allScen_tryC_ifSaveW
