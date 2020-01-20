#!/bin/bash
#SBATCH  --job-name=MPASO-SP
#SBATCH  --nodes=4
#SBATCH  --ntasks-per-node=32
#SBATCH  --output=MPASO-SP.%j
#SBATCH  --exclusive
#SBATCH --qos=standard
#SBATCH --time=1:00:00
#SBATCH -A w19_airseales

source /users/qingli/work/mpaso/set_env_badger.sh

casename="sp_mixed_layer_eddy"
case_path="/lustre/scratch3/turquoise/qingli/superParameterization/${casename}"

# mkdir -p ${case_path}
cd ${case_path}

# mpaso_path="/users/qingli/project/MPAS-Model"
# cp $mpaso_path/namelist.ocean ./
# cp $mpaso_path/streams.ocean ./
# ln -s ${mpaso_path}/ocean_model ./

mpirun -n ${SLURM_NTASKS} ./ocean_model -n namelist.ocean -s streams.ocean

