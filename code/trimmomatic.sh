#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J trim
#SBATCH --output=%x.%j.out

module load Trimmomatic

mkdir -p ~/Genome-Analysis/data/trimmed_data

trimmomatic PE \
  -threads 2 \
  ~/Genome-Analysis/data/raw_data/chr3_illumina_R1.fastq.gz \
  ~/Genome-Analysis/data/raw_data/chr3_illumina_R2.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R1_paired.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R1_unpaired.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R2_paired.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R2_unpaired.fastq.gz \
  ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
