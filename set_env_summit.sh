# Set up PGI environment on summit
#
# Qing Li, 20200115

# these modules are loaded automatically by default on summit
# module purge
# module load lsf-tools/2.0
# module load xalt/1.1.4
# module load spectrum-mpi/10.3.0.1-20190611

# modules for building MPAS with PGI
module load pgi/19.4
module load cuda/10.1.168
module load hdf5/1.10.3
module load parallel-netcdf/1.8.1
module load netcdf/4.6.1
module load netcdf-fortran/4.4.4
module load fftw/3.3.8

export NETCDF="/autofs/nccs-svm1_sw/summit/.swci/1-compute/opt/spack/20180914/linux-rhel7-ppc64le/pgi-19.4/netcdf-4.6.1-v4wugms6r2kyc2t4nfk3psvj3tjtphtr"
export NETCDFF="/autofs/nccs-svm1_sw/summit/.swci/1-compute/opt/spack/20180914/linux-rhel7-ppc64le/pgi-19.4/netcdf-fortran-4.4.4-bnodjvu26hxkad6fs5tu7klfj2bky4xf"
export PNETCDF="/autofs/nccs-svm1_sw/summit/.swci/1-compute/opt/spack/20180914/linux-rhel7-ppc64le/pgi-19.4/parallel-netcdf-1.8.1-6r5js3ccnklqhdpxowtw4v4k5ntzclms"
export FFTW="/autofs/nccs-svm1_sw/summit/.swci/1-compute/opt/spack/20180914/linux-rhel7-ppc64le/pgi-19.4/fftw-3.3.8-2fp4ghpiwcghmgam6fy7dyodnibxfk25"

# PIO1 is built by the script 'install_env_mpaso_summit.sh', PIO2 module on summit doesn't seem to work
export PIO="/autofs/nccs-svm1_home1/liqing/local/pio-1.10.1"

# flags
export CORE=ocean
export AUTOCLEAN=true
export USE_PIO2=false
