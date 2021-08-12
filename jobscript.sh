#!/bin/bash -l

#$ -l mem=4G
#$ -pe smp 32

#$ -cwd
#$ -l h_rt=01:30:00

#$ -l tmpfs=2G

set -e

module load julia/1.6.2

THR=$OMP_NUM_THREADS
OWD=$(pwd)

cp -R environment $TMPDIR/environment
cp bench.jl $TMPDIR

cd $TMPDIR
for a in $(seq 1 $THR)
do
  OMP_NUM_THREADS=$a julia bench.jl
done

cp *.txt $OWD

