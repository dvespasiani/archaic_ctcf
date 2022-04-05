from utils.pyUtils import config, grange_colnames
import os
import pandas as pd
import re

## list snps files
snp_dir = config['snps_dir']
snp_files = [f for f in os.listdir(snp_dir) if re.match(r'SNPs', f)]

## read files into a single dataframe, keep only first fields, i.e. grange coordinates and ref/alt alleles 
## then remove duplicates and save the new file into the data/ dir
snps = []
for f in snp_files:
    df = pd.read_csv(os.path.join(snp_dir,f),sep='\t',index_col=False)
    df_subset = df.iloc[:, 0:5]
    snps.append(df_subset)

final_set_snps = pd.concat(snps, ignore_index=True)
final_set_snps.drop_duplicates(keep='last',inplace=True)

final_set_snps.columns = grange_colnames + ['ref','alt']
final_set_snps['snpID'] = final_set_snps[final_set_snps.columns].astype(str).apply('_'.join, axis=1)

final_set_snps.to_csv(os.path.join(config['project_dir'],'data/','archaic_nonarchaic_snps_png.bed.gz'), sep='\t',compression='gzip',header=True,index=False)

