#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=20G
#SBATCH -t 24:00:00
#SBATCH -J hisat2_map
#SBATCH --output=%x.%j.out

module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22.1-GCC-13.3.0

RNA_DIR=/home/torin/Genome-Analysis/data/raw_data/rna
INDEX=/home/torin/Genome-Analysis/analyses/06_rna_analysis/index/genome_index
OUTDIR=/home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping

mkdir -p $OUTDIR
cd $OUTDIR

for R1 in ${RNA_DIR}/*_f1.fq.gz
do
    SAMPLE=$(basename $R1 _f1.fq.gz)
    R2=${RNA_DIR}/${SAMPLE}_r2.fq.gz

    echo "Mapping sample: $SAMPLE"
    echo "R1: $R1"
    echo "R2: $R2"

    hisat2 \
      -x $INDEX \
      -1 $R1 \
      -2 $R2 \
      -p 2 \
      -S ${SAMPLE}.sam

    samtools view -bS ${SAMPLE}.sam | samtools sort -o ${SAMPLE}.sorted.bam
    samtools index ${SAMPLE}.sorted.bam

    rm ${SAMPLE}.sam
done
