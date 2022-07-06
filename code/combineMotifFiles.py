from utils.pyUtils import config, out_basedir
import os
import pandas as pd
import re


motifDir = out_basedir + '/motifbreakR/split_files/'
motifFiles = [f for f in os.listdir(motifDir) if re.match(r'ctcf', f)]

disruptedCTCF = []
for f in motifFiles:
    df = pd.read_csv(os.path.join(motifDir,f),sep='\t',index_col=False)
    disruptedCTCF.append(df)

finalCTCF = pd.concat(disruptedCTCF, ignore_index=True)

outDir = out_basedir + '/motifbreakR/motifbreakR_out/'
os.makedirs(outDir, exist_ok=True) 

finalCTCF.to_csv(os.path.join(outDir,'ctcf_disrupted_motifbreakR.txt'), sep='\t',header=True,index=False)
