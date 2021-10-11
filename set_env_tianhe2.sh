env=$1
# load modules
module purge
if [[ ${env} == "intel" ]]; then
    echo "Loading environment for Intel"
    module load intelcompiler/14.0.2
    module load MPI/mpich/3.2.1-icc-14.0.2-dynamic
    module load netcdf/4.5.0-icc-14.0.2
    module load pnetcdf/1.9.0-icc-14.0.2
    module load PIO/2.4.0-icc-14.0.2
    module load cmake/3.20.2
    export PIO="/BIGDATA1/app/PIO/2.4.0-icc-14.0.2"
    export USE_PIO2=true
elif [[ ${env} == "gnu" ]]; then
    echo "Loading environment for GNU"
    module load gcc/5.2.0
    module load MPI/mpich/3.2.1-gcc-5.2.0-dynamic
    module load netcdf/4.6.3-gcc-5.2.0
    module load pnetcdf/1.11.0-gcc-5.2.0
    module load PIO/1.9.23-gcc-5.2.0
    module load cmake/3.17.0-gcc-5.2.0
    export PIO="/BIGDATA1/app/PIO/1.9.23-gcc-5.2.0"
    export USE_PIO2=false
fi

export NETCDFF=${NETCDF}
echo "NETCDF is set to ${NETCDF}"
echo "NETCDFF is set to ${NETCDFF}"
echo "PNETCDF is set to ${PNETCDF}"
echo "PIO is set to ${PIO}"

# flags
export CORE=ocean
export AUTOCLEAN=true

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
