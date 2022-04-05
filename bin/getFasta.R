## use this script to generate a fasta file containing the sequence surrounding each SNP
## remember to change the genome assembly of interest in rUtils.R, here I am using hg19
library(dplyr)
library(data.table)
library(magrittr)
library(GenomicRanges)

options(width=150)
source('./utils/rUtils.R')

args = commandArgs(trailingOnly=TRUE)

motif_extension = as.numeric(args[1])
output = paste(out_basedir,'/fasta_files',sep='')

dir.create(file.path(output), showWarnings = FALSE)

if (genome =='hg38'){ 
    ## genome is specified in rUtils.R
    library(BSgenome.Hsapiens.UCSC.hg38)
    species_bsgenome <- Hsapiens
    }else{
    library(BSgenome.Hsapiens.UCSC.hg19)
    species_bsgenome <- Hsapiens
}

## get input SNPs
snps_file <- list.files(data_basedir,recursive=T,full.names=T,pattern='*.bed')

print(paste('Reading this file', snps_file),sep= ' ')

snps <- fread(snps_file,header=T)

## get DNA sequences
print(paste('Extracting', motif_extension,'bp of sequence surrounding SNPs'),sep= ' ')

snp_dnaseq <-copy(snps)[,sequence:=as.character(getSeq(species_bsgenome, seqnames,start-motif_extension, start+motif_extension))]

ref_dnaseq <- DNAStringSet(copy(snp_dnaseq$sequence))
names(ref_dnaseq) = snp_dnaseq$snpID

alt_dnaseq <- copy(snp_dnaseq)
substr(alt_dnaseq$sequence, motif_extension+1,motif_extension+1)=alt_dnaseq$alt
alt_dnaseq <- DNAStringSet(alt_dnaseq$sequence)
names(alt_dnaseq) = snp_dnaseq$snpID

print(paste('Exporting ref and alt DNA sequences to',output,sep=' '))

ref_filenames = paste(output,'/','ref_sequences.fa',sep='')
alt_filenames = paste(output,'/','alt_sequences.fa',sep='')

writeXStringSet(ref_dnaseq, file = ref_filenames,append=FALSE,compress=FALSE, compression_level=NA, format="fasta")
writeXStringSet(alt_dnaseq, file = alt_filenames,append=FALSE,compress=FALSE, compression_level=NA, format="fasta")

print('Done')

