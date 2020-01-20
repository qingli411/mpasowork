module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/spack-lmod/linux-rhel7-x86_64

# IC mods
module load gcc/6.4.0
module load openmpi/2.1.2
module load cmake/3.12.1
module load mkl

# spack mods
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/hdf5/1.10.1-rpkszo5
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/netcdf/4.4.1.1-zei2j6r
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/netcdf-fortran/4.4.4-v6vwmxs
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/parallel-netcdf/1.8.0-2qwcdbn
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/pio/1.10.0-ljj73au

module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/boost/1.66.0-u6kxo2f
module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/parmetis/4.0.3-p3d7xsi
module load gcc/6.4.0/metis/5.1.0-il7wbho

export NETCDF=$(nc-config --prefix)
echo "NETCDF is set to ${NETCDF}"
export NETCDFF=$(nf-config --prefix)
echo "NETCDFF is set to ${NETCDFF}"
export PNETCDF=$(pnetcdf-config  --prefix)
echo "PNETCDF is set to ${PNETCDF}"

export FFTW=/lustre/scratch3/turquoise/qingli/software/fftw3/3.3.8/gcc-6.4.0
echo "FFTW is set to ${FFTW}"

export PIO=/usr/projects/climate/SHARED_CLIMATE/software/badger/spack-install/linux-rhel7-x86_64/gcc-6.4.0/pio-1.10.0-ljj73au6ctgkwmh3gbd4mleljsumijys/
echo "PIO is set to ${PIO}"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
