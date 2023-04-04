#!/bin/bash

# FILENAME: main.sh

#SBATCH -A bharpur
#SBATCH --nodes=1 
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --job-name par_main

#SBATCH --output=/home/dryals/ryals/practice/parallel/outputs/main.out
#SBATCH --error=/home/dryals/ryals/practice/parallel/outputs/main.out

#Dylan Ryals 24 MAR 2023

#i like to print the date/time when a script starts so I can work out how long it took to run
date

echo "Setting up..."

module load bioinfo

sleep 10

#make a symbollic link to naviate to scratch dir
ln -s /scratch/bell/dryals/parallel scratch

echo "launching array..."
    #cleanup the log file (so it doesn't just keep getting bigger
    echo -n "" > outputs/log.out
    #launch the array
    sbatch --array=1-16 array.sh

#wait for all jobs to complete 
echo "waiting for results..."
    while [ $(grep "FINISHED" outputs/log.out | wc -l | awk '{print $1}') -lt 16 ] #wait for all 16 to finish
    do
        sleep 5 #wait between each check
    done
echo "All jobs finished"

echo "Compiling results..."
    cd scratch
    cat chr*/chr*.frq | sort -k3 -gr > genome.frq
    
echo "DONE"

date
