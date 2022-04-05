
# Project overview
This repo is used to:
1. Identify all the archaic/non-archaic SNPs that might lie within CTCF binding sites
2. Evaluate whether they might disrupt the CTCF binding sites

SNPs are those obtained from [Jacobs *et al* 2019](10.1016/j.cell.2019.02.035)

------------
## Content of this repo


------------
## Workflow


To set up an interactive session:
1. change the `~` in `eval "$(python3 ~/utils/parse_yaml.py -yf $yaml)"` in the `run_interactive_sess.sh` with the path you prefer. I have it on my home dir
2. execute the `run_interactive_sess.sh` as `run_interactive_sess.sh -y /path/to/yaml/file`
3. load modules as `eval "$(cat $modules_configfile )" `

Now everything should be ready  

run script from command line as 
Rscript ./bin/getFasta.R motif_extension
e.g., Rscript ./bin/getFasta.R 20

### Instal HOMER
Make sure you have HOMER installed in your `$project_dir/` otherwise run `./bin/installHomer.sh`. The script will follow HOMER installation from the [website](http://homer.ucsd.edu/homer/introduction/install.html) and 

### Identification SNPs occurring within CTCF binding sites
3 different analyses:
1. HOMER 
2. FIMO 
3. MotifbreakR

For FIMO I have downloaded all the 5 CTCF motifs (in meme format) from [Jaspar2022](https://jaspar.genereg.net/search?q=CTCF&collection=CORE&tax_group=vertebrates&tax_id=all&type=all&class=all&family=all&version=all)
and then combined them into a single file 

Choose the one you prefer, or the consensus one or....
