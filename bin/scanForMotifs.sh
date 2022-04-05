## script that calls HOMER findMotifs.pl to find motifs 
## within a list of fasta files


helpFunction(){
   echo ""
   echo "Usage: $0 -f fasta_dir"
   echo -e "\t-f path to input dir containing fasta files"
   exit 1 # Exit script after printing help
}

while getopts "f:" flag; do
    case "${flag}" in
        f) fasta_dir="$OPTARG";;
        ?) helpFunction ;; # Print helpFunction
    esac
done


homer_dir="${project_dir}homer/motifs" ## directory where homer stores all motif files
output_dir="${project_dir}/out/homer_out/"

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir";
fi

## declare array of all motifs you want to find
declare -a motifs=("ctcf.motif")

for f in  "$fasta_dir"/*.fa; do
    for m in "${motifs[@]}"; do
    basename_motif="$(echo $(basename $m)| cut -f 1 -d '.')"
    allele="$(echo $(basename $f)| cut -f 1 -d '_')"
    findMotifs.pl $f fasta $output_dir -find "$homer_dir/$m" > "$output_dir/${basename_motif}_${allele}_sequences.txt" -norevopp -fdr
    rm $output_dir/*.tmp 
    rm $output_dir/motifFindingParameters.txt
    done
done

