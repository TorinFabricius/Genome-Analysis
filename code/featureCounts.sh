#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH -t 01:00:00
#SBATCH -J featureCounts
#SBATCH --output=%x.%j.out

module load Subread/2.1.1-GCC-13.3.0

featureCounts \
  -T 2 \
  -p \
  -t exon \
  -g gene_id \
  -a /home/torin/Genome-Analysis/analyses/05_annotation/braker3/braker.gtf \
  -o /home/torin/Genome-Analysis/analyses/06_rna_analysis/counts/gene_counts_all_samples.txt \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Control_1.sorted.bam \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Control_2.sorted.bam \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Control_3.sorted.bam \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Heat_treated_42_12h_1.sorted.bam \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Heat_treated_42_12h_2.sorted.bam \
  /home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/Heat_treated_42_12h_3.sorted.bam
