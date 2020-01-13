#!/bin/bash
# This script build environment for MPAS using PGI

# load pgi
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export PGI=${HOME}/local/pgi/linux86-64/2019
export OPENMPI=${PGI}/mpi/openmpi-3.1.3
export OPAL_PREFIX=${OPENMPI}
export PATH=${PGI}/bin:${PATH}
export PATH=${OPENMPI}/bin:${PATH}
export LD_LIBRARY_PATH=${PGI}/lib::${LD_LIBRARY_PATH}

export CC=pgcc
export FC=pgf90
export MPICC=mpicc
export MPICXX=mpicxx
export MPIF77=mpif77
export MPIF90=mpif90

# environment for mpas-pgi
export PREFIX=${HOME}/local/env-mpas-pgi

# install zlib
export ZLIB_VERSION=1.2.11
wget https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz
tar xvf zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
./configure --prefix=${PREFIX}
make
make install
cd ..
rm -rf zlib-${ZLIB_VERSION}*

# install hdf5
export HDF5_VERSION=1.10.6
echo "Please download hdf5 source code (hdf5-${HDF5_VERSION}.tar.gz) from https://www.hdfgroup.org/downloads/hdf5/source-code"
tar xvf hdf5-${HDF5_VERSION}.tar.gz
cd hdf5-${HDF5_VERSION}
CFLAGS="-fPIC -m64 -tp=px" CXXFLAGS="-fPIC -m64 -tp=px" FCFLAGS="-fPIC -m64 -tp=px" CC=mpicc CXX=mpic++ FC=mpif90 ./configure --with-zlib=${PREFIX} --enable-threadsafe --enable-cxx --enable-fortran --enable-unsupported --enable-parallel --prefix=${PREFIX}
export NPROCS=4
make check
make install
cd ..
rm -rf hdf5-${HDF5_VERSION}*

# install pnetcdf
export PNETCDF_VERSION=1.12.1
wget https://parallel-netcdf.github.io/Release/pnetcdf-${PNETCDF_VERSION}.tar.gz
tar xvf pnetcdf-${PNETCDF_VERSION}.tar.gz
cd pnetcdf-${PNETCDF_VERSION}
CC=mpicc CFLAGS="-fPIC -m64 -tp=px" ./configure --enable-shared --prefix=${PREFIX}
make
make install
cd ..
rm -rf pnetcdf-${PNETCDF_VERSION}*

export LD_LIBRARY_PATH=${PREFIX}/lib:${LD_LIBRARY_PATH}

# install netcdf-c
export NETCDFC_VERSION=4.7.3
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-${NETCDFC_VERSION}.tar.gz
tar xvf netcdf-c-${NETCDFC_VERSION}.tar.gz
cd netcdf-c-${NETCDFC_VERSION}
CC=mpicc CFLAGS="-fPIC -m64 -tp=px" CPPFLAGS="-I${PREFIX}/include" LDFLAGS="-L${PREFIX}/lib" ./configure --enable-pnetcdf --disable-dap --enable-parallel-tests --prefix=${PREFIX}
make check
make install
cd ..
rm -rf netcdf-c-${NETCDFC_VERSION}*

# install netcdf-fortran
export NETCDFF_VERSION=4.5.2
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-${NETCDFF_VERSION}.tar.gz
tar xvf netcdf-fortran-${NETCDFF_VERSION}.tar.gz
cd netcdf-fortran-${NETCDFF_VERSION}
CC=mpicc FC=mpif90 F77=mpif77 FCFLAGS="-fPIC -m64 -tp=px" CFLAGS="-fPIC -m64 -tp=px -DpgiFortran" CPPFLAGS="-I${PREFIX}/include" LDFLAGS="-L${PREFIX}/lib" ./configure --prefix=${PREFIX}
make check
make install
cd ..
rm -rf netcdf-fortran-${NETCDFC_VERSION}*

# install pio
# note: building pio2 from source does not work for mpaso
export PIO_VERSION=1.10.1
rm -rf ParallelIO pio-${PIO_VERSION}
git clone git@github.com:NCAR/ParallelIO.git
cd ParallelIO
git checkout pio${PIO_VERSION}
cd pio
export PIOSRC=`pwd`
git clone https://github.com/PARALLELIO/genf90.git bin
git clone https://github.com/CESM-Development/CMake_Fortran_utils.git cmake
cd ../..
export NETCDF=${PREFIX}
export PNETCDF=${PREFIX}
export FC=mpif90
export CC=mpicc
mkdir pio-${PIO_VERSION}
cd pio-${PIO_VERSION}
cmake -D NETCDF_C_DIR=${NETCDF} -D NETCDF_Fortran_DIR=${NETCDF} \
-D PNETCDF_DIR=${PNETCDF} -D CMAKE_VERBOSE_MAKEFILE=1 \
-D CMAKE_INSTALL_PREFIX=${PREFIX} ${PIOSRC}
make
cp *.h *.mod ${PREFIX}/include
cp *.a ${PREFIX}/lib

# install fftw
export FFTW_VERSION=3.3.8
wget http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz
tar xvf fftw-${FFTW_VERSION}.tar.gz
cd fftw-${FFTW_VERSION}
CC=pgcc FC=pgf90 ./configure --prefix=${PREFIX}
make
make install
cd ..
rm -rf fftw-${FFTW_VERSION}*


