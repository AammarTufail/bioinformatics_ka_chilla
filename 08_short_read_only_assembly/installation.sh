echo "Setting up conda environments for short read quality control and multiqc"
# initialize conda for this script
eval "$(conda shell.bash hook)"

# remove previous conda environment if exists
conda env remove -n 01_short_read_qc -y
conda env remove -n 02_multiqc -y

# 01_fastqc and fastp
conda create -n 01_short_read_qc -y
conda activate 01_short_read_qc
# for quality check
conda install bioconda::fastqc -y
# for quality check and trimming
conda install bioconda::fastp -y

echo "--------------------------------------------"

echo "Setting up conda environment for multiqc"
# multiqc
conda create -n 02_multiqc -y
conda activate 02_multiqc
conda install bioconda::multiqc -y


# install spades for short reads only assembly
echo "--------------------------------------------"
echo "Setting up conda environment for short read assembly using SPAdes"
conda env remove -n 03_spades -y
conda create -n 03_spades -y
conda activate 03_spades
conda install bioconda::spades -y
# check installation
spades.py --version

# install checkm2 for genome quality assessment
echo "--------------------------------------------"
echo "Setting up conda environment for genome quality assessment using CheckM2"
conda create -n 04a_checkm2 -c bioconda -c conda-forge checkm2 -y
conda activate 04a_checkm2
# check installation
checkm2 -h
# download databases if the commands work use following
# checkm2 database --download
# checkm2 database --download --path /home/codanics/databases_important/checkm2_db

#manuall database download
# mkdir -p /home/codanics/databases_important/checkm2_db
wget https://zenodo.org/api/records/14897628/files/checkm2_database.tar.gz/content \
    -O /home/codanics/databases_important/checkm2_db/checkm2_database.tar.gz
tar -xzvf /home/codanics/databases_important/checkm2_db/checkm2_database.tar.gz -C /home/codanics/databases_important/checkm2_db/
export CHECKM2DB="/home/codanics/databases_important/checkm2_db/CheckM2_database/uniref100.KO.1.dmnd"
# test run
checkm2 testrun

# install QUAST for genome quality assessment
echo "--------------------------------------------"
echo "Setting up conda environment for genome quality assessment using QUAST"
conda env remove -n 04b_quast -y
conda create -n 04b_quast -c bioconda quast -y
#update quast to latest version
pip install quast==5.2
conda activate 04b_quast
# check installation
quast --version
# Databases download
# GRIDSS (needed for structural variants detection)
quast-download-gridss
# SILVA 16S rRNA database (needed for reference genome detection in metagenomic datasets)
quast-download-silva
# BUSCO tools and databases (needed for searching BUSCO genes) -- works in Linux only!
quast-download-busco
# download manually but not working
# link https://busco-data.ezlab.org/v5/data/lineages/


# install busco separately for busco analysis
echo "--------------------------------------------"
echo "Setting up conda environment for BUSCO analysis"
conda env remove -n 04c_busco -y
conda create -n 04c_busco -y
conda activate 04c_busco
conda install -c conda-forge -c bioconda busco sepp -y

# check installation
busco --version
busco --list-datasets
# download lineage datasets as per requirement, example for bacteria
# busco --download bacteria_odb12 
# downloaded datasets will be stored in conda env path under /busco_downloads/
echo "--------------------------------------------"






# genome annotation
echo "Setting up conda environment for genome annotation using Prokka and Bakta"
conda env remove -n 05_genome_annotation -y
conda create -n 05_genome_annotation -c bioconda -c conda-forge prokka bakta -y
conda activate 05_genome_annotation
# check installation
prokka --version
# check prokka databases
prokka --listdb
bakta --version
echo "--------------------------------------------"
## bakta databse download
# bakta_db download --output /home/codanics/databases_important/bakta_db --type light
## manual way will end with 4GB
mkdir -p /home/codanics/databases_important/bakta_db
wget https://zenodo.org/records/14916843/files/db-light.tar.xz \
    -O /home/codanics/databases_important/bakta_db_light.tar.xz
tar -xJvf /home/codanics/databases_important/bakta_db_light.tar.xz \
    -C /home/codanics/databases_important/bakta_db
rm /home/codanics/databases_important/bakta_db_light.tar.xz
# set BAKTA_DB_PATH environment variable
export BAKTA_DB="/home/codanics/databases_important/bakta_db/db-light"
# update amrfinderplus database if needed
amrfinder_update --force_update --database /home/codanics/databases_important/bakta_db/db-light/amrfinderplus-db
