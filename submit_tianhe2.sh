#!/bin/bash
#SBATCH -J MPASO
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -o MPASO.%j
#SBATCH -p free
#SBATCH -t 2:30:00

source /BIGDATA2/yt_ust_qingli_1/work/mpas/mpasowork/set_env_tianhe2.sh intel

sleep 2

echo "PATH"
echo $PATH
echo " "
echo "LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH
echo " "
module list

case_path="/BIGDATA2/yt_ust_qingli_1/scratch/mpas/ocean/idealized_estuary/0.5km/default/forward"
# case_path="/BIGDATA2/yt_ust_qingli_1/scratch/mpas/ocean/mixed_layer_eddy/0.6km/double_front/forward"

cd ${case_path}

yhrun -N 1 -n 4 ./ocean_model -n namelist.ocean -s streams.ocean

