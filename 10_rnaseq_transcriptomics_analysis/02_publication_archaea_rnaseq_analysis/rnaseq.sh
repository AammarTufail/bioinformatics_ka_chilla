#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"

# echo current time
echo "Started at: $(date)"

# Auto Run for whole Analysis Pipeline
#-------------------------reademption-----------------
conda activate reademption
# create folders
reademption create \
	--project_path READemption_analysis \
	--species methanosarcina="Methanosarcina mazei"

#download genome fasta file
wget -O ./READemption_analysis/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz \
	https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.fna.gz
gunzip ./READemption_analysis/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz
mv ./READemption_analysis/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna \
	./READemption_analysis/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fa
# download genome gff file and unzip
wget -P ./READemption_analysis/input/methanosarcina_annotations \
	https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.gff.gz
gunzip READemption_analysis/input/methanosarcina_annotations/GCF_000007065.1_ASM706v1_genomic.gff.gz


# # activate and download raw reads using grabseqs
# conda activate grabseqs
# mkdir fastq_raw
# cd fastq_raw
# # Create metadata files for each sample
# grabseqs sra -t 10 -m metadata1.csv SRR4018514 
# grabseqs sra -t 10 -m metadata2.csv SRR4018515 
# grabseqs sra -t 10 -m metadata3.csv SRR4018516 
# grabseqs sra -t 10 -m metadata4.csv SRR4018517
# conda deactivate
# cd ..

# copy rawreads into input folder
cp ./fastq_raw/*fastq.gz ./READemption_analysis/input/reads/

# rename files according to your treatment from NCBI and Paper
cd ./READemption_analysis/input/reads/
mv SRR4018514.fastq.gz wt_R1.fastq.gz
mv SRR4018515.fastq.gz wt_R2.fastq.gz
mv SRR4018516.fastq.gz mut_R1.fastq.gz
mv SRR4018517.fastq.gz mut_R2.fastq.gz
cd -

conda activate reademption
#3- Processing and aligning the reads
reademption align --project_path READemption_analysis \
	--processes 11 --segemehl_accuracy 95 \
	--poly_a_clipping \
	--fastq --min_phred_score 25 \
	--progress

#4- Coverage
reademption coverage \
	--project_path READemption_analysis \
	--processes 11

#5- Performing gene wise quantification
reademption gene_quanti \
	--project_path READemption_analysis \
	--processes 11 --features CDS,tRNA,rRNA 

#6- Performing differential gene expression analysis 

####NOTE:: Change the names according to your file names in the READemption_analysis/input/reads/ directory
reademption deseq \
	--project_path READemption_analysis \
	--libs mut_R1.fastq.gz,mut_R2.fastq.gz,wt_R1.fastq.gz,wt_R2.fastq.gz \
	--conditions mut,mut,wt,wt \
	--replicates 1,2,1,2 \
	--libs_by_species methanosarcina=mut_R1,mut_R2,wt_R1,wt_R2

#7- Create plots 
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis

# The whole command will take around 2 hours to run.
conda deactivate

echo "Finished at: $(date)"