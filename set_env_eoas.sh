module purge
# module load miniconda3
# module load nvidia
module load gcc
module load openmpi
module load hdf5
module load pnetcdf
module load netcdf
module load pio
# module load pio/1.10.1
module load fftw

module list

conda activate

export NETCDF=${NETCDF_ROOT}
export PNETCDF=${PNETCDF_ROOT}
export PIO=${PIO_ROOT}
export FFTW=${FFTW_ROOT}

export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=true
