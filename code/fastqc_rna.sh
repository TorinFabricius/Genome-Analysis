#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_rna
#SBATCH --output=%x.%j.out

module load FastQC/0.12.1-Java-17

mkdir -p ~/Genome-Analysis/analyses/05_rna_analysis/01_fastqc

fastqc ~/Genome-Analysis/data/raw_data/rna_selected/*.fq.gz \
  -o ~/Genome-Analysis/analyses/05_rna_analysis/01_fastqc
