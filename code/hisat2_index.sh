#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 04:00:00
#SBATCH -J hisat2_index
#SBATCH --output=%x.%j.out

module load HISAT2/2.2.1-gompi-2024a

mkdir -p ~/Genome-Analysis/analyses/06_rna_analysis/index

hisat2-build \
  ~/Genome-Analysis/analyses/04_masking/repeatmasker/pilon_polished.fasta.masked \
  ~/Genome-Analysis/analyses/06_rna_analysis/index/genome_index
