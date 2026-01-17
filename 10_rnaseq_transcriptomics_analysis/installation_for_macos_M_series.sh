# Agar MACos main conda na chalay tu ye likhen:
conda config --env --set subdir osx-64
# conda config --env --set subdir linux-64
# conda config --env --set subdir osx-arm64
# This is how to remove channel priority 
conda config --set channel_priority false

conda config --env --set subdir osx-64
# Install reademption for RNAseq
conda config --add channels conda-forge
conda config --add channels bioconda

conda create -n "reademption" python=3.9 -y
conda activate reademption
conda config --add channels conda-forge
conda config --add channels bioconda
conda install -c bioconda segemehl=0.3.4 -y
conda install -c conda-forge r-base=4.3.3 -y
conda install -c bioconda bioconductor-deseq2=1.42.0 -y
conda install -c r r-gplots=3.2.0 -y
pip install reademption
reademption --help