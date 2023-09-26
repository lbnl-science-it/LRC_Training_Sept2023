#!/bin/bash
#SBATCH --account scs --partition lr6 --qos lr_normal --time 4:00:00

#SBATCH --nodes 1

cd /global/scratch/users/elam3/LRC101_2023_09/06-containerization/iphop

apptainer run iphop.sif \
  predict \
  --fa_file test_input_phages.fna \
  --db_dir iphop_db/Test_db_rw/ \
  --out_dir iphop_test_results/test_input_phages_iphop
