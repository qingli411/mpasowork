export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export PGI=${HOME}/local/pgi/linux86-64/2019
export CUDA=${HOME}/local/pgi/linux86-64/2019/cuda/10.1
export NETCDF=${HOME}/local/env-mpas-pgi
export PNETCDF=${HOME}/local/env-mpas-pgi
export PIO=${HOME}/local/env-mpas-pgi
export FFTW=${HOME}/local/env-mpas-pgi

export PATH=$PGI/mpi/openmpi-3.1.3/bin:${PGI}/bin:${PATH}
export LD_LIBRARY_PATH=${PGI}/lib:${CUDA}/lib64:${LD_LIBRARY_PATH}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=true
