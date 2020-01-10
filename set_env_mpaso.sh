conda activate mpas
# Modify this path to point to your mpas conda environment
export PREFIX="${HOME}/miniconda3/envs/mpas"
# this step might not be needed
export MPAS_EXTERNAL_LIBS="-L${PREFIX}/lib -lnetcdff"
export NETCDF=${PREFIX}
export PNETCDF=${PREFIX}
export PIO=${PREFIX}
export FFTW=${PREFIX}
# change to one of the other cores as needed
export CORE=ocean
export AUTOCLEAN=true
