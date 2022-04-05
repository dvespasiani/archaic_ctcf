#!/bin/bash

source /usr/local/module/spartan_new.sh
module load web_proxy
module load gcc/8.3.0 openmpi/3.1.4
module load r/4.0.0  

project_dir="/data/projects/punim0586/dvespasiani/archaic_ctcf"
output_dir="$project_dir/out/motifbreakR"
script_dir="$project_dir/code"
input_file=$(ls $project_dir/data/*motifbreak*)

if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir" ;
fi

R --vanilla -f "$script_dir/motifbreak_analysis.R" --args input=$input_file output=$output_dir/ctcf_motifbreak_out.txt



