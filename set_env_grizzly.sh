module purge
module use -a /usr/projects/climate/SHARED_CLIMATE/modulefiles/all

# IC mods
module load intel/17.0.1
module load openmpi/1.10.5
module load netcdf/4.4.1
module load parallel-netcdf/1.5.0
module load pio/1.7.2

echo "NETCDF is set to ${NETCDF}"
echo "NETCDFF is set to ${NETCDFF}"
echo "PNETCDF is set to ${PNETCDF}"
echo "PIO is set to ${PIO}"

# export FFTW=/lustre/scratch3/turquoise/qingli/software/fftw3/3.3.8/gcc-6.4.0
# echo "FFTW is set to ${FFTW}"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
