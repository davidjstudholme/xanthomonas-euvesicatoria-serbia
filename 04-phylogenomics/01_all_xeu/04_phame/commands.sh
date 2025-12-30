### This takes a while to run, so best to do it in a screen session
#screen

### Already installed PhaME into a Conda environment
conda activate phame_env

conda list -n phame_env > phame_env_packages.txt
conda env export > phame_env.yaml

### Assumes that PhaME is already installed
phame ./phame.ctl
phame ./phame.IQtree.ctl
phame ./phame.RAxML.ctl

