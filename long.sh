#!/bin/bash

# FILENAME: long.sh

#SBATCH -A bharpur
#SBATCH --nodes=1 
#SBATCH --ntasks=1
#SBATCH --time=0-00:05:00
#SBATCH --job-name long

#SBATCH --output=./long.out
#SBATCH --error=./long.out

#Dylan Ryals 16 FEB 2023

#this will take a long time to run

echo "starting ..."

for i in {1..60}
do
    echo "this is line number $i"
    sleep 5 #wait ten seconds
done

#

