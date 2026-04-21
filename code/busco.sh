#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=20G
#SBATCH -t 04:00:00
#SBATCH -J busco
#SBATCH --output=%x.%j.out

module load BUSCO/5.8.2-gfbf-2024a

busco \
  -i ~/Genome-Analysis/analyses/02_assembly_2/assembly.fasta \
  -l embryophyta_odb10 \
  -o busco_output \
  -m genome \
  --cpu 2
