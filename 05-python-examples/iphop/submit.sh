#!/bin/bash
#SBATCH -A scs -p lr6 -q lr_normal -t 0-4:0:0

#SBATCH --nodes=1

cd /global/scratch/users/elam3/LRC101_2023_09/05-python-examples/iphop
module purge
module load python/3.11.4
source activate iphop_env

iphop predict --fa_file test_input_phages.fna --db_dir iphop_db/Test_db_rw/ --out_dir iphop_test_results/test_input_phages_iphop
