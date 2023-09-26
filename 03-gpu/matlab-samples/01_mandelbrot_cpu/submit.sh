#!/bin/bash
#SBATCH --account scs --partition lr6 --qos lr_normal --time 0:10:0
#SBATCH --nodes 1

module load matlab/r2022a
matlab -nosplash -nojvm -nodisplay -batch test_mandelbrot_cpu
