############## Short reads quality checking tools 
echo "Setting up conda environments for short read quality control and multiqc"
# initialize conda for this script
eval "$(conda shell.bash hook)"


# install grabseqs
conda create -n grabseqs -y
conda activate grabseqs
# conda install grabseqs -c louiejtaylor -c bioconda -c conda-forge -y
# mamba install grabseqs -c louiejtaylor -c bioconda -c conda-forge -y
conda install python=3.9 -y
pip install grabseqs
# dependencies
conda install conda-forge::pigz -y
conda install bioconda::sra-tools -y

# # to download a sequence
# grabseqs sra SRR35136585
# # to get whole project
# grabseqs sra SRP610834
# # srr file with -t
# grabseqs sra -t 4 -m metadata.csv SRR8893090
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


################ Long reads quality checking tools
# NanoPlot
# conda env remove -n 03_long_read_qc -y
conda create -n 03a_long_read_nanoplot -y
conda activate 03a_long_read_nanoplot
conda install bioconda::nanoplot -y
pip install 'kaleido>=1.0.0'

conda create -n 03b_long_read_nanofilt -y
conda activate 03b_long_read_nanofilt
conda install -c bioconda nanofilt -y

conda create -n 03c_long_read_filtlong -y
conda activate 03c_long_read_filtlong
conda install bioconda::filtlong -y


### Unicycler
conda create -n 04_unicycler -y
conda activate 04_unicycler
conda install bioconda::unicycler -y



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
echo "--------------------------------------------"


echo "--------------------------------------------"
# plasmid finder with plassembler
conda deactivate
conda env remove -n 06_plassembler -y
# conda install mamba -y
conda create -n 06_plassembler -y
conda activate 06_plassembler
mamba install -c conda-forge -c bioconda plassembler=1.8.1 -y
# download databases and please try several times if you see errors
plassembler download -d /home/codanics/databases_important/plassembler_db -f
echo "--------------------------------------------"

# abricate
conda create -n 07_abricate -y
conda activate 07_abricate
conda install -c conda-forge -c bioconda abricate -y
# download abricate databases
abricate --check
abricate --list
echo "--------------------------------------------"

#geNomad
echo "--------------------------------------------"
conda env remove -n 08_genomad -y
conda create -n 08_genomad -y
conda activate 08_genomad
conda install -c conda-forge -c bioconda genomad=1.8 -y
genomad --help
mkdir -p /home/codanics/databases_important/genomad_db
genomad download-database /home/codanics/databases_important/genomad_db
echo "--------------------------------------------"





## Genome classification with GTDB-Tk
conda create -n gtdbtk-2.6.1 -c conda-forge -c bioconda gtdbtk=2.6.1 -y
conda activate gtdbtk-2.6.1

# download GTDB database (approx 140GB)
# making folder for database
mkdir -p /media/codanics/ext_ssd/gtdbtk_r226_data/gtdbtk_r226_data
# downloading database ~100GB
wget https://data.gtdb.aau.ecogenomic.org/releases/release226/226.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r226_data.tar.gz \
    -O /media/codanics/Softwares/databases_for_bioinformatics/gtdbtk_r226_data/gtdbtk_r226_data.tar.gz
# extracting database
tar xvzf /media/codanics/ext_ssd/gtdbtk_r226_data/gtdbtk_r226_data.tar.gz \
    -C /media/codanics/ext_ssd/gtdbtk_r226_data/gtdbtk_r226_data \
    --strip 1 | tqdm --unit=file \
    --total=307538 \
    --smoothing=0.1 >/dev/null

# setting GTDBTK_DATA_PATH environment variable using conda env config vars
conda env config vars set GTDBTK_DATA_PATH="/media/codanics/ext_ssd/gtdbtk_r226_data/gtdbtk_r226_data"
conda deactivate
conda activate gtdbtk-2.6.1
# test run
gtdbtk --help
gtdbtk check_install
