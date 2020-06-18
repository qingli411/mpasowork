# load pgi
module load pgi/18.10
module load openmpi/3.1.3-pgi_18.10

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
