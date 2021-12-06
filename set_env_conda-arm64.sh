# conda activate mpas
export PREFIX="${HOME}/miniforge3/envs/mpas"
export MPAS_EXTERNAL_LIBS="-L${PREFIX}/lib -lnetcdff"
export NETCDF=${PREFIX}
export NETCDFF=${PREFIX}
export PNETCDF=${PREFIX}
export PIO=${PREFIX}
export FFTW=${PREFIX}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
