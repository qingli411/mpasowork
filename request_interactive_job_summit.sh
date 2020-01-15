#!/bin/bash

bsub -Is -W 2:00 -nnodes 1 -P CLI115 $SHELL
