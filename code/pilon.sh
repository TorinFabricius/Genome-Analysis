#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=30G
#SBATCH -t 24:00:00
#SBATCH -J pilon
#SBATCH --output=%x.%j.out

module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0
module load Pilon/1.24-Java-17

cd ~/Genome-Analysis/analyses/03_polishing
cp ~/Genome-Analysis/analyses/02_assembly_2/assembly.fasta .

bwa index assembly.fasta

bwa mem -t 2 assembly.fasta \
  ~/Genome-Analysis/data/trimmed_data/R1_paired.fastq.gz \
  ~/Genome-Analysis/data/trimmed_data/R2_paired.fastq.gz | \
  samtools sort -@ 2 -o illumina_vs_assembly.sorted.bam

samtools index illumina_vs_assembly.sorted.bam

pilon \
  --genome assembly.fasta \
  --frags illumina_vs_assembly.sorted.bam \
  --output pilon_polished \
  --threads 2
