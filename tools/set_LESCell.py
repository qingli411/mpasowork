#!/usr/bin/env python3
"""
This script sets the lesCell array in a mesh, which is the mask for cells that run LES.

Qing Li, 20200205
"""

import sys
import netCDF4
import numpy as np
import argparse
from scipy import spatial

# process the input arguments
parser = argparse.ArgumentParser(description="""
        Read in an MPAS grid file and add/modify the lesCell array for LES mask.
        """)
parser.add_argument('-f', '--file', action='store', dest='fname_in',
        metavar='GRIDFILE', required=True, help='MPAS grid file name')
parser.add_argument('-t', '--type', action='store', dest='type',
        metavar='INPUTTYPE', required=True, help='Input type, \'cellid\' or \'location\'.')
parser.add_argument('-i', '--cellid', action='store', dest='cellid',
        metavar='CELLID', nargs='+',
        help='List of cell IDs. Only used when type is \'cellid\'.')
parser.add_argument('-x', '--xlocation', action='store', dest='xloc',
        metavar='XLOCATION', nargs='+',
        help='List of x locations in fraction (0, 1). Only used when type is \'location\'.')
parser.add_argument('-y', '--ylocation', action='store', dest='yloc',
        metavar='YLOCATION', nargs='+',
        help='List of y locations in fraction (0, 1). Only used when type is \'location\'.')
parser.add_argument('-g', '--graphpart', action='store', dest='fgraph',
        help='Graph partitioning for the MPAS grid.')
parser.add_argument('--version', action='version', version='%(prog)s: 1.0')
# parsing arguments and save to args
args=parser.parse_args()

# read input file
fin = netCDF4.Dataset(args.fname_in, 'r+')

# Get info from input file
xCell = fin.variables['xCell'][:]
yCell = fin.variables['yCell'][:]
nCells = len(fin.dimensions['nCells'])
indexToCellID = fin.variables['indexToCellID'][:]

# read or create lesCell
if 'lesCell' in fin.variables:
  lesCell = fin.variables['lesCell']
else:
  lesCell = fin.createVariable('lesCell', fin.variables['indexToCellID'].dtype, ('nCells',))

lesCell_local = np.zeros( (nCells,) )

# find the cells
print('\nFinding LES Cell...')
print('----------------')
if args.type == 'cellid':
    assert args.cellid is not None, 'Cell ID is required when input type is \'cellid\'.'
    idx = []
    for cellID in args.cellid:
        idx.append(int(cellID)-1)
        print('Cell ID: {:s}'.format(cellID))
        # for test
        # print(indexToCellID[int(cellID)-1])
    cidx = np.array(idx)
    idLESCells = indexToCellID[cidx]
elif args.type == 'location':
    assert args.xloc is not None, 'List of x locations is required when input type is \'location\'.'
    assert args.yloc is not None, 'List of y locations is required when input type is \'location\'.'
    assert len(args.yloc) == len(args.xloc), 'List of y locations should have the same number of elements as the list of x locations.'
    xFracList = np.array([float(x) for x in args.xloc])
    yFracList = np.array([float(y) for y in args.yloc])
    assert xFracList.max() < 1.0 and xFracList.min() > 0.0, 'x locations should be in (0, 1)'
    assert yFracList.max() < 1.0 and yFracList.min() > 0.0, 'y locations should be in (0, 1)'
    xCellMax = xCell.max()
    xCellMin = xCell.min()
    yCellMax = yCell.max()
    yCellMin = yCell.min()
    npoints = len(xFracList)
    xCellList = np.zeros(npoints)
    yCellList = np.zeros(npoints)
    for i in np.arange(npoints):
        xCellList[i] = xCellMin + xFracList[i] * (xCellMax - xCellMin)
        yCellList[i] = yCellMin + yFracList[i] * (yCellMax - yCellMin)
    # select nearest neighbor
    pts = np.array(list(zip(xCellList, yCellList)))
    tree = spatial.KDTree(list(zip(xCell, yCell)))
    p = tree.query(pts)
    cidx = p[1]
    # list of indices
    idLESCells = indexToCellID[cidx]
    xLESCells = xCell[cidx]
    yLESCells = yCell[cidx]
    # print
    for i in np.arange(len(idLESCells)):
        print('Cell {:d} {:6d}: {:10.2f} ({:4.2f}), {:10.2f} ({:4.2f})'.format(i+1, idLESCells[i], \
            xLESCells[i], xFracList[i], yLESCells[i], yFracList[i]))
        # for test
        # print('{:6.4f} {:6.4f}'.format((xCell[cidx[i]]-xCellMin)/(xCellMax-xCellMin), (yCell[cidx[i]]-yCellMin)/(yCellMax-yCellMin)))
else:
    raise ValueError('Input type should be either \'cellid\' or \'location\'.')
print('')

# check graph partitioning for the les cells
print('\nChecking graph partitioning...')
print('----------------')
if args.fgraph is not None:
    gpdata = np.loadtxt(args.fgraph)
    for i in np.arange(cidx.size):
        print('Cell ID: {:d}, Partitioning: {:4d}'.format(idLESCells[i], int(gpdata[idLESCells[i]-1])))
print('')

# save lesCell
lesCell_local[cidx] = 1
lesCell[:] = lesCell_local

fin.close()
