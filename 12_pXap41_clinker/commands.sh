conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

rm *.gbk
python3 extract_gbk.py CCC18705.1 CCC18687.1
python3 extract_gbk.py CCC18668.1 CCC18687.1
python3 extract_gbk.py CCC18662.1 CCC18666.1

rm *.html
clinker -p 01.html pXap41.CCC18705.1_to_CCC18687.1.gbk JAUALM020000038.1.gb
clinker -p 02.html pXap41.CCC18668.1_to_CCC18687.1.gbk JAUALM020000051.1.gb JAUALM020000056.1.gb
clinker -p 03.html pXap41.CCC18662.1_to_CCC18666.1.gbk JAUALM020000075.1.gb
