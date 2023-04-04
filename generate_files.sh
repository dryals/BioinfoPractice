#!/bin/bash

# FILENAME: generate_files.sh

#SBATCH -A bharpur
#SBATCH --nodes=1 
#SBATCH --ntasks=4
#SBATCH --time=0-02:00:00
#SBATCH --job-name generate_files

#SBATCH --output=./generate.out
#SBATCH --error=./generate.out

#Dylan Ryals 16 FEB 2023

module load bioinfo vcftools bcftools

#some files I'm working on 
cd /scratch/bell/dryals/pipeline

#this pulls a subset of samples (-S smallsamples.txt) and just chromosome 3 (-r 3) from the large popgen file admix.vcfgz , and saves it to a file small.vcf.gz in my practice directory. 
#bcftools uses multithreading only when zipping files, which I need to do, so I ask SLURM for --ntasks=4 in the header and include --threads 4 in the bcftools call to let it know I have 4 cores. 
bcftools view -r 3 -S smallsamples.txt admix.vcf.gz --min-ac 1 --threads 4 -Oz -o /home/dryals/ryals/practice/small.vcf.gz
