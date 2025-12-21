conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

rm *.gbk
python3 extract_gbk.py WP_100101058.1 WP_152667176.1
python3 extract_gbk.py WP_011345768.1 WP_011345711.1
python3 extract_gbk.py MFB9033557.1 MFB9033484.1
python3 extract_gbk.py MFB9033574.1 MFB9033634.1
python3 extract_gbk.py WP_011345622.1 WP_049756400.1

rm *.html
clinker -p 01.html pXap41.gb JAUALM020000038.1.gb
clinker -p 02.html pXap41.gb JAUALM020000051.1.gb
clinker -p 03.html pXap41.gb JAUALM020000056.1.gb
clinker -p 04.html pXap41.gb JAUALM020000065.1.gb
clinker -p 05.html pXap41.gb JAUALM020000075.1.gb

