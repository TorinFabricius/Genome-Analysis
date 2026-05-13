#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=20G
#SBATCH -t 18:00:00
#SBATCH -J eggnog
#SBATCH --output=%x.%j.out

module load eggnog-mapper/2.1.13-gfbf-2024a

mkdir -p /home/torin/Genome-Analysis/analyses/07_functional_annotation

emapper.py \
  -i /home/torin/Genome-Analysis/analyses/05_annotation/braker3/braker.aa \
  --itype proteins \
  -o eggnog_braker \
  --output_dir /home/torin/Genome-Analysis/analyses/07_functional_annotation \
  --data_dir /sw/data/uppnex/eggNOG/5.0/rackham/ \
  --cpu 2
