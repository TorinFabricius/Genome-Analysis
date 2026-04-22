#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=20G
#SBATCH -t 08:00:00
#SBATCH -J repeatmasker
#SBATCH --output=%x.%j.out

module load RepeatMasker/4.2.1-foss-2024a

cd ~/Genome-Analysis/analyses/04_masking/repeatmasker

RepeatMasker \
  -lib ~/Genome-Analysis/analyses/04_masking/repeatmodeler/RM_3273015.WedApr221458212026/consensi.fa.classified \
  -pa 2 \
  ~/Genome-Analysis/analyses/03_polishing/pilon_polished.fasta
