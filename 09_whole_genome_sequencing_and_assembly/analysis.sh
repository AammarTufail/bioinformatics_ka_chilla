#!/bin/bash

# initialize conda for this script
eval "$(conda shell.bash hook)"

# rename raw reads
mv 01_raw_reads/short_reads/*_1.fastq.gz 01_raw_reads/short_reads/codanics_1.fastq.gz
mv 01_raw_reads/short_reads/*_2.fastq.gz 01_raw_reads/short_reads/codanics_2.fastq.gz
mv 01_raw_reads/long_reads/*.fastq.gz 01_raw_reads/long_reads/codanics_long.fastq.gz

################## directories setup #####################
# QC before processing
mkdir -p 02_reads_QC_before_processing
mkdir -p 02_reads_QC_before_processing/short_reads
mkdir -p 02_reads_QC_before_processing/long_reads

# processed reads
mkdir -p 03_reads_processed
mkdir -p 03_reads_processed/short_reads
mkdir -p 03_reads_processed/long_reads

# QC after processing
mkdir -p 04_reads_QC_after_processing
mkdir -p 04_reads_QC_after_processing/short_reads
mkdir -p 04_reads_QC_after_processing/long_reads

# hybrid genome assembly
mkdir -p 05_hybrid_genome_assembly

# Genome quality assessment
mkdir -p 06_genome_quality_assessment
mkdir -p 06_genome_quality_assessment/01_checkm2
mkdir -p 06_genome_quality_assessment/01_checkm2/01_short_only_assembly
mkdir -p 06_genome_quality_assessment/01_checkm2/02_long_only_assembly
mkdir -p 06_genome_quality_assessment/01_checkm2/03_hybrid_assembly
mkdir -p 06_genome_quality_assessment/02_quast
mkdir -p 06_genome_quality_assessment/02_quast/01_short_only_assembly
mkdir -p 06_genome_quality_assessment/02_quast/02_long_only_assembly
mkdir -p 06_genome_quality_assessment/02_quast/03_hybrid_assembly
mkdir -p 06_genome_quality_assessment/03_busco
mkdir -p 06_genome_quality_assessment/03_busco/01_short_only_assembly
mkdir -p 06_genome_quality_assessment/03_busco/02_long_only_assembly
mkdir -p 06_genome_quality_assessment/03_busco/03_hybrid_assembly

# Genome annotation
mkdir -p 07_genome_annotation
mkdir -p 07_genome_annotation/01_prokka
mkdir -p 07_genome_annotation/01_prokka/01_short_only_assembly
mkdir -p 07_genome_annotation/01_prokka/02_long_only_assembly
mkdir -p 07_genome_annotation/01_prokka/03_hybrid_assembly
mkdir -p 07_genome_annotation/02_bakta
mkdir -p 07_genome_annotation/02_bakta/01_short_only_assembly
mkdir -p 07_genome_annotation/02_bakta/02_long_only_assembly
mkdir -p 07_genome_annotation/02_bakta/03_hybrid_assembly


############## Short reads quality checking tools #####################
# run fastqc
conda activate 01_short_read_qc
fastqc -o 02_reads_QC_before_processing/short_reads \
    --extract --svg -t 12 \
    01_raw_reads/short_reads/*.fastq.gz

# create multiqc output directory
mkdir -p 02_reads_QC_before_processing/short_reads/multiqc/
conda activate 02_multiqc
#expert use case of multiqc
multiqc -p \
    -o 02_reads_QC_before_processing/short_reads/multiqc/ \
    02_reads_QC_before_processing/short_reads/

############## fastp #####################
conda activate 01_short_read_qc
fastp \
    -i 01_raw_reads/short_reads/codanics_1.fastq.gz -I 01_raw_reads/short_reads/codanics_2.fastq.gz \
    -o 03_reads_processed/short_reads/codanics_1_processed.fastq.gz -O 03_reads_processed/short_reads/codanics_2_processed.fastq.gz \
    -q 25 \
    -h 04_reads_QC_after_processing/short_reads/fastp_report.html \
    -j 04_reads_QC_after_processing/short_reads/fastp_report.json \
    -w 12


################## long reads qc #####################
conda activate 03a_long_read_nanoplot
NanoPlot \
    --fastq 01_raw_reads/long_reads/codanics_long.fastq.gz \
    -o 02_reads_QC_before_processing/long_reads/ \
    --threads 12

################## long reads processing #####################
# Nanofilt
conda activate 03b_long_read_nanofilt
zcat 01_raw_reads/long_reads/codanics_long.fastq.gz | \
    NanoFilt -q 8 --length 1000 --headcrop 50 | gzip > \
    03_reads_processed/long_reads/codanics_long_filtered.fastq.gz

# Filtlong
# conda activate 03c_long_read_filtlong
# Filtlong \
#     --min_length 1000 \
#     --keep_percent 90 \
#     --target_bases 1000000000 \
#     03_reads_processed/long_reads/codanics_long_filtered.fastq.gz | \
#     gzip > 03_reads_processed/long_reads/codanics_long_processed.fastq.gz

################## long reads qc after processing #####################
conda activate 03a_long_read_nanoplot
NanoPlot \
    --fastq 03_reads_processed/long_reads/codanics_long_filtered.fastq.gz \
    -o 04_reads_QC_after_processing/long_reads/ \
    --threads 12

################## hybrid genome assembly #####################
conda activate 04_unicycler

mkdir -p 05_hybrid_genome_assembly/01_short_only_assembly
# short reads only assembly
unicycler \
    -1 03_reads_processed/short_reads/codanics_1_processed.fastq.gz \
    -2 03_reads_processed/short_reads/codanics_2_processed.fastq.gz \
    -o 05_hybrid_genome_assembly/01_short_only_assembly/ \
    -t 10
# long read only
mkdir -p 05_hybrid_genome_assembly/02_long_only_assembly
unicycler \
    -l 03_reads_processed/long_reads/codanics_long_filtered.fastq.gz \
    -o 05_hybrid_genome_assembly/02_long_only_assembly/ \
    -t 10
# hybrid assembly
mkdir -p 05_hybrid_genome_assembly/03_hybrid_assembly
unicycler \
    -1 03_reads_processed/short_reads/codanics_1_processed.fastq.gz \
    -2 03_reads_processed/short_reads/codanics_2_processed.fastq.gz \
    -l 03_reads_processed/long_reads/codanics_long_filtered.fastq.gz \
    -o 05_hybrid_genome_assembly/03_hybrid_assembly/ \
    -t 10 \
    --verbosity 2 \
    --min_fasta_length 500


################## genome quality assessment using checkm2 #####################
conda activate 04a_checkm2
export CHECKM2DB="/home/codanics/databases_important/checkm2_db/CheckM2_database/uniref100.KO.1.dmnd"
# short reads only assembly
checkm2 predict \
    --threads 10 \
    --input 05_hybrid_genome_assembly/01_short_only_assembly/assembly.fasta \
    --output-directory 06_genome_quality_assessment/01_checkm2/01_short_only_assembly/
# long reads only assembly
checkm2 predict \
    --threads 10 \
    --input 05_hybrid_genome_assembly/02_long_only_assembly/assembly.fasta \
    --output-directory 06_genome_quality_assessment/01_checkm2/02_long_only_assembly/
# hybrid assembly
checkm2 predict \
    --threads 10 \
    --input 05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta \
    --output-directory 06_genome_quality_assessment/01_checkm2/03_hybrid_assembly/



################## genome quality assessment using quast #####################
conda activate 04b_quast
# short reads only assembly
quast \
    -o 06_genome_quality_assessment/02_quast/01_short_only_assembly/quast_results \
    -t 10 \
    05_hybrid_genome_assembly/01_short_only_assembly/assembly.fasta
    --circos --glimmer --rna-finding \
    --conserved-genes-finding \
    --report-all-metrics \
    --use-all-alignments
# long reads only assembly
quast \
    -o 06_genome_quality_assessment/02_quast/02_long_only_assembly/quast_results \
    -t 10 \
    05_hybrid_genome_assembly/02_long_only_assembly/assembly.fasta
    --circos --glimmer --rna-finding \
    --conserved-genes-finding \
    --report-all-metrics \
    --use-all-alignments
# hybrid assembly
quast \
    -o 06_genome_quality_assessment/02_quast/03_hybrid_assembly/quast_results \
    -t 10 \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta
    --circos --glimmer --rna-finding \
    --conserved-genes-finding \
    --report-all-metrics \
    --use-all-alignments

################## genome quality assessment using busco #####################
conda activate 04c_busco
# short reads only assembly
busco \
    -i 05_hybrid_genome_assembly/01_short_only_assembly/assembly.fasta \
    -o 06_genome_quality_assessment/03_busco/01_short_only_assembly/busco_results \
    -l bacteria_odb12 \
    -m genome \
    -c 10
busco --plot 06_genome_quality_assessment/03_busco/01_short_only_assembly/busco_results
# long reads only assembly
busco \
    -i 05_hybrid_genome_assembly/02_long_only_assembly/assembly.fasta \
    -o 06_genome_quality_assessment/03_busco/02_long_only_assembly/busco_results \
    -l bacteria_odb12 \
    -m genome \
    -c 10
busco --plot 06_genome_quality_assessment/03_busco/02_long_only_assembly/busco_results
# hybrid assembly
busco \
    -i 05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta \
    -o 06_genome_quality_assessment/03_busco/03_hybrid_assembly/busco_results \
    -l bacteria_odb12 \
    -m genome \
    -c 10
busco --plot 06_genome_quality_assessment/03_busco/03_hybrid_assembly/busco_results

################### genome annotation #####################
# prokka annotation
conda activate 05_genome_annotation
# short reads only assembly
prokka --outdir 07_genome_annotation/01_prokka/01_short_only_assembly/ \
    --prefix codanics_prokka_short_only \
    --kingdom Bacteria \
    --addgenes --cpus 10 \
    05_hybrid_genome_assembly/01_short_only_assembly/assembly.fasta \
    --force

# long reads only assembly
prokka --outdir 07_genome_annotation/01_prokka/02_long_only_assembly/ \
    --prefix codanics_prokka_long_only \
    --kingdom Bacteria \
    --addgenes --cpus 10 \
    05_hybrid_genome_assembly/02_long_only_assembly/assembly.fasta \
    --force

# hybrid assembly
prokka --outdir 07_genome_annotation/01_prokka/03_hybrid_assembly/ \
    --prefix codanics_prokka_hybrid \
    --kingdom Bacteria \
    --addgenes --cpus 10 \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta \
    --force


# bakta annotation (this will automatically create new directory for output)
conda activate 05_genome_annotation
# short reads only assembly
bakta \
    05_hybrid_genome_assembly/01_short_only_assembly/assembly.fasta \
    --db /home/codanics/databases_important/bakta_db/db-light \
    -t 10 --verbose \
    -o 07_genome_annotation/02_bakta/01_short_only_assembly/ \
    --prefix codanics_bakta_short_only \
    --complete --force
# long reads only assembly
bakta \
    05_hybrid_genome_assembly/02_long_only_assembly/assembly.fasta \
    --db /home/codanics/databases_important/bakta_db/db-light \
    -t 10 --verbose \
    -o 07_genome_annotation/02_bakta/02_long_only_assembly/ \
    --prefix codanics_bakta_long_only \
    --complete --force
# hybrid assembly
bakta \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta \
    --db /home/codanics/databases_important/bakta_db/db-light \
    -t 10 --verbose \
    -o 07_genome_annotation/02_bakta/03_hybrid_assembly/ \
    --prefix codanics_bakta_hybrid \
    --complete --force

################## plassembler for plasmid finding #####################
conda activate 06_plassembler
# this will take around 10-15 minutes to run
plassembler run \
    -d /home/codanics/databases_important/plassembler_db \
    -1 03_reads_processed/short_reads/codanics_1_processed.fastq.gz \
    -2 03_reads_processed/short_reads/codanics_2_processed.fastq.gz \
    -l 03_reads_processed/long_reads/codanics_long_filtered.fastq.gz \
    -o 08_plassembler_output/ \
    -t 10

################## quality of assemblies using checkm2, quast and busco #####################
mkdir -p 09_assembly_quality_assessment
mkdir -p 09_assembly_quality_assessment/01_checkm2
mkdir -p 09_assembly_quality_assessment/02_quast
mkdir -p 09_assembly_quality_assessment/03_busco
# checkm2
conda activate 04a_checkm2
export CHECKM2DB="/home/codanics/databases_important/checkm2_db/CheckM2_database/uniref100.KO.1.dmnd"
# hybrid assembly
checkm2 predict \
    --threads 10 \
    --input 08_plassembler_output/unicycler_output/assembly.fasta \
    --output-directory 09_assembly_quality_assessment/01_checkm2/


################## genome quality assessment using quast #####################
conda activate 04b_quast
# short reads only assembly

# hybrid assembly
quast \
    -o 09_assembly_quality_assessment/02_quast/quast_results \
    -t 10 \
    08_plassembler_output/unicycler_output/assembly.fasta \
    --circos --glimmer --rna-finding \
    --conserved-genes-finding \
    # --report-all-metrics \
    --use-all-alignments

################## genome quality assessment using busco #####################
conda activate 04c_busco

# hybrid assembly
busco \
    -i 08_plassembler_output/unicycler_output/assembly.fasta \
    -o 09_assembly_quality_assessment/03_busco/busco_results \
    -l bacteria_odb12 \
    -m genome \
    -c 10
busco --plot 06_genome_quality_assessment/03_busco/03_hybrid_assembly/busco_results


################## Abricate for AMR genes #####################
mkdir -p 10_abricate_results
conda activate 07_abricate
abricate --list
abricate --db ncbi \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta > \
    10_abricate_results/abricate_ncbi_results.tsv
abricate --db resfinder \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta > \
    10_abricate_results/abricate_resfinder_results.tsv
abricate --db card \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta > \
    10_abricate_results/abricate_card_results.tsv
abricate --db vfdb \
    05_hybrid_genome_assembly/03_hybrid_assembly/assembly.fasta > \
    10_abricate_results/abricate_vfdb_results.tsv
# combine
abricate --summary 10_abricate_results/*.tsv > 10_abricate_results/abricate_summary.tsv

################## genomad #####################
mkdir -p 11_genomad_results
cp 07_genome_annotation/01_prokka/03_hybrid_assembly/codanics_prokka_hybrid.fna \
    11_genomad_results/
conda activate 08_genomad

# for relaxed run
genomad \
    end-to-end \
    --cleanup \
    --splits 8 \
    codanics_bakta_hybrid.fna \
    genomad_output_relaxed \
    /home/codanics/databases_important/genomad_db/genomad_db \
    --relaxed
# for conservative run
genomad \
    end-to-end \
    --cleanup \
    --splits 8 \
    codanics_bakta_hybrid.fna \
    genomad_output_conservative \
    /home/codanics/databases_important/genomad_db/genomad_db \
    --conservative

# you may also run genomad one by one module as per your requirement
conda activate 08_genomad
# Run genomad modules one by one
genomad annotate codanics_bakta_hybrid.fna genomad_output \
    /home/codanics/databases_important/genomad_db/genomad_db
genomad find-proviruses codanics_bakta_hybrid.fna genomad_output \
    /home/codanics/databases_important/genomad_db/genomad_db
genomad marker-classification codanics_bakta_hybrid.fna genomad_output \
    /home/codanics/databases_important/genomad_db/genomad_db
genomad nn-classification codanics_bakta_hybrid.fna genomad_output
genomad aggregated-classification codanics_bakta_hybrid.fna genomad_output
genomad score-calibration codanics_bakta_hybrid.fna genomad_output
genomad summary codanics_bakta_hybrid.fna genomad_output
