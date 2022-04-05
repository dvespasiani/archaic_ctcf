import yaml
import os

## path config file
yaml_file = '/data/projects/punim0586/dvespasiani/archaic_ctcf/config/projectConfig.yaml'

## function to read config file
def read_config(file):
    with open(file, 'r') as f:
        c = yaml.safe_load(f)
    return(c)

config = read_config(yaml_file)

out_basedir = os.path.join(config['project_dir'],'out')

grange_colnames = ['seqnames','start','end']
