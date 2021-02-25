export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export PGI=${HOME}/local/nvidia/hpc_sdk/Linux_x86_64/20.11/compilers
export CUDA=${HOME}/local/nvidia/hpc_sdk/Linux_x86_64/20.11/cuda/11.1
export OPENMPI=${HOME}/local/nvidia/hpc_sdk/Linux_x86_64/2020/comm_libs/openmpi/openmpi-3.1.5
export OPAL_PREFIX=${OPENMPI}
export ENV_MPAS_PGI=${HOME}/local/env-mpas-pgi
export NETCDF=${ENV_MPAS_PGI}
export PNETCDF=${ENV_MPAS_PGI}
export PIO=${ENV_MPAS_PGI}
export FFTW=${ENV_MPAS_PGI}

export PATH=${ENV_MPAS_PGI}/bin:${OPENMPI}/bin:${PGI}/bin:${PATH}
export LD_LIBRARY_PATH=${ENV_MPAS_PGI}/lib:${OPENMPI}/lib:${PGI}/lib:${CUDA}/lib64:${LD_LIBRARY_PATH}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
