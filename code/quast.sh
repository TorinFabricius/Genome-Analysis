#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J quast
#SBATCH --output=%x.%j.out

module load QUAST/5.3.0-gfbf-2024a

quast.py \
  -o ~/Genome-Analysis/analyses/02_quast \
  ~/Genome-Analysis/analyses/02_assembly_2/assembly.fasta
