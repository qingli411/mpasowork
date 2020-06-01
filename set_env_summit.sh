# Set up PGI environment on summit
#
# Qing Li, 20200115

# these modules are loaded automatically by default on summit
# module purge
# module load lsf-tools/2.0
# module load xalt/1.1.4
# module load spectrum-mpi/10.3.0.1-20190611

# modules for building MPAS with PGI
module load pgi/19.4
module load cuda/10.1.168
module load hdf5/1.10.3
module load parallel-netcdf/1.8.1
module load netcdf/4.6.1
module load netcdf-fortran/4.4.4
module load fftw/3.3.8

export NETCDF=$(nc-config --prefix)
echo "NETCDF is set to ${NETCDF}"
export NETCDFF=$(nf-config --prefix)
echo "NETCDFF is set to ${NETCDFF}"
export PNETCDF=$(pnetcdf-config  --prefix)
echo "PNETCDF is set to ${PNETCDF}"
export FFTW=$(dirname $(dirname $(which fftw-wisdom)))
echo "FFTW is set to ${FFTW}"
export CUDA=$(dirname $(dirname $(which cuda-gdb)))
echo "CUDA is set to ${CUDA}"
export PGI=$(dirname $(dirname $(which pgcc)))
echo "PGI is set to ${PGI}"

# PIO1 is built by the script 'install_env_mpaso_summit.sh', PIO2 module on summit doesn't seem to work
export PIO="${HOME}/local/pio-1.10.1"
echo "PIO is set to ${PIO}"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
