#!/bin/bash
# This script install pio1 on summit
# - Note: pio2 module on summit does not work for mpaso
#
# Qing Li, 20200114

module load pgi/19.4
module load cuda/10.1.168
module load hdf5/1.10.3
module load parallel-netcdf/1.8.1
module load netcdf/4.6.1
module load netcdf-fortran/4.4.4
module load cmake

# install pio
export PIO_VERSION=1.10.1
export PREFIX=${HOME}/local/pio-${PIO_VERSION}
mkdir -p ${PREFIX}/include
mkdir -p ${PREFIX}/lib
rm -rf ParallelIO pio-${PIO_VERSION}
git clone git@github.com:NCAR/ParallelIO.git
cd ParallelIO
git checkout pio${PIO_VERSION}
cd pio
export PIOSRC=`pwd`
git clone https://github.com/PARALLELIO/genf90.git bin
git clone https://github.com/CESM-Development/CMake_Fortran_utils.git cmake
cd ../..
export FC=mpif90
export CC=mpicc
mkdir pio-${PIO_VERSION}
cd pio-${PIO_VERSION}
cmake -D CMAKE_VERBOSE_MAKEFILE=1 \
-D CMAKE_INSTALL_PREFIX=${PREFIX} ${PIOSRC}
make
cp *.h *.mod ${PREFIX}/include
cp *.a ${PREFIX}/lib
rm -rf ParallelIO pio-${PIO_VERSION}

