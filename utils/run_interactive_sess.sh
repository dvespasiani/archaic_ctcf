helpFunction(){
   echo ""
   echo "Usage: $0 -y yaml"
   echo -e "\t-y path to clusterConfig.yaml"
   exit 1 # Exit script after printing help
}

while getopts "y:" flag; do
    case "${flag}" in
        y) yaml="$OPTARG";;
        ?) helpFunction ;; # Print helpFunction
    esac
done


echo
echo "Setting env vars from the config file..."
echo "-------------------------------------"
eval "$(python3 ~/utils/parse_yaml.py -yf $yaml)"
# echo
# env | egrep "project=|account=|nstasks=|threads=|cpus_per_task=|time=|partition=|project_dir=|modules_configfile="
# echo
# echo
echo 
echo "Redirecting to project directory: $project_dir"
echo 
cd $project_dir

echo "After this step remember to load modules as eval "$(cat $modules_configfile)""
echo

cmd="sinteractive --account=$account --ntasks=$ntasks \
--threads=$threads --cpus-per-task=$cpus_per_task \
--mem=$mem --time=$time --partition=$partition"
echo $cmd
$cmd

