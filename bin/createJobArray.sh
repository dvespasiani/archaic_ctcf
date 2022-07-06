
project_dir="/data/projects/punim0586/dvespasiani/archaic_ctcf"
data_dir="$project_dir/data"
script_dir="$project_dir/code"


helpFunction(){
   echo ""
   echo "
   Use this script to create a file under $script_dir directory \n
   and the containing the job array commands
   "
   echo "Usage: $0 -i inputfile -o outdir -a arrayfile"
   echo -e "\t-i the name of the input file to be split. You need to specify its path relative to $data_dir"
   echo -e "\t-o path to the output directory where you want to store all subfiles"
   echo -e "\t-a name of your jobArray.sh file"
   exit 1 # Exit script after printing help
}

while getopts "i:o:a:h:" flag; do
    case "${flag}" in
        i) inputfile="$OPTARG";;
        o) outdir="$OPTARG";;
        o) arrayfile="$OPTARG";;
        h) helpFunction ;; # Print helpFunction
    esac
done

motifbreak_indir="$project_dir/data/motifbreak_files"
motifbreak_outdir="$project_dir/out/motifbreakR/split_files"

if [ ! -d "$motifbreak_indir" ]; then
  mkdir -p "$motifbreak_indir" ;
fi

if [ ! -d "$motifbreak_outdir" ]; then
  mkdir -p "$motifbreak_outdir" ;
fi

if [[ $inputfile =~ \.gz$ ]]; then
    echo "\n Unzipping file \n"
    gunzip $inputfile ; else 
    echo "\n File is already unzipped, moving onto splitting \n"
fi

# gunzip motifbreak_input.txt.gz  
# mv motifbreak_input.txt $motifbreak_indir
# cd $motifbreak_indir
# split -l 350000 --numeric-suffixes motifbreak_input.txt motifbreak_split
filebasename=$(basename $file .txt)
split -l 350000 --numeric-suffixes $inputfile ${filebasename}_split

input_files=$(ls $motifbreak_indir/*split*)

for f in $input_files; do
mv $f ${f}.txt
done

# touch ${script_dir}/motifbreak_jobArray.sh
# chmod +x ${script_dir}/motifbreak_jobArray.sh
# for file in $input_files; do
# fileName=$(basename $file .txt)
# arrayLine="R --vanilla -f "$script_dir/motifbreak_analysis.R" --args input=$file output=$motifbreak_outdir/ctcf_output_${fileName}.txt" 
# echo $arrayLine >> ${script_dir}/motifbreak_jobArray.sh
# done

touch ${script_dir}/${arrayfile}
chmod +x ${script_dir}/${arrayfile}

for file in $input_files; do
fileName=$(basename $file .txt)
arrayLine="R --vanilla -f "$script_dir/motifbreak_analysis.R" --args input=$file output=$motifbreak_outdir/ctcf_output_${fileName}.txt" 
echo $arrayLine >> ${script_dir}/${arrayfile}
done
