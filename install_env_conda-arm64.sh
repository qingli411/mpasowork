#!/bin/bash

set -e

export PNETCDF_VERSION=1.12.2
export PIO_VERSION=1.10.1
export DARWIN_VERSION=$(uname -v | awk '{print $4}' | sed 's/://')

# modify this to fit your system
export CONDA_PATH=${HOME}/miniforge3

source ${CONDA_PATH}/etc/profile.d/conda.sh

function install_mpas_env() {
    conda create -y -n mpas python=3.8 mpich fortran-compiler cxx-compiler c-compiler m4 git cmake six netcdf4 xarray matplotlib metis
}

function install_pnetcdf() {
    # install pnetcdf
    if [[ ! -d pnetcdf-${PNETCDF_VERSION} ]]; then
        wget https://parallel-netcdf.github.io/Release/pnetcdf-${PNETCDF_VERSION}.tar.gz
        tar xvf pnetcdf-${PNETCDF_VERSION}.tar.gz
    fi
    cd pnetcdf-${PNETCDF_VERSION}

    ./configure --prefix=${PREFIX} --build=aarch64-apple-darwin${DARWIN_VERSION} --host=aarch64-apple-darwin${DARWIN_VERSION}
    make
    make install

    cd ..
    rm -rf pnetcdf-${PNETCDF_VERSION}*
}

function install_pio() {
    # install pio
    if [[ ! -d ParallelIO ]]; then
        git clone git@github.com:NCAR/ParallelIO.git
    fi
    cd ParallelIO
    # git checkout pio${PIO_VERSION//./_}
    git checkout pio${PIO_VERSION}

    cd pio
    export PIOSRC=`pwd`

    if [[ ! -d bin ]]; then
        git clone https://github.com/PARALLELIO/genf90.git bin
    fi
    cd bin
    git checkout genf90_140121
    cd ..
    if [[ ! -d cmake ]]; then
        git clone https://github.com/CESM-Development/CMake_Fortran_utils.git cmake
    fi
    cd ..

    export NETCDF=$(nc-config --prefix)
    export NETCDFF=${NETCDF}
    export PNETCDF=${PREFIX}
    export PHDF5=${PREFIX}
    export MPIROOT=${PREFIX}

    export FC=mpif90
    export CC=mpicc
    export FCFLAGS="-w -fallow-argument-mismatch"
    export FFLAGS="-w -fallow-argument-mismatch"
    mkdir -p pio-${PIO_VERSION}
    cd pio-${PIO_VERSION}
    cmake -D NETCDF_C_DIR=${NETCDF} -D NETCDF_Fortran_DIR=${NETCDFF} \
    -D PNETCDF_DIR=${PNETCDF} -D CMAKE_VERBOSE_MAKEFILE=1 \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} ${PIOSRC}
    make
    cp *.h *.mod ${PREFIX}/include
    cp *.a ${PREFIX}/lib

    cd ..
    rm -rf ParallelIO
}

function install_mpas_tool() {
    if [[ ! -d ${PREFIX}/MPAS-Tools ]]; then
        git clone git@github.com:MPAS-Dev/MPAS-Tools.git ${PREFIX}/MPAS-Tools
    fi
    cd ${PREFIX}/MPAS-Tools/mesh_tools/mesh_conversion_tools
    make
    ln -sf ${PREFIX}/MPAS-Tools/mesh_tools/mesh_conversion_tools/MpasCellCuller.x ${PREFIX}/bin/
    ln -sf ${PREFIX}/MPAS-Tools/mesh_tools/mesh_conversion_tools/MpasMaskCreator.x ${PREFIX}/bin/
    ln -sf ${PREFIX}/MPAS-Tools/mesh_tools/mesh_conversion_tools/MpasMeshConverter.x ${PREFIX}/bin/
    ln -sf ${PREFIX}/MPAS-Tools/mesh_tools/planar_hex/planar_hex ${PREFIX}/bin/
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

install_mpas_tool
