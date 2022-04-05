#!/bin/bash

#SBATCH --partition=mig
#SBATCH --nodes=1
#SBATCH --job-name="motifbreak_ctcf"
#SBATCH --account="punim0586"
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --time=10-23:00:00
#SBATCH --mail-user=dvespasiani@student.unimelb.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --output=./slurm/motifbreak_slurm.out

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

## launch script
/data/projects/punim0586/dvespasiani/archaic_ctcf/bin/runMotifbreak.sh
