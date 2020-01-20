#!/bin/bash
# Script to submit MPAS-O job on Summit
#BSUB -P CLI115
#BSUB -W 1:00
#BSUB -nnodes 16
##BSUB -alloc_flags gpumps
#BSUB -J MPASO-SP
#BSUB -o MPASO-SP.%J
#BSUB -e MPASO-SP.%J

source /ccs/home/liqing/work/mpaso/set_env_summit.sh
case_path=/ccs/home/liqing/scratch/mpaso/sp_mixed_layer_eddy
cd ${case_path}
jsrun -n 16 -a 8 -c 8 ./ocean_model -n namelist.ocean -s streams.ocean
