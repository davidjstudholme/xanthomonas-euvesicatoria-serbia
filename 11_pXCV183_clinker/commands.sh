
conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

python3 extract_gbk.py WP_100101058.1 WP_152667176.1

python3 extract_gbk.py WP_011345768.1 WP_011345576.1

clinker -p pXCV183.versus.JAUALM020000025.clinker.html JAUALM020000025.1.gb pXCV183.WP_011345768.1_to_WP_011345576.1.gbk
clinker -p pXCV183.versus.JAUALM020000025.clinker.html JAUALM020000025.1.gb pXCV183.WP_100101058.1_to_WP_152667176.1.gbk

clinker -p pXCV183.versus.JAUALM020000026.clinker.html JAUALM020000026.1.gb pXCV183.WP_011345768.1_to_WP_011345576.1.gbk
clinker -p pXCV183.versus.JAUALM020000026.clinker.html JAUALM020000026.1.gb pXCV183.WP_100101058.1_to_WP_152667176.1.gbk

clinker -p pXCV183.versus.JAUALM020000047.clinker.html JAUALM020000047.1.gb pXCV183.WP_011345768.1_to_WP_011345576.1.gbk
clinker -p pXCV183.versus.JAUALM020000047.clinker.html JAUALM020000047.1.gb pXCV183.WP_100101058.1_to_WP_152667176.1.gbk



