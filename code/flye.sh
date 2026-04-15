#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 48:00:00
#SBATCH --mem=60G
#SBATCH -J flye
#SBATCH --output=%x.%j.out

module load Flye/2.9.6-GCC-13.3.0

mkdir -p ~/Genome-Analysis/analyses/02_assembly

flye \
  --nano-raw ~/Genome-Analysis/data/raw_data/chr3_clean_nanopore.fq.gz \
  --out-dir ~/Genome-Analysis/analyses/02_assembly \
  --genome-size 50m \
  --threads 2
