#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc
#SBATCH --output=%x.%j.out

module load FastQC/0.12.1-Java-17

mkdir -p ~/Genome-Analysis/analyses/01_preprocessing

fastqc -o ~/Genome-Analysis/analyses/01_preprocessing -t 2 ~/Genome-Analysis/data/raw_data/chr3_clean_nanopore.fq.gz ~/Genome-Analysis/data/raw_data/chr3_illumina_R1.fastq.gz ~/Genome-Analysis/data/raw_data/chr3_illumina_R2.fastq.gz
