#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=20G
#SBATCH -t 06:00:00
#SBATCH -J hisat2_map
#SBATCH --output=%x.%j.out

module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22.1-GCC-13.3.0

mkdir -p ~/Genome-Analysis/analyses/06_rna_analysis/mapping
cd ~/Genome-Analysis/analyses/06_rna_analysis/mapping

hisat2 \
  -x /home/torin/Genome-Analysis/analyses/06_rna_analysis/index/genome_index \
  -1 /home/torin/Genome-Analysis/data/raw_data/rna_selected/Control_1_f1.fq.gz,/home/torin/Genome-Analysis/data/raw_data/rna_selected/Heat_treated_42_12h_1_f1.fq.gz \
  -2 /home/torin/Genome-Analysis/data/raw_data/rna_selected/Control_1_r2.fq.gz,/home/torin/Genome-Analysis/data/raw_data/rna_selected/Heat_treated_42_12h_1_r2.fq.gz \
  -p 2 \
  -S combined.sam

samtools view -bS combined.sam | samtools sort -o combined.sorted.bam
samtools index combined.sorted.bam

rm combined.sam
