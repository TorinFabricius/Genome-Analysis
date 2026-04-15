#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_trimmed
#SBATCH --output=%x.%j.out

module load FastQC/0.12.1-Java-17

mkdir -p ~/Genome-Analysis/analyses/01_preprocessing_trimmed

fastqc \
  -o ~/Genome-Analysis/analyses/01_preprocessing_trimmed \
  -t 2 \
  ~/Genome-Analysis/data/trimmed_data/R1_paired.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R2_paired.fastq.gz
