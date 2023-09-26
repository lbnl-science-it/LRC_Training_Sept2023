#!/bin/bash
#SBATCH --account scs
#SBATCH --partition es1
#SBATCH --qos es_normal
#SBATCH --time 0:10:0

#SBATCH --cpus-per-task=2

#SBATCH --ntasks=1
#SBATCH --gres=gpu:1

module load matlab/r2022a
matlab -nosplash -nojvm -nodisplay -batch test_mandelbrot_element_wise_operations
