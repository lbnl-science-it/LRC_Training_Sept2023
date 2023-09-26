#!/bin/bash
#SBATCH --account scs --partition lr6 --qos lr_normal --time 0:10:0
#SBATCH --nodes 1

cd /global/scratch/users/elam3/LRC101_2023_09/02-gnu-parallel/hello-example

module load parallel/20200222
parallel --link -j2 bash HelloApp.sh {1} {2} :::: names.txt :::: places.txt

