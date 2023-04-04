#!/bin/bash

# FILENAME: example.sh

#SBATCH -A bharpur
#SBATCH --nodes=1 
#SBATCH --ntasks=1
#SBATCH --time=0-00:10:00
#SBATCH --job-name example

#SBATCH --output=./example.out
#SBATCH --error=./example.out

#Dylan Ryals 16 FEB 2023

#this is an example SLURM submission script to show some useful commands and techniques

#you can submit it by running: sbatch example.sh
#view the output with: less example.out

#_______________________________________________

#the echo command will output whatever you give it into stdout (standard output) in a slurm submission script, #SBATCH --output= directs the stdout to a file of your choosing, here ./example.output
echo "Once Upon a Time..."

#echo will add a newline '\n' after each command
echo "" #just adds a blank line

#if you don't want a newline, use echo -n 
echo -n "this text will appear... "
echo "on the same line as this text"

#bash has variables! these are very useful. There are many ways to create them, here's one 
newvar="a lovely day"
echo "(no output yet...)"
#anytime you use the variable, it will be interpreted as the value you assign to it.  
echo $newvar #prints the variable to stdout

#bash has loops! this is essential in a lot of tasks. The setup is pretty esoteric, but looks like this:
for i in {1..10} #a new variable $i will take the values 1 through 10
do
    echo -n "$i " #prints the numbers 1 - 10 to stdout
done
echo "" #newline

#loops can do anything you want! let's create a bunch of dumb files
echo "creating dumb files"
for fnum in {1..10} #a new variable $i will take the values 1 through 10
do
    echo "the show must go on" > dumbfile${fnum}.txt 
    # the arrow > directs echo somewhere else, here into a file we just created
    # use brackets {} to incorporate a variable in a file name 
done

#use ls command to see all these new files 
ls -m
echo ""

#open one 
cat dumbfile3.txt

#i want to remove these files! the rm command is useful
echo "removing..."
rm dumb*.txt #the * character is a wildcard! it stands for any combination of other characters
#here, it matches all the filenames we just created and (hopefully) no others
#rm will remove things forever, no getting them back.

#be VERY CAREFUL any time combining rm with the * character, as you can do massive damage in the blink of an eye. 

ls -m #files are gone

echo "The End"
