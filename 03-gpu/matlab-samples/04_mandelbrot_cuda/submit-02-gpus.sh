#!/bin/bash
#SBATCH --job-name=mandelbrot_cuda
#SBATCH -A scs -p es1 -q es_normal -t 0-00:05:00
#SBATCH --cpus-per-task=2

#SBATCH --ntasks=2
#SBATCH --gres=gpu:2

cd /global/scratch/users/elam3/LRC101_2023_09/03-gpu/matlab-samples/04_mandelbrot_cuda
module load matlab/r2022a

matlab -nosplash -nojvm -nodisplay -batch test_mandelbrot_cuda
