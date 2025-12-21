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
clinker -p 01.pXCV183.versus.JAUALM020000025.clinker.html JAUALM020000025.1.MFB9033557.1_to_MFB9033484.1.gbk pXCV183.WP_100101058.1_to_WP_152667176.1.gbk
clinker -p 02.pXCV183.versus.JAUALM020000026.clinker.html JAUALM020000026.1.MFB9033574.1_to_MFB9033634.1.gbk pXCV183.WP_011345768.1_to_WP_011345711.1.gbk
clinker -p 03.pXCV183.versus.JAUALM020000047.clinker.html JAUALM020000047.1.gb pXCV183.WP_011345622.1_to_WP_049756400.1.gbk

