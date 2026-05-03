#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=30G
#SBATCH -t 20:00:00
#SBATCH -J braker3
#SBATCH --output=%x.%j.out

# Paths
GENOME=/home/torin/Genome-Analysis/analyses/04_masking/repeatmasker/pilon_polished.fasta.masked
BAM=/home/torin/Genome-Analysis/analyses/06_rna_analysis/mapping/combined.sorted.bam
WORKDIR=/home/torin/Genome-Analysis/analyses/05_annotation/braker3
BRAKER_SIF=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif
AUGUSTUS_CONFIG=/home/torin/bin/augustus_config

mkdir -p $WORKDIR
mkdir -p $AUGUSTUS_CONFIG

if [ ! -f $AUGUSTUS_CONFIG/species/generic/generic_parameters.cfg ]; then
  singularity exec \
    -B /home/torin:/home/torin \
    $BRAKER_SIF \
    cp -r /opt/Augustus/config/. $AUGUSTUS_CONFIG/
fi

singularity exec \
  -B /home/torin:/home/torin \
  -B /proj/uppmax2026-1-61:/proj/uppmax2026-1-61 \
  $BRAKER_SIF \
  braker.pl \
    --genome=$GENOME \
    --bam=$BAM \
    --softmasking \
    --species=niphotrichum_japonicum_chr3 \
    --threads=2 \
    --workingdir=$WORKDIR \
    --AUGUSTUS_CONFIG_PATH=$AUGUSTUS_CONFIG
