conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

rm *.gbk
python3 extract_gbk.py CCC18687.1 CCC18705.1
python3 extract_gbk.py MFB9033919.1 MFB9033938.1

python3 extract_gbk.py 
python3 extract_gbk.py 

python3 extract_gbk.py 
python3 extract_gbk.py


python3 extract_gbk.py
python3 extract_gbk.py

python3 extract_gbk.py
python3 extract_gbk.py


rm *.html
clinker -p 01.html pXap41.CCC18687.1_to_CCC18705.1.gbk JAUALM020000038.1.MFB9033919.1_to_MFB9033938.1.gbk
clinker -p 02.html pXap41.gb JAUALM020000051.1.gb
clinker -p 03.html pXap41.gb JAUALM020000056.1.gb
clinker -p 04.html pXap41.gb JAUALM020000065.1.gb
clinker -p 05.html pXap41.gb JAUALM020000075.1.gb

