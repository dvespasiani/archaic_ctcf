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
source /usr/local/module/spartan_new.sh
module load web_proxy
module load gcc/8.3.0 openmpi/3.1.4
module load r/4.0.0  

## run the n line corresponding to the nth slurm job ID
command=`head -n $SLURM_ARRAY_TASK_ID /data/projects/punim0586/dvespasiani/archaic_ctcf/code/motifbreak_jobArray.sh | tail -n 1`
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo $command
eval $command