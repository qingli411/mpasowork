# module purge

# load modules
module load intelcompiler/14.0.2
module load MPI/mpich/3.2.1-icc-14.0.2-dynamic
module load netcdf/4.5.0-icc-14.0.2
module load pnetcdf/1.9.0-icc-14.0.2
module load PIO/2.4.0-icc-14.0.2
module load cmake/3.20.2

echo "NETCDF is set to ${NETCDF}"
export NETCDFF=${NETCDF}
echo "NETCDFF is set to ${NETCDFF}"
echo "PNETCDF is set to ${PNETCDF}"
export PIO="/BIGDATA1/app/PIO/2.4.0-icc-14.0.2"
echo "PIO is set to ${PIO}"

# export FFTW=/lustre/scratch3/turquoise/qingli/software/fftw3/3.3.8/gcc-6.4.0
# echo "FFTW is set to ${FFTW}"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=true

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
