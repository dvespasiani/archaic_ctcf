## script to convert snp bed file into motifbreakR acceptable input
library(GenomicRanges)
library(dplyr)
library(data.table)
library(magrittr)

options(scipen=999)
source('./utils/rUtils.R')

snps_file <- list.files(data_basedir,recursive=T,full.names=T,pattern='*.bed')

snps <- fread(snps_file,sep='\t',header=T)

motifbreak_format <- copy(snps)[
    ,Start:= start-1
    ][
      ,End:=start
      ][
        ,name:=paste(seqnames,End,ref,alt,sep=':')
        ][
          ,c('seqnames','Start','End','name')
]

## write files 
outfile = paste0(project_dir,'data/motifbreak_files/','motifbreak_input.txt.gz',sep='')
fwrite(motifbreak_format, file = outfile,col.names = F, row.names = F, sep = "\t", quote = F)

