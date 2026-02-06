#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"


####################################################################################
# READemption analysis
###############################################################
conda activate reademption

# Create directories
reademption create \
    --project_path READemption_analysis \
    --species rhizobium="Rhizobium tropici CIAT 899"

# Copy files
echo "Copying reads..."
cp fastq_raw/fastq_raw/*_p1.fastq.gz READemption_analysis/input/reads/
# remove _p1 from filenames
cd READemption_analysis/input/reads/
for file in *_p1.fastq.gz; do
    mv "$file" "${file/_p1/}"
done
cd ../../../..


#download genome fasta file
wget -O ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna.gz \
	https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/330/885/GCF_000330885.1_ASM33088v1/GCF_000330885.1_ASM33088v1_genomic.fna.gz
gunzip ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna.gz
mv ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna \
	./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fasta
# Download fasta for plasmids
# Already included in fasta file above, so skipping this step
# download genome gff file and unzip
wget -P ./READemption_analysis/input/rhizobium_annotations/ \
	https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/330/885/GCF_000330885.1_ASM33088v1/GCF_000330885.1_ASM33088v1_genomic.gff.gz
gunzip ./READemption_analysis/input/rhizobium_annotations/GCF_000330885.1_ASM33088v1_genomic.gff.gz



# Alignment
reademption align --project_path "READemption_analysis" \
    --processes 10 \
    --segemehl_accuracy 95 \
    --poly_a_clipping \
    --fastq --min_phred_score 25 \
    --progress

# Coverage
reademption coverage --project_path READemption_analysis --processes 10

# Quantification
reademption gene_quanti --project_path READemption_analysis --processes 10 --features CDS,tRNA,rRNA 

# DESeq
reademption deseq \
    --project_path READemption_analysis \
    --libs apigenin_r1.fastq.gz,apigenin_r2.fastq.gz,control_r1.fastq.gz,control_r2.fastq.gz,salt_r1.fastq.gz,salt_r2.fastq.gz \
    --conditions apigenin,apigenin,control,control,salt,salt \
    --replicates 1,2,1,2,1,2 \
    --libs_by_species rhizobium=apigenin_r1,apigenin_r2,control_r1,control_r2,salt_r1,salt_r2

# Visualizations
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis
    
conda deactivate
