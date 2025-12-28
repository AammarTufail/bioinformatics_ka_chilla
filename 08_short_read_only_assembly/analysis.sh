#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"
# Define paths
SOURCE_DIR="/home/codanics/03_wgs_assembly/hybrid_genome_assembly_guide_bkc/01_raw_reads/short_reads"
WORK_DIR="/home/codanics/03_wgs_assembly/short_reads_only_assembly"

# Create directories
mkdir -p "${WORK_DIR}/00_raw_reads"
mkdir -p "${WORK_DIR}/01_qc_before_processing"
mkdir -p "${WORK_DIR}/02_process_reads"
mkdir -p "${WORK_DIR}/03_qc_after_processing"
mkdir -p "${WORK_DIR}/04_short_reads_only_assembly"
mkdir -p "${WORK_DIR}/05_genome_quality_assessment"
mkdir -p "${WORK_DIR}/06_genome_annotation"

# Copy short reads (.fastq.gz files)
cp "${SOURCE_DIR}"/*.fastq.gz "${WORK_DIR}/00_raw_reads/"
# Rename files to codanics_1.fastq.gz and codanics_2.fastq.gz
cd "${WORK_DIR}/00_raw_reads/"
mv *_1.fastq.gz codanics_1.fastq.gz
mv *_2.fastq.gz codanics_2.fastq.gz
cd -


echo "Directory structure created:"
ls -la "${WORK_DIR}"

echo ""
echo "Raw reads copied:"
ls -la "${WORK_DIR}/00_raw_reads/"

# Change to QC before processing directory
cd "${WORK_DIR}/01_qc_before_processing"
# run fastqc
conda activate 01_short_read_qc
# expert use case
mkdir reports
fastqc -o reports --extract --svg -t 12 "${WORK_DIR}/00_raw_reads/"*.fastq.gz

# run multiqc on fastqc files
conda activate 02_multiqc
#expert use case of multiqc
multiqc -p -o "${WORK_DIR}/01_qc_before_processing/multiqc/fastqc_multiqc" ./


# run fastp for read trimming and filtering
cd "${WORK_DIR}/02_process_reads"
conda activate 01_short_read_qc
fastp \
    -i "${WORK_DIR}/00_raw_reads/codanics_1.fastq.gz" -I "${WORK_DIR}/00_raw_reads/codanics_2.fastq.gz" \
    -o codanics_1_processed.fastq.gz -O codanics_2_processed.fastq.gz \
    -q 25 \
    -h ${WORK_DIR}/03_qc_after_processing/fastp_report.html -j ${WORK_DIR}/03_qc_after_processing/fastp_report.json -w 12

# fastqc and multi qc run on processed reads
cd "${WORK_DIR}/03_qc_after_processing"
conda activate 01_short_read_qc
mkdir reports_fastqc_processed
fastqc -o reports_fastqc_processed --extract --svg -t 12 "${WORK_DIR}/02_process_reads/"*.fastq.gz
# run multiqc on fastqc files of processed reads
conda activate 02_multiqc
multiqc -p -o "${WORK_DIR}/03_qc_after_processing/multiqc/fastqc_multiqc_processed" ./
echo ""
echo "Quality control and read processing completed."


# spades for short read only assembly
cd "${WORK_DIR}/04_short_reads_only_assembly"
conda activate 03_spades
spades.py \
    -1 "${WORK_DIR}/02_process_reads/codanics_1_processed.fastq.gz" \
    -2 "${WORK_DIR}/02_process_reads/codanics_2_processed.fastq.gz" \
    -o "${WORK_DIR}/04_short_reads_only_assembly/spades_output" \
    --careful -t 12 -m 24


# checm2 for genome quality assessment
cd "${WORK_DIR}/05_genome_quality_assessment"
mkdir -p 01_checkm2
# copy assembly fasta file
cp "${WORK_DIR}/04_short_reads_only_assembly/spades_output/*.fasta" ./
cd 01_checkm2
conda activate 04a_checkm2
# analysis command
# checkm2 predict \
#     --threads 6 \
#     --input scaffolds.fasta contigs.fasta  \
#     --output-directory 01_checkm2

# analysis command with multiple input files
checkm2 predict \
    --threads 6 \
    --input *.fasta  \
    --output-directory 01_checkm2

# quast for genome quality assessment
conda activate 04b_quast
mkdir -p 02_quast
quast \
    -o 02_quast \
    -t 12 \
    *.fasta 
# with other features
mkdir -p 03_quast_busco_others
quast \
    -o 03_quast_busco_others \
    -t 12 \
    *.fasta \
    --circos --glimmer --rna-finding \
    --conserved-genes-finding \
    --report-all-metrics \
    --use-all-alignments


# run quast with busco
conda activate 04c_busco
mkdir -p 04_busco_assessment
cp contigs.fasta 04_busco_assessment/
cd 04_busco_assessment
busco \
    -i contigs.fasta \
    -o busco_results \
    -l bacteria_odb12 \
    -m genome \
    -c 10
busco --plot ./busco_results


# genome annotation with prokka and bakta
cd "${WORK_DIR}/06_genome_annotation"
mkdir -p 01_prokka_annotation
cp "${WORK_DIR}/04_short_reads_only_assembly/spades_output/*.fasta" ./
mv contigs.fasta codanics_genome.fasta
conda activate 05_genome_annotation
# prokka annotation
prokka --outdir 01_prokka_annotation \
    --prefix codanics_prokka \
    --kingdom Bacteria \
    --addgenes --cpus 10 \
    codanics_genome.fasta
# bakta annotation (this will automatically create new directory for output)
bakta codanics_genome.fasta \
    --db /home/codanics/databases_important/bakta_db/db-light \
    -t 10 --verbose \
    -o 02_bakta_annotation \
    --prefix codanics_bakta \
    --complete 
