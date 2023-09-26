#!/bin/bash

#SBATCH --account scs 
#SBATCH --partition es1 
#SBATCH --qos es_normal 
#SBATCH --time 0:10:0

#SBATCH --cpus-per-task 2

#SBATCH --ntasks 1
#SBATCH --gres=gpu:1

apptainer exec --nv pytorch-23.08.sif \
  python -c 'import torch; print( torch.cuda.is_available() )'
