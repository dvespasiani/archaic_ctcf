## parse config yaml
library(yaml)
yaml_config <- read_yaml('./config/projectConfig.yaml')

## directories 
base_dir <- yaml_config$base_dir
project_dir <- yaml_config$project_dir
snps_dir <- yaml_config$snps_dir
out_basedir <- paste(project_dir,'out',sep='')
data_basedir <- paste(project_dir,'data',sep='')

## variables
genome <- 'hg19'
grange_colnames <- c('seqnames','start','end')


