# conda activate mpas
export PREFIX="${HOME}/miniforge3/envs/mpas"
export MPAS_EXTERNAL_LIBS="-L${PREFIX}/lib -lnetcdff"
# export NETCDF=$(nc-config --prefix)
# export NETCDFF=$(nf-config --prefix)
export NETCDF="/opt/homebrew/Cellar/netcdf/4.8.0_2"
export NETCDFF="/opt/homebrew/Cellar/netcdf/4.8.0_2"
export PNETCDF=${PREFIX}
export PIO=${PREFIX}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
