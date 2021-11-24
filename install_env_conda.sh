#!/bin/bash

set -e

export PNETCDF_VERSION=1.12.0
export PIO_VERSION=1.10.1

# modify this to fit your system
export CONDA_PATH=${HOME}/miniconda3

source ${CONDA_PATH}/etc/profile.d/conda.sh

function install_mpas_env() {
    conda create -y -n mpas python=3.8 mpich fortran-compiler cxx-compiler c-compiler m4 git cmake six netcdf4 xarray matplotlib metis mpas_tools fftw
}

function install_pnetcdf() {
    # install pnetcdf
    rm -rf pnetcdf-${PNETCDF_VERSION}*

    wget https://parallel-netcdf.github.io/Release/pnetcdf-${PNETCDF_VERSION}.tar.gz

    tar xvf pnetcdf-${PNETCDF_VERSION}.tar.gz
    cd pnetcdf-${PNETCDF_VERSION}

    ./configure --prefix=${PREFIX}
    make
    make install

    cd ..
}

function install_pio() {
    # install pio
    rm -rf ParallelIO pio-${PIO_VERSION}

    git clone git@github.com:NCAR/ParallelIO.git
    cd ParallelIO
    git checkout pio$PIO_VERSION

    cd pio

    export PIOSRC=`pwd`
    git clone https://github.com/PARALLELIO/genf90.git bin
    cd bin
    git checkout genf90_140121
    cd ..
    git clone https://github.com/CESM-Development/CMake_Fortran_utils.git cmake
    cd ../..

    export NETCDF=$PREFIX
    export PNETCDF=$PREFIX
    export PHDF5=$PREFIX
    export MPIROOT=$PREFIX

    export FC=mpif90
    export CC=mpicc
    mkdir pio-${PIO_VERSION}
    cd pio-${PIO_VERSION}
    cmake -D NETCDF_C_DIR=${PREFIX} -D NETCDF_Fortran_DIR=${PREFIX} \
    -D PNETCDF_DIR=${PREFIX} -D CMAKE_VERBOSE_MAKEFILE=1 \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} $PIOSRC
    make
    cp *.h *.mod ${PREFIX}/include
    cp *.a ${PREFIX}/lib

    cd ..
}

install_mpas_env

conda activate mpas

# modify this
export PREFIX="${CONDA_PATH}/envs/mpas"

export MPICC=mpicc
export MPICXX=mpicxx
export MPIF77=mpif77
export MPIF90=mpif90
export LDFLAGS="-L${PREFIX}/lib"

install_pnetcdf

install_pio
