#!/bin/bash
# Script to submit MPAS-O job on Summit
#BSUB -P CLI115
#BSUB -W 2:00
#BSUB -nnodes 2
##BSUB -alloc_flags gpumps
#BSUB -J MPASO-SP
#BSUB -o MPASO-SP.%J
#BSUB -e MPASO-SP.%J

source /ccs/home/liqing/work/mpaso/set_env_summit.sh

# casename="sp_baroclinic_channel"
# casename="sp_mixed_layer_eddy"
casename="sp_warm_filament_coupled"
# casename="sp_warm_filament"
case_path="/ccs/home/liqing/scratch/mpaso/${casename}"
cd ${case_path}
jsrun -n 2 -a 8 -c 8 -g 6 ./ocean_model -n namelist.ocean -s streams.ocean
