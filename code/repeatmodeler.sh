#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=32G
#SBATCH -t 24:00:00
#SBATCH -J repeatmodeler
#SBATCH --output=%x.%j.out

module load RepeatModeler/2.0.7-foss-2024a

cd ~/Genome-Analysis/analyses/04_masking/repeatmodeler

cp ~/Genome-Analysis/analyses/03_polishing/pilon_polished.fasta .

BuildDatabase \
  -name genome_db \
  pilon_polished.fasta

RepeatModeler \
  -database genome_db \
  -threads 2
