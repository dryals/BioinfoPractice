#!/bin/bash

# FILENAME: array.sh

#SBATCH -A bharpur
#SBATCH --nodes=1 
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --job-name par_array

#SBATCH --output=/home/dryals/ryals/practice/parallel/outputs/dump.out
#SBATCH --error=/home/dryals/ryals/practice/parallel/outputs/dump.out

#Dylan Ryals 24 MAR 2023
#last edit   

#launch with sbatch --array=1-16 array.sh

#set variables for use within the job
    #save the array number is a friendly variable like 'n'
    n=$( echo $SLURM_ARRAY_TASK_ID )
    
    #I'll use this log to keep track of the progress of each task
    log=/home/dryals/ryals/practice/parallel/outputs/log.out
    #...and this output to report back to the main
    mainout=/home/dryals/ryals/practice/parallel/outputs/main.out

module load bioinfo bcftools r
    #output from things like loading modules will be written to dump.out, so it won't clutter up any other output

cd scratch

#make a directory for each chromosome
mkdir -p chr${n}
cd chr${n}

echo "trash output $n"
    #this is just written to the dump.out output. This will help for debugging, but we don't need it in the final log

#do a calculation
echo "      process $n reporting..." >> $mainout

#example computation, filters for the nth chromosome
bcftools view /scratch/bell/dryals/pipeline/reference-filter.vcf.gz -r $n -Ob -o chr${n}refs.bcf.gz
#output allele frequencies
bcftools view chr${n}refs.bcf.gz -Ou | bcftools +fill-tags | bcftools query -f'%CHROM\t%POS\t%AF\n' -o chr${n}.frq

#report finished
echo "FINISHED CHR $n" >> $log



