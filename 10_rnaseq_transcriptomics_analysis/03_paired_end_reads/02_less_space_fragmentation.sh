#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"


# calculate time taken for the whole analysis
echo "Started at: $(date)" >> rnaseq_timing.log
SECONDS=0

#-------------------------READemption RNA-seq Analysis Pipeline-------------------------
# Auto Run for whole Analysis Pipeline
#-------------------------reademption-----------------
conda activate reademption

# create folders
reademption create \
    --project_path READemption_analysis \
    --species rhizobium="Rhizobium tropici CIAT 899"

# download genome fasta file
wget -O ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna.gz \
    https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/330/885/GCF_000330885.1_ASM33088v1/GCF_000330885.1_ASM33088v1_genomic.fna.gz 
gunzip ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna.gz
mv ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fna \
    ./READemption_analysis/input/rhizobium_reference_sequences/GCF_000330885.1_ASM33088v1_genomic.fasta

# download genome gff file and unzip
wget -P ./READemption_analysis/input/rhizobium_annotations/ \
    https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/330/885/GCF_000330885.1_ASM33088v1/GCF_000330885.1_ASM33088v1_genomic.gff.gz 
gunzip ./READemption_analysis/input/rhizobium_annotations/GCF_000330885.1_ASM33088v1_genomic.gff.gz

# copy raw reads into input folder
cp /media/codanics/ext_ssd/01_rnaseq_paired_end/manuscript/fastq_raw/*fastq.gz ./READemption_analysis/input/reads/

# rename files according to your treatment from NCBI and Paper
cd ./READemption_analysis/input/reads/
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
cd ../../..

#-------------------------ONE SAMPLE AT A TIME ALIGNMENT-------------------------

# Create main output directories to accumulate results
mkdir -p READemption_analysis/output/align/{alignments,processed_reads,unaligned_reads,reports_and_stats}

# Define samples
SAMPLES="control_r1 control_r2 apigenin_r1 apigenin_r2 salt_r1 salt_r2"

# Process each sample individually
for sample in $SAMPLES; do
    echo "Processing $sample at $(date)" >> rnaseq_timing.log
    sample_start=$SECONDS
    
    echo "=== Processing sample: $sample ==="
    
    # Create temporary project
    TEMP_PROJ="temp_${sample}"
    
    # Ensure clean start
    if [ -d "$TEMP_PROJ" ]; then
        rm -rf "$TEMP_PROJ"
    fi

    # Initialize temp project (creates folders)
    reademption create --project_path "$TEMP_PROJ" --species rhizobium="Rhizobium tropici CIAT 899"
    
    # Copy references (quick operation)
    # Note: READemption creates the species folders
    cp READemption_analysis/input/rhizobium_reference_sequences/* "$TEMP_PROJ/input/rhizobium_reference_sequences/"
    cp READemption_analysis/input/rhizobium_annotations/* "$TEMP_PROJ/input/rhizobium_annotations/"
    
    # Copy only this sample's paired reads
    cp "READemption_analysis/input/reads/${sample}_p1.fastq.gz" "$TEMP_PROJ/input/reads/"
    cp "READemption_analysis/input/reads/${sample}_p2.fastq.gz" "$TEMP_PROJ/input/reads/"
    
    # Run alignment on single sample
    reademption align --project_path "$TEMP_PROJ" \
        --paired_end \
        --processes 6 \
        --segemehl_accuracy 95 \
        --poly_a_clipping \
        --fastq --min_phred_score 25
    
    # Move BAM files to main project
    if ls "$TEMP_PROJ/output/align/alignments/"*.bam 1> /dev/null 2>&1; then
        mv "$TEMP_PROJ/output/align/alignments/"*.bam \
           "$TEMP_PROJ/output/align/alignments/"*.bai \
           READemption_analysis/output/align/alignments/
        echo "  ✓ Moved BAM files"
    fi
    
    # Move processed reads (for QC)
    if ls "$TEMP_PROJ/output/align/processed_reads/"* 1> /dev/null 2>&1; then
        mv "$TEMP_PROJ"/output/align/processed_reads/* \
           READemption_analysis/output/align/processed_reads/
        echo "  ✓ Moved processed reads"
    fi
    
    # Move unaligned reads (optional, for debugging)
    if ls "$TEMP_PROJ/output/align/unaligned_reads/"* 1> /dev/null 2>&1; then
        mv "$TEMP_PROJ"/output/align/unaligned_reads/* \
           READemption_analysis/output/align/unaligned_reads/
        echo "  ✓ Moved unaligned reads"
    fi
    
    # Handle statistics with proper merging
    if [ -d "$TEMP_PROJ/output/align/reports_and_stats" ]; then
        # For first sample, copy full structure
        if [ ! -f READemption_analysis/output/align/reports_and_stats/read_alignment_stats.csv ]; then
            cp -r "$TEMP_PROJ"/output/align/reports_and_stats/* \
                  READemption_analysis/output/align/reports_and_stats/
            echo "  ✓ Copied full reports structure"
        else
            # For subsequent samples, append to CSVs
            # Note: READemption stats might need header handling which script does
            for csvfile in "$TEMP_PROJ"/output/align/reports_and_stats/*.csv; do
                if [ -f "$csvfile" ]; then
                    basename_csv=$(basename "$csvfile")
                    # Check if file has header (all READemption CSVs do)
                    if [ -s "$csvfile" ]; then
                        tail -n +2 "$csvfile" >> "READemption_analysis/output/align/reports_and_stats/$basename_csv"
                    fi
                fi
            done
            echo "  ✓ Appended statistics"
        fi
    fi
    
    # Clean up temp directory completely
    rm -rf "$TEMP_PROJ"
    echo "  ✓ Cleaned temp space"
    
    echo "Space after $sample:"
    du -sh READemption_analysis/output/align/
    echo
    
    echo "Sample $sample took $((SECONDS - sample_start)) seconds" >> rnaseq_timing.log
done

# Verify all BAM files are present
echo "=== Alignment Complete. BAM files: ==="
ls -lh READemption_analysis/output/align/alignments/*.bam
echo

# Wait a moment before next step
sleep 30 

#-------------------------CONTINUE WITH DOWNSTREAM ANALYSIS-------------------------

#4- Coverage (run on all BAMs together)
echo "Running coverage analysis..."
reademption coverage \
    --paired_end \
    --project_path READemption_analysis \
    --processes 6

#5- Gene quantification
echo "Running gene quantification..."
reademption gene_quanti \
    --paired_end \
    --add_antisense \
    --project_path READemption_analysis \
    --processes 6 --features CDS,tRNA,rRNA,gene 

#6- Differential expression analysis
echo "Running DESeq2 analysis..."
reademption deseq \
    --project_path READemption_analysis \
    --libs control_r1,control_r2,apigenin_r1,apigenin_r2,salt_r1,salt_r2 \
    --conditions control,control,apigenin,apigenin,salt,salt \
    --replicates 1,2,1,2,1,2 \
    --libs_by_species rhizobium=control_r1,control_r2,apigenin_r1,apigenin_r2,salt_r1,salt_r2

#7- Visualizations
echo "Generating visualizations..."
reademption viz_align --paired_end --project_path READemption_analysis
reademption viz_gene_quanti --paired_end --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis

conda deactivate

echo "Finished at: $(date)" >> rnaseq_timing.log
echo "RNA-seq Analysis Pipeline Completed."
#----------------------------------------------------------------------------------------
echo "Total time taken: $SECONDS seconds" >> rnaseq_timing.log