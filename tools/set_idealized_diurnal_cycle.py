#!/usr/bin/env python3
"""
This script sets idealized diurnal cycle in the solar radiation in the forcing data of the single column MPAS-O

Qing Li, 20200616
"""

import numpy as np
import xarray as xr
import pandas as pd
import argparse
import matplotlib.pyplot as plt

def main():

    parser = argparse.ArgumentParser(description="""
            Set idealized diurnal cycle of solar radiation for single column MPAS-O.
            """)
    parser.add_argument('-i', '--input', action='store', dest='fname_in',
            metavar='INPUTFILE', required=True, help='Input MPAS-O forcing file name')
    parser.add_argument('-o', '--output', action='store', dest='fname_out',
            metavar='OUTPUTFILE', required=True, help='Output MPAS-O forcing file name')
    parser.add_argument('-nt', '--num_time', action='store', dest='nt',
            metavar='NUMTIME', required=True, help='Number of time steps')
    parser.add_argument('-dt', '--delta_time', action='store', dest='dt',
            metavar='DTIME', help='Time step (freq in pandas.date_range()), \'30min\' by default')
    parser.add_argument('-tref', '--ref_time', action='store', dest='reftime',
            metavar='REFTIME', help='Reference time (start in pandas.date_range()), \'2000-01-01 00:00:00\' by default')
    parser.add_argument('--version', action='version', version='%(prog)s: 1.0')
    args=parser.parse_args()

    fname_in = args.fname_in
    fname_out = args.fname_out
    nt = int(args.nt)
    dt = args.dt
    reftime = args.reftime
    if dt is None:
        dt = '30min'
    if reftime is None:
        reftime = '2000-01-01 00:00:00'

    time = pd.date_range(reftime, periods=nt, freq=dt)
    factor = diurnal_cycle_factor(time)
    xtime = datetime_to_xtime(time)

    idata = xr.open_dataset(fname_in)
    swr = np.tile(idata.data_vars['shortWaveHeatFlux'].data, (nt, 1))
    for i in np.arange(nt):
        swr[i,:] *= factor[i]

    odata = xr.Dataset()
    time = np.arange(nt)
    odata['xtime'] = xtime
    for var in idata.variables:
        if len(idata.data_vars[var].dims) == 2:
            if var == 'shortWaveHeatFlux':
                odata[var] = xr.DataArray(swr,
                                          dims=['Time', 'nCells'],
                                          attrs=idata.data_vars[var].attrs)
            else:
                odata[var] = xr.DataArray(np.tile(idata.data_vars[var].data, (nt,1)),
                                          dims=['Time', 'nCells'],
                                          attrs=idata.data_vars[var].attrs)
        elif len(idata.data_vars[var].dims) == 3:
            odata[var] = xr.DataArray(np.tile(idata.data_vars[var].data, (nt,1,1)),
                                      dims=['Time', 'nCells', 'nVertLevels'],
                                      attrs=idata.data_vars[var].attrs)

    for att in idata.attrs:
        odata.attrs[att] = idata.attrs[att]

    odata.to_netcdf(fname_out, format='NETCDF4_CLASSIC', unlimited_dims='Time')
    idata.close()

def diurnal_cycle_factor(time):
    """Get the factor of an idealized diurnal cycle (0, 1) following
       f = max(cos(2*pi(t-0.5)), 0.)

    :time:   (datetime like) time
    :return: (numpy.array) diurnal cycle factor

    """
    tod = (3600.*time.hour+60.*time.minute+time.second)/86400.
    return np.maximum(np.cos(2.*np.pi*(tod-0.5)), 0.0)

def datetime_to_xtime(time):
    """Convert time in datetime to MPAS xtime

    :time:   (datetime like) time
    :return: (xarray.DataArray) MPAS xtime

    """
    time_str = time.strftime('%Y-%m-%d_%H:%M:%S')
    xtime_arr = np.array([bytes(s, 'UTF-8') for s in time_str], dtype='S64')
    xtime = xr.DataArray(xtime_arr, dims=['Time'])
    xtime.attrs['long_name'] = 'model time, with format \'YYYY-MM-DD_HH:MM:SS\''
    xtime.attrs['units'] = 'unitless'
    return xtime

if __name__ == "__main__":
    main()


