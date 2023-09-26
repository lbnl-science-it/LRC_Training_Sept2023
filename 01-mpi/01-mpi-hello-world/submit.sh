#!/bin/bash
#SBATCH --account scs --partition lr6 --qos lr_normal --time 00:10:00 
#SBATCH --nodes 2

cd /global/scratch/users/elam3/mpi_hello_world

module load gcc/12.1.0 openmpi/4.1.4-gcc

mpirun ./a.out
