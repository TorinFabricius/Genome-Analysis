#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH -t 01:00:00
#SBATCH -J deseq2
#SBATCH --output=%x.%j.out

module purge
module load R/4.4.2-gfbf-2024a

Rscript /home/torin/Genome-Analysis/code/deseq2.R
