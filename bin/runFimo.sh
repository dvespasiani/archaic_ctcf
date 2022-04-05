## load modules
source /usr/local/module/spartan_new.sh
module load web_proxy
module load gcc/8.3.0 openmpi/3.1.4
module load meme/5.1.1-python-3.7.4


project_dir="/data/projects/punim0586/dvespasiani/archaic_ctcf/"
fasta_dir="${project_dir}out/fasta_files"
output_dir="${project_dir}out/fimo_out"
jaspar2022_ctcf="${project_dir}data/jaspar2022_all5_ctcf_pwm.meme"

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir";
fi

for f in "$fasta_dir"/* ; do
    allele="$(echo $(basename $f)| cut -f 1 -d '_')"
    fimo_out="$output_dir/ctcf_${allele}_out"
    echo "Running fimo on $(basename $f) using $(basename $jaspar2022_ctcf) motifs"
    fimo --bfile --motif-- --thresh 0.0001 --o "$fimo_out" "$jaspar2022_ctcf" "$f"
done
