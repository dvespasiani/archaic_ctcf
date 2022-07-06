
# Project overview 
This repo is used to:
1. Identify all the archaic/non-archaic SNPs that might lie within CTCF binding sites
2. Evaluate whether they might disrupt the CTCF binding sites

SNPs are those obtained from [Jacobs *et al* 2019](10.1016/j.cell.2019.02.035)
------------
## Set up 

To prepare the data execute the `code/combineSNPFiles.py` interactively. This script is dependent on the type of bed files analysed here so there is no much room for customisation. The script combines the different SNP files and return a bed file into the `data/` dir. <br/>

### Instal HOMER
Make sure you have HOMER installed in your `$project_dir/` otherwise run `./bin/installHomer.sh`. The script will follow HOMER installation from the [HOMER website](http://homer.ucsd.edu/homer/introduction/install.html) 

## Launch interactive session (Spartan)
To set up an interactive session:
1. change the `~` in `eval "$(python3 ~/utils/parse_yaml.py -yf $yaml)"` in the `run_interactive_sess.sh` with the path you prefer. I have it on my home dir
2. execute the `run_interactive_sess.sh` as `run_interactive_sess.sh -y /path/to/yaml/file` <br/>
e.g., `run_interactive_sess.sh -y /data/projects/punim0586/dvespasiani/archaic_ctcf/config/projectConfig.yaml`

3. load modules as `eval "$(cat $modules_configfile)" `

Now everything should be ready.

------------
## Retrieving DNA sequence surrounding SNPs

To retrieve the DNA sequences surrounding each SNP of interest run the `./bin/getFasta.R` script from the command line as: `Rscript ./bin/getFasta.R motif_extension`, e.g., `Rscript ./bin/getFasta.R 20`. <br/>
The script will return a fasta file in the `out/fasta_files/` dir containing all the DNA sequences surrounding the SNP of interest. <br/>
The `motif_extension` flag accepts and integer and specifies the length of the DNA sequence around each side of your SNPs you want to retrieve. I have ran my analyses with a `motif_extension = 20`, which means the final DNA sequence will be of 40 nt in length. 

------------
## Identifying SNPs occurring within CTCF binding sites
To identify which SNP might fall (and potentially disrupt) CTCF binding sites I did 3 different analyses:

1. [HOMER](http://homer.ucsd.edu/homer/index.html)  <br/>
HOMER will find if any of your DNA sequence might contain CTCF motifs. <br/>
To use HOMER run the `./bin/scanForMotifs.sh` as `./bin/scanForMotifs.sh -f ./path/to/fasta_file/` file. This will call the HOMER's `findMotifs.pl` command (I've used the default settings- check the script and modify if necessary) on each file contained in your specified `fasta_file` dir. <br/>
The script will then return all the output files (one per input file) in the `/out/homer_out/` dir. <br/>
Importantly, the `declare -a motifs=("ctcf.motif")` command in line 28 of the `./bin/scanForMotifs.sh` script specifies the list of motifs you want to fish out from each of your files. These all come from the HOMER's built-in set of `.motif` files that you can find the complete list under the `motifs/` dir following the `./path/where/homer/is/installed/`. You can change it as you prefer.

2. [FIMO](https://meme-suite.org/meme/doc/fimo.html) <br/>
To identify CTCF motifs from the list of DNA sequences using FIMO, I have downloaded all the 5 CTCF motifs (in meme format) from [Jaspar2022](https://jaspar.genereg.net/search?q=CTCF&collection=CORE&tax_group=vertebrates&tax_id=all&type=all&class=all&family=all&version=all) and combined them into a single file located at `data/jaspar2022_all5_ctcf_pwm.meme`. <br/>
To run FIMO simply run `./bin/runFimo.sh` as it is. For each file in the `fasta_file` dir, the script will run the fimo command (with default settings- change them if necessary) and return you the results in the `out/fimo_out` dir.

**Note that FIMO and HOMER do not directly quantify the SNP impact on DNA motifs. To do so you'd have to compare the motif scores between the sequences containing the ref vs sequences containing the alt allele**

3. [MotifbreakR](https://bioconductor.org/packages/release/bioc/vignettes/motifbreakR/inst/doc/motifbreakR-vignette.html) <br/>

To analyse the impact on CTCF binding sites using motifbreakR you will require a bit of extra work as the SNP bed files are generally large. <br/>
First prepare the data to motifbreakR require input format by running the `./bin/prepareMotifbreakInput.R` script as: `Rscript ./bin/prepareMotifbreakInput.R`. This will return an output file at the `data/motifbreak_files/` dir. <br/>
Because motifbreakR takes long to run (especially for big files), you then need to split the motifbreakR input file into subfiles and create a job array to be executed in parallel on the cluster. For this, run the `./bin/createJobArray.sh` script as it is (I will update this in case I will make the script more customisable). This script will split the file (see line 51) and return the `./code/motifbreak_jobArray.sh` script where each line reports the same command but with different I/O (necessary to launch the job array). <br/>
Then launch the job array as: `sbatch ./utils/submitJobArray.sh`. <br/>

Note that if you want to change how motifbreakR searches and quantifies disruption on DNA binding sites you need to customise the motifbreak function on line 64 of `./code/motifbreakAnalysis.R` <p>

Either way, choose the method you prefer to identify CTCF binding sites, or even the U of all 3.
