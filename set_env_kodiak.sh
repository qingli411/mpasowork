module purge
module use -a /usr/projects/climate/SHARED_CLIMATE/modulefiles/all

# IC mods
module load pgi/18.10
module load openmpi/2.1.2
module load hdf5-parallel/1.8.16
module load netcdf-h5parallel/4.4.0
module load parallel-netcdf/1.9.0
export NETCDF_PATH=/usr/projects/hpcsoft/toss3/kodiak/netcdf/4.4.0_pgi-18.10_openmpi-2.1.2
export NETCDF=/usr/projects/hpcsoft/toss3/kodiak/netcdf/4.4.0_pgi-18.10_openmpi-2.1.2
export NETCDF_NAME=netcdf
export NETCDF_VERSION=4.4.0
module load pio/2.3.2
module load fftw/3.3.8
module load cudatoolkit/10.0

echo "NETCDF is set to ${NETCDF}"
echo "PNETCDF is set to ${PNETCDF}"
echo "PIO is set to ${PIO}"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=true
