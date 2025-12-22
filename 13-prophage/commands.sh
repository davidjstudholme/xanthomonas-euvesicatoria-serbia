conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

### Clean up any old files
rm *.gbk

### Get subsequences for MAG GenBank:OR222649 
python3 extract_gbk.py MFB8965988.1 MFB8966040.1
python3 extract_gbk.py MFB9032441.1 MFB9032493.1
python3 extract_gbk.py MFB9000309.1 MFB9000361.1
python3 extract_gbk.py AOY68629.1 AOY68680.1


### Get subsequences for phiXv2
python3 extract_gbk.py AOY65994.1 AOY65973.1



### Clean up any old files
rm *.html

### Run Clinker for MAG GenBank:OR222649            
clinker -p MSP0281.html MSP0281.gb X13.JAUALM020000013.1.MFB9032441.1_to_MFB9032493.1.gbk X31.JAUALK020000013.1.MFB9000309.1_to_MFB9000361.1.gbk X22.JAUALL020000004.1.MFB8965988.1_to_MFB8966040.1.gbk 85-10.AOY68629.1_to_AOY68680.1.gbk

### Run Clinker for phiXv2    
clinker -p phiXv2.html phiXv2.gb X31.JAUALK020000031.1.gb X13.JAUALM020000040.1.gb X22.JAUALL020000029.1.gb 85-10.AOY65994.1_to_AOY65973.1.gbk


