#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"


# copy raw reads into input folder
mkdir -p raw_reads
cp /media/codanics/ext_ssd/01_rnaseq_paired_end/manuscript/fastq_raw/*fastq.gz raw_reads/

# rename files according to your treatment from NCBI and Paper
cd raw_reads/
# control
mv SRR3031957_1.fastq.gz control_r1_p1.fastq.gz
mv SRR3031957_2.fastq.gz control_r1_p2.fastq.gz
mv SRR3031958_1.fastq.gz control_r2_p1.fastq.gz
mv SRR3031958_2.fastq.gz control_r2_p2.fastq.gz

# apigenin treatment
mv SRR3032151_1.fastq.gz apigenin_r1_p1.fastq.gz
mv SRR3032151_2.fastq.gz apigenin_r1_p2.fastq.gz
mv SRR3062176_1.fastq.gz apigenin_r2_p1.fastq.gz
mv SRR3062176_2.fastq.gz apigenin_r2_p2.fastq.gz

# salt treatment
mv SRR3036912_1.fastq.gz salt_r1_p1.fastq.gz
mv SRR3036912_2.fastq.gz salt_r1_p2.fastq.gz
mv SRR3036915_1.fastq.gz salt_r2_p1.fastq.gz
mv SRR3036915_2.fastq.gz salt_r2_p2.fastq.gz
cd ..


#======================== BBMerge + READemption Pipeline ========================
# Retains your original paths while optimizing merge rate and handling unmerged reads
#================================================================================
# conda create -n bbmap bioconda::bbmap -y
conda activate bbmap
# PATH DEFINITIONS (all in one place)
reads="raw_reads"          # Input paired reads
merged="raw_reads/merged"            # Output directory
mkdir -p "$merged"

# PROCESSING (one clear loop)
for r1 in "$reads"/*_p1.fastq.gz; do
    sample=$(basename "$r1" _p1.fastq.gz)
    r2="$reads/${sample}_p2.fastq.gz"
    
    [ -f "$r2" ] || { echo "Skip: missing $r2"; continue; }
    
    # OUTPUT PATHS (explicit creation)
    out_merged="$merged/${sample}_merged.fastq.gz"
    out_u1="$merged/${sample}_unmerged_1.fastq.gz"
    out_u2="$merged/${sample}_unmerged_2.fastq.gz"
    out_final="$merged/${sample}.fastq.gz"
    
    # MERGE
    echo "Processing $sample..."
    bbmerge.sh in1="$r1" in2="$r2" out="$out_merged" \
        outu1="$out_u1" outu2="$out_u2" threads=10
    
    # COMBINE (100% retention)
    # cat "$out_merged" "$out_u1" "$out_u2" > "$out_final"
    
    # Optional cleanup (uncomment to remove intermediates)
    # rm "$out_merged" "$out_u1" "$out_u2"
done

echo "Done. Single-end files: $merged/*.fastq.gz"



####################################################################################
# READemption analysis
###############################################################
conda activate reademption

# Create directories
reademption create \
    --project_path READemption_analysis \
    --species rhizobium="Rhizobium tropici CIAT 899"

# Copy files
merged="raw_reads/merged"   
echo "Copying reads..."
cp "$merged"/*_merged.fastq.gz READemption_analysis/input/reads/
# rename all files to remove _merged from filename
for f in READemption_analysis/input/reads/*_merged.fastq.gz; do
    mv "$f" "${f/_merged/}"
done


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


conda activate reademption
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
