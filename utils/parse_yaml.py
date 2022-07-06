import argparse
import os
import yaml

def config_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-yf', '--yaml_file', type=str, default='/data/projects/punim0586/dvespasiani/archaic_ctcf/config/projectConfig.yaml', help='Path to yaml config file')
    args = parser.parse_args()    
    return args


config = config_arguments()

with open(config.yaml_file, 'r') as file:
    yamlconfig = yaml.safe_load(file)

## loop though items
for k, v in yamlconfig.items():    
    print('export {}="{}"'.format(k,v))
    