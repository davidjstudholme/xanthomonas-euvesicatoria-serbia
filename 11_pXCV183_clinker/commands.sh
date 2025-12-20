
python3 extract_gbk.py ssrS pepQ

conda create -n clinker_env
conda activate clinker_env
conda install -c conda-forge clinker

conda list -n bwa_env > clinker_env_packages.txt
conda env export > clinker_env.yaml

clinker -p pXCV183.versus.JAUALM020000025.clinker.html JAUALM020000025.1.gb pXCV183.gb
clinker -p pXCV183.versus.JAUALM020000026.clinker.html JAUALM020000026.1.gb pXCV183.gb
clinker -p pXCV183.versus.JAUALM020000047.clinker.html JAUALM020000047.1.gb pXCV183.gb




