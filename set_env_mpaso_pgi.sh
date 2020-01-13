export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export PGI=${HOME}/local/pgi/linux86-64/2019
export CUDA=${HOME}/local/pgi/linux86-64/2019/cuda/10.1
export OPENMPI=${PGI}/mpi/openmpi-3.1.3
export ENV_MPAS_PGI=${HOME}/local/env-mpas-pgi
export NETCDF=${ENV_MPAS_PGI}
export PNETCDF=${ENV_MPAS_PGI}
export PIO=${ENV_MPAS_PGI}
export FFTW=${ENV_MPAS_PGI}

export PATH=${ENV_MPAS_PGI}/bin:${OPENMPI}/bin:${PGI}/bin:${PATH}
export LD_LIBRARY_PATH=${ENV_MPAS_PGI}/lib:${OPENMPI}/lib:${PGI}/lib:${CUDA}/lib64:${LD_LIBRARY_PATH}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=true
