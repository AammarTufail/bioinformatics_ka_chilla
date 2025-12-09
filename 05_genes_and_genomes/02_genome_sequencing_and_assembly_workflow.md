# 🧬 Bacterial Genome Sequencing and Assembly Workflow

## From Lab Sample to NCBI-Ready Genome 🚀

---

## 📑 Table of Contents

- [🧬 Bacterial Genome Sequencing and Assembly Workflow](#-bacterial-genome-sequencing-and-assembly-workflow)
  - [From Lab Sample to NCBI-Ready Genome 🚀](#from-lab-sample-to-ncbi-ready-genome-)
  - [📑 Table of Contents](#-table-of-contents)
  - [Introduction](#introduction)
  - [Workflow Overview](#workflow-overview)
  - [Phase 1: Laboratory Work (Wet Lab)](#phase-1-laboratory-work-wet-lab)
    - [Step 1: Sample Collection](#step-1-sample-collection)
    - [Step 2: Bacterial Culture and Isolation](#step-2-bacterial-culture-and-isolation)
    - [Step 3: DNA Extraction](#step-3-dna-extraction)
    - [Step 4: DNA Quality Assessment](#step-4-dna-quality-assessment)
    - [Step 5: Library Preparation](#step-5-library-preparation)
    - [Step 6: Sequencing](#step-6-sequencing)
  - [Phase 2: Bioinformatics Analysis (Dry Lab)](#phase-2-bioinformatics-analysis-dry-lab)
    - [Step 7: Raw Data Acquisition](#step-7-raw-data-acquisition)
    - [Step 8: Quality Control](#step-8-quality-control)
    - [Step 9: Genome Assembly](#step-9-genome-assembly)
    - [Step 10: Assembly Quality Assessment](#step-10-assembly-quality-assessment)
    - [Step 11: Contamination Screening](#step-11-contamination-screening)
    - [Step 12: Genome Annotation](#step-12-genome-annotation)
    - [Step 13: Functional Analysis](#step-13-functional-analysis)
  - [Phase 3: NCBI Submission](#phase-3-ncbi-submission)
    - [Step 14: Prepare for Submission](#step-14-prepare-for-submission)
    - [Step 15: BioProject Registration](#step-15-bioproject-registration)
    - [Step 16: BioSample Registration](#step-16-biosample-registration)
    - [Step 17: SRA Submission (Raw Reads)](#step-17-sra-submission-raw-reads)
    - [Step 18: Genome Submission to GenBank](#step-18-genome-submission-to-genbank)
    - [Step 19: Post-Submission](#step-19-post-submission)
  - [Complete Pipeline Script](#complete-pipeline-script)
  - [Quality Metrics Reference](#quality-metrics-reference)
  - [Common Issues and Solutions](#common-issues-and-solutions)
  - [Tools Summary](#tools-summary)
  - [Desi Style Understanding 🇵🇰](#desi-style-understanding-)
    - [Complete Workflow: Biryani Recipe Style](#complete-workflow-biryani-recipe-style)
    - [NCBI Submission: Visa Application Style](#ncbi-submission-visa-application-style)
  - [Summary](#summary)
  - [Practice Exercise](#practice-exercise)
  - [Additional Resources](#additional-resources)

---

## Introduction

This guide provides a complete workflow for bacterial genome sequencing, from sample collection in the laboratory to submitting a finished, annotated genome to NCBI databases.

**Prerequisites:** Understanding of [Genes and Genomes](./genes_and_genomes.md)

**What you'll learn:**
1. Wet lab procedures for DNA extraction and sequencing
2. Bioinformatics pipeline for assembly and annotation
3. NCBI submission process for genome data

---

## Workflow Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    BACTERIAL GENOME SEQUENCING WORKFLOW                  │
└─────────────────────────────────────────────────────────────────────────┘

PHASE 1: WET LAB                    PHASE 2: DRY LAB                    PHASE 3: SUBMISSION
═══════════════════                 ═══════════════════                 ═══════════════════

┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 1. Sample   │                     │ 7. Raw Data │                     │14. Prepare  │
│   Collection│                     │   (FASTQ)   │                     │   Metadata  │
└──────┬──────┘                     └──────┬──────┘                     └──────┬──────┘
       ↓                                   ↓                                   ↓
┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 2. Culture  │                     │ 8. Quality  │                     │15. BioProject│
│   Isolation │                     │   Control   │                     │   Register  │
└──────┬──────┘                     └──────┬──────┘                     └──────┬──────┘
       ↓                                   ↓                                   ↓
┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 3. DNA      │                     │ 9. Assembly │                     │16. BioSample│
│   Extraction│                     │   (SPAdes)  │                     │   Register  │
└──────┬──────┘                     └──────┬──────┘                     └──────┬──────┘
       ↓                                   ↓                                   ↓
┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 4. QC Check │                     │10. Assembly │                     │17. SRA      │
│   (Qubit)   │                     │   QC (QUAST)│                     │   Submission│
└──────┬──────┘                     └──────┬──────┘                     └──────┬──────┘
       ↓                                   ↓                                   ↓
┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 5. Library  │                     │11. Contam.  │                     │18. GenBank  │
│   Prep      │                     │   Check     │                     │   Submission│
└──────┬──────┘                     └──────┬──────┘                     └──────┬──────┘
       ↓                                   ↓                                   ↓
┌─────────────┐                     ┌─────────────┐                     ┌─────────────┐
│ 6. Sequenc- │                     │12. Annotate │                     │19. Accession│
│   ing       │────────────────────→│   (Prokka)  │────────────────────→│   Numbers   │
└─────────────┘                     └──────┬──────┘                     └─────────────┘
                                           ↓
                                    ┌─────────────┐
                                    │13. Functional│
                                    │   Analysis  │
                                    └─────────────┘
```

---

## Phase 1: Laboratory Work (Wet Lab)

> **Note:** As a bioinformatician, you may receive samples at various stages. Understanding the wet lab process helps you interpret data quality issues.

### Step 1: Sample Collection

**Objective:** Obtain bacterial isolate for sequencing

```
Sample Sources:
├── Clinical samples (patient isolates)
├── Environmental samples (soil, water)
├── Food samples
├── Research cultures
└── Culture collections (ATCC, DSMZ)
```

**Required Documentation:**
- Sample source and date
- Collection location
- Host organism (if applicable)
- Isolation conditions
- Strain identification (if known)

---

### Step 2: Bacterial Culture and Isolation

**Objective:** Obtain pure culture of single bacterial strain

```
Culture Process:
1. Streak plate for isolation
2. Select single colony
3. Subculture to fresh media
4. Confirm purity (microscopy, biochemical tests)
5. Grow overnight culture (12-16 hours)
```

**Quality Checks:**
- Colony morphology
- Gram staining
- 16S rRNA identification (optional at this stage)

---

### Step 3: DNA Extraction

**Objective:** Extract high-quality genomic DNA

**Common Methods:**

| Method | Quality | Yield | Time | Best For |
|--------|---------|-------|------|----------|
| **Phenol-Chloroform** | Excellent | High | Long | Long-read sequencing |
| **Commercial Kits** | Good | Moderate | Short | Routine work |
| **Bead Beating** | Variable | High | Short | Difficult-to-lyse bacteria |
| **Enzymatic Lysis** | Good | Moderate | Moderate | Gram-positive bacteria |

**For Long-Read Sequencing (Nanopore/PacBio):**
```
Requirements:
- High molecular weight DNA (>20 kb fragments)
- Minimal shearing
- Use gentle extraction methods
- Avoid vortexing
```

---

### Step 4: DNA Quality Assessment

**Objective:** Verify DNA is suitable for sequencing

| Method | Measures | Good Quality |
|--------|----------|--------------|
| **NanoDrop** | A260/A280 ratio | 1.8-2.0 |
| **NanoDrop** | A260/A230 ratio | 2.0-2.2 |
| **Qubit** | DNA concentration | >10 ng/μL |
| **Agarose Gel** | Integrity | Single high MW band |
| **TapeStation** | Size distribution | >10 kb for long-read |

```
Quality Check Results:

GOOD DNA:                           BAD DNA:
                                    
|                                   |    ████
|                                   |    ████
|  ████                             |    ████
|  ████                             |    ████████████
|  ████                             |    ████████████████
└────────────                       └────────────────────────
High MW band only                   Smear = degraded DNA
```

---

### Step 5: Library Preparation

**Objective:** Prepare DNA for sequencing platform

**Illumina Library Prep:**
```
1. Fragment DNA (sonication or enzymatic)
2. End repair
3. A-tailing
4. Adapter ligation
5. Size selection (optional)
6. PCR amplification (if needed)
7. Library QC and quantification
```

**Nanopore Library Prep:**
```
1. DNA repair
2. End prep
3. Adapter ligation
4. Library quantification
```

---

### Step 6: Sequencing

**Platform Selection:**

| Platform | Read Length | Output | Error Rate | Best For |
|----------|-------------|--------|------------|----------|
| **Illumina MiSeq** | 2×300 bp | 15 Gb | 0.1% | Small genomes, amplicons |
| **Illumina NextSeq** | 2×150 bp | 120 Gb | 0.1% | Multiple genomes |
| **Nanopore MinION** | 10kb-2Mb | 50 Gb | 5-15% | Complete genomes |
| **PacBio Sequel** | 10-25 kb HiFi | 90 Gb | <1% (HiFi) | High-quality complete genomes |

**Recommended Coverage:**

```
Minimum coverage for bacterial genomes:
├── Short reads only: 50-100×
├── Long reads only: 30-50×
└── Hybrid (short + long): 50× short + 20× long
```

---

## Phase 2: Bioinformatics Analysis (Dry Lab)

### Step 7: Raw Data Acquisition

**Objective:** Obtain and organize sequence data

```bash
# Create project directory structure
mkdir -p bacterial_genome_project/{raw_data,qc,assembly,annotation,submission}
cd bacterial_genome_project

# Typical file structure after sequencing
raw_data/
├── sample_R1.fastq.gz    # Illumina Read 1
├── sample_R2.fastq.gz    # Illumina Read 2
└── sample_nanopore.fastq.gz  # Nanopore reads (if hybrid)
```

**Check raw data:**
```bash
# Count reads
zcat raw_data/sample_R1.fastq.gz | echo $((`wc -l`/4))

# Quick look at file
zcat raw_data/sample_R1.fastq.gz | head -n 12
```

---

### Step 8: Quality Control

**8.1 Initial Quality Assessment (FastQC)**

```bash
# Create conda environment
conda create -n genome_assembly -y
conda activate genome_assembly
conda install -c bioconda fastqc fastp spades quast prokka busco checkm-genome -y

# Run FastQC
mkdir -p qc/fastqc_raw
fastqc -o qc/fastqc_raw -t 8 raw_data/*.fastq.gz

# Aggregate with MultiQC
conda activate multiqc
multiqc -o qc/multiqc_raw qc/fastqc_raw
```

**8.2 Quality Trimming and Filtering (fastp)**

```bash
conda activate genome_assembly

# For Illumina paired-end reads
fastp \
    --in1 raw_data/sample_R1.fastq.gz \
    --in2 raw_data/sample_R2.fastq.gz \
    --out1 qc/sample_R1_clean.fastq.gz \
    --out2 qc/sample_R2_clean.fastq.gz \
    --html qc/fastp_report.html \
    --json qc/fastp_report.json \
    --thread 8 \
    --qualified_quality_phred 20 \
    --length_required 50 \
    --cut_front \
    --cut_tail \
    --cut_mean_quality 20 \
    --detect_adapter_for_pe

# For Nanopore reads (minimal filtering)
pip install NanoFilt
gunzip -c raw_data/sample_nanopore.fastq.gz | NanoFilt -q 10 -l 1000 | gzip > qc/sample_nanopore_clean.fastq.gz
```

**8.3 Post-trimming QC**

```bash
mkdir -p qc/fastqc_clean
fastqc -o qc/fastqc_clean -t 8 qc/*_clean.fastq.gz
```

---

### Step 9: Genome Assembly

**9.1 Short-Read Assembly (SPAdes)**

```bash
spades.py \
    -1 qc/sample_R1_clean.fastq.gz \
    -2 qc/sample_R2_clean.fastq.gz \
    -o assembly/spades_output \
    --careful \
    --cov-cutoff auto \
    -t 16 \
    -m 32
```

**9.2 Long-Read Assembly (Flye)**

```bash
conda install -c bioconda flye

flye \
    --nano-raw qc/sample_nanopore_clean.fastq.gz \
    --out-dir assembly/flye_output \
    --threads 16 \
    --genome-size 5m
```

**9.3 Hybrid Assembly (Unicycler)**

```bash
conda install -c bioconda unicycler

unicycler \
    -1 qc/sample_R1_clean.fastq.gz \
    -2 qc/sample_R2_clean.fastq.gz \
    -l qc/sample_nanopore_clean.fastq.gz \
    -o assembly/unicycler_output \
    -t 16 \
    --min_fasta_length 1000
```

---

### Step 10: Assembly Quality Assessment

**10.1 Basic Assembly Statistics**

```bash
conda install -c bioconda seqkit
seqkit stats assembly/spades_output/contigs.fasta
```

**10.2 QUAST Analysis**

```bash
quast.py \
    assembly/spades_output/contigs.fasta \
    -o qc/quast_report \
    --threads 8 \
    -L
```

**Key QUAST Metrics:**

| Metric | Meaning | Good Value |
|--------|---------|------------|
| **N50** | 50% of assembly in contigs ≥ this size | >100 kb |
| **L50** | Number of contigs comprising 50% of assembly | <10 |
| **# Contigs** | Total number of contigs | <100 |
| **Largest Contig** | Size of biggest contig | >500 kb |
| **Total Length** | Sum of all contigs | Close to expected genome size |

**10.3 Completeness Check (BUSCO)**

```bash
busco \
    -i assembly/spades_output/contigs.fasta \
    -o qc/busco_output \
    -l bacteria_odb10 \
    -m genome \
    -c 8
```

**BUSCO Quality Standards:**

| Category | Percentage | Quality |
|----------|------------|---------|
| Complete | >95% | ✅ Excellent |
| Complete | 90-95% | ✅ Good |
| Complete | 80-90% | ⚠️ Acceptable |
| Complete | <80% | ❌ Poor |

**10.4 CheckM Analysis**

```bash
conda install -c bioconda checkm-genome

checkm lineage_wf \
    assembly/spades_output/ \
    qc/checkm_output \
    -x fasta \
    -t 8

checkm qa qc/checkm_output/lineage.ms qc/checkm_output/ -f qc/checkm_results.txt
```

---

### Step 11: Contamination Screening

```bash
conda install -c bioconda kraken2

# Run Kraken2 on assembly
kraken2 \
    --db kraken2_db \
    --threads 8 \
    --report qc/kraken2_report.txt \
    --output qc/kraken2_output.txt \
    assembly/spades_output/contigs.fasta
```

---

### Step 12: Genome Annotation

**12.1 Prokka Annotation**

```bash
prokka \
    assembly/spades_output/contigs.fasta \
    --outdir annotation/prokka_output \
    --prefix sample_genome \
    --kingdom Bacteria \
    --genus Escherichia \
    --species coli \
    --strain SAMPLE001 \
    --locustag SAMPLE \
    --cpus 8 \
    --rfam \
    --addgenes
```

**Output files:**
```
annotation/prokka_output/
├── sample_genome.fna    # Nucleotide FASTA
├── sample_genome.faa    # Protein FASTA
├── sample_genome.ffn    # CDS nucleotide FASTA
├── sample_genome.gff    # GFF3 annotation
├── sample_genome.gbk    # GenBank format
├── sample_genome.sqn    # Sequin format (for NCBI)
└── sample_genome.txt    # Statistics
```

**12.2 Additional Annotations**

```bash
conda install -c bioconda abricate

# Antibiotic resistance genes
abricate --db resfinder assembly/spades_output/contigs.fasta > annotation/abricate_resfinder.txt
abricate --db card assembly/spades_output/contigs.fasta > annotation/abricate_card.txt

# Virulence factors
abricate --db vfdb assembly/spades_output/contigs.fasta > annotation/abricate_vfdb.txt
```

---

### Step 13: Functional Analysis

**13.1 Antimicrobial Resistance Genes**

```bash
conda install -c bioconda ncbi-amrfinderplus
amrfinder --update

amrfinder \
    -p annotation/prokka_output/sample_genome.faa \
    -n assembly/spades_output/contigs.fasta \
    -g annotation/prokka_output/sample_genome.gff \
    -o annotation/amrfinder_results.txt \
    --plus
```

---

## Phase 3: NCBI Submission

### Step 14: Prepare for Submission

**14.1 Required Information**

```yaml
organism:
  scientific_name: "Escherichia coli"
  strain: "SAMPLE001"
  
sample:
  collection_date: "2024-01-15"
  geo_loc_name: "Pakistan: Lahore"
  isolation_source: "human stool"
  host: "Homo sapiens"
  
sequencing:
  platform: "Illumina MiSeq"
  library_strategy: "WGS"
  library_source: "GENOMIC"
  library_selection: "RANDOM"
  
assembly:
  method: "SPAdes"
  version: "3.15.5"
  coverage: "100x"
```

**14.2 File Preparation**

```bash
mkdir -p submission
cp assembly/spades_output/contigs.fasta submission/sample_genome.fasta

# Filter short contigs (NCBI requires >200 bp)
seqkit seq -m 200 submission/sample_genome.fasta > submission/sample_genome_filtered.fasta
```

---

### Step 15: BioProject Registration

**Go to:** https://submit.ncbi.nlm.nih.gov/subs/bioproject/

```
Fill in the form:
1. Project type: Genome sequencing
2. Sample scope: Monoisolate
3. Organism: Your species name
4. Project title: Descriptive title
5. Description: Project summary

Submit and save: PRJNAXXXXXX (BioProject accession)
```

---

### Step 16: BioSample Registration

**Go to:** https://submit.ncbi.nlm.nih.gov/subs/biosample/

```
1. Select package: Pathogen: clinical or host-associated OR Microbe
2. Fill required attributes:
   - sample_name, organism, strain
   - collection_date, geo_loc_name
   - isolation_source, host (if applicable)
3. Link to BioProject: PRJNAXXXXXX

Submit and save: SAMNXXXXXXXX (BioSample accession)
```

---

### Step 17: SRA Submission (Raw Reads)

**Go to:** https://submit.ncbi.nlm.nih.gov/subs/sra/

```bash
mv raw_data/sample_R1.fastq.gz submission/SAMPLE001_R1.fastq.gz
mv raw_data/sample_R2.fastq.gz submission/SAMPLE001_R2.fastq.gz
```

---

### Step 18: Genome Submission to GenBank

**Go to:** https://submit.ncbi.nlm.nih.gov/subs/genome/

```
1. Submission type: Genome
2. Assembly method: SPAdes, Coverage: 100x
3. Link BioProject and BioSample
4. Upload FASTA file
```

---

### Step 19: Post-Submission

```
1. Wait for NCBI processing (few days to weeks)
2. Respond to any validation errors
3. Receive accession numbers:
   - BioProject: PRJNAXXXXXX
   - BioSample: SAMNXXXXXXXX
   - SRA: SRRxxxxxxxx (raw reads)
   - GenBank: CP123456 (complete) or JABCDE010000001-N (WGS)
   
4. Update publication with accession numbers
```

---

## Complete Pipeline Script

```bash
#!/bin/bash
#=============================================================================
# BACTERIAL GENOME ASSEMBLY AND ANNOTATION PIPELINE
#=============================================================================

SAMPLE="sample_001"
THREADS=16
PROJECT_DIR="/home/codanics/genome_project/${SAMPLE}"

mkdir -p ${PROJECT_DIR}/{raw_data,qc,assembly,annotation,submission}

echo "=========================================="
echo "Starting Bacterial Genome Pipeline: ${SAMPLE}"
echo "=========================================="

# Step 1: Quality Control
conda activate genome_assembly
fastqc -o ${PROJECT_DIR}/qc -t ${THREADS} ${PROJECT_DIR}/raw_data/*.fastq.gz

fastp \
    --in1 ${PROJECT_DIR}/raw_data/${SAMPLE}_R1.fastq.gz \
    --in2 ${PROJECT_DIR}/raw_data/${SAMPLE}_R2.fastq.gz \
    --out1 ${PROJECT_DIR}/qc/${SAMPLE}_R1_clean.fastq.gz \
    --out2 ${PROJECT_DIR}/qc/${SAMPLE}_R2_clean.fastq.gz \
    --html ${PROJECT_DIR}/qc/fastp_report.html \
    --thread ${THREADS} -q 20 -l 50 --detect_adapter_for_pe

# Step 2: Assembly
spades.py \
    -1 ${PROJECT_DIR}/qc/${SAMPLE}_R1_clean.fastq.gz \
    -2 ${PROJECT_DIR}/qc/${SAMPLE}_R2_clean.fastq.gz \
    -o ${PROJECT_DIR}/assembly/spades \
    --careful -t ${THREADS}

# Step 3: Quality Assessment
quast.py ${PROJECT_DIR}/assembly/spades/contigs.fasta -o ${PROJECT_DIR}/qc/quast -t ${THREADS}
busco -i ${PROJECT_DIR}/assembly/spades/contigs.fasta -o busco_${SAMPLE} -l bacteria_odb10 -m genome -c ${THREADS}

# Step 4: Annotation
prokka ${PROJECT_DIR}/assembly/spades/contigs.fasta \
    --outdir ${PROJECT_DIR}/annotation/prokka \
    --prefix ${SAMPLE} --kingdom Bacteria --cpus ${THREADS}

# Step 5: Prepare for Submission
seqkit seq -m 200 ${PROJECT_DIR}/assembly/spades/contigs.fasta > ${PROJECT_DIR}/submission/${SAMPLE}_filtered.fasta

echo "Pipeline Complete! Check ${PROJECT_DIR}/submission/"
```

---

## Quality Metrics Reference

```
Excellent Assembly:
├── Contigs: <20
├── N50: >500 kb
├── BUSCO Complete: >98%
├── CheckM Completeness: >99%
├── CheckM Contamination: <1%

Good Assembly:
├── Contigs: <50
├── N50: >100 kb
├── BUSCO Complete: >95%
├── CheckM Contamination: <5%

NCBI Requirements:
├── Contamination: <5% other species
├── Minimum contig length: 200 bp
├── No adapters or vector sequences
```

---

## Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| Poor assembly (high contigs) | Increase coverage, try hybrid assembly |
| Contamination detected | Use BlobTools to filter, re-extract DNA |
| Low BUSCO completeness | Try different assembler, verify BUSCO lineage |
| NCBI submission errors | Run FCS-GX, ensure unique locus tags |

---

## Tools Summary

| Tool | Purpose | Installation |
|------|---------|--------------|
| **FastQC** | Read quality | `conda install -c bioconda fastqc` |
| **fastp** | Trimming | `conda install -c bioconda fastp` |
| **SPAdes** | Short-read assembly | `conda install -c bioconda spades` |
| **Flye** | Long-read assembly | `conda install -c bioconda flye` |
| **Unicycler** | Hybrid assembly | `conda install -c bioconda unicycler` |
| **QUAST** | Assembly QC | `conda install -c bioconda quast` |
| **BUSCO** | Completeness | `conda install -c bioconda busco` |
| **Prokka** | Annotation | `conda install -c bioconda prokka` |

---

## Desi Style Understanding 🇵🇰

### Complete Workflow: Biryani Recipe Style

```
PHASE 1: KHANA LAANA (Wet Lab)
═══════════════════════════════
Step 1: Bazaar se saamaan lana (Sample Collection)
Step 2: Saamaan saaf karna (Culture/Isolation)  
Step 3: Tayyari karna (DNA Extraction)
Step 4: Quality check → "Cheezein fresh hain ya nahi?"

PHASE 2: PAKAANA (Dry Lab)
═══════════════════════════
Step 5: Biryani banana (Assembly)
Step 6: Taste karna (Quality Assessment) → "Namak theek hai?"
Step 7: Garnishing (Annotation)

PHASE 3: MEHMAN KO DENA (NCBI Submission)
═════════════════════════════════════════
Step 8: Plating (Prepare files)
Step 9: Serve karna (Submit) + Recipe share karna
```

### NCBI Submission: Visa Application Style

```
NCBI = Embassy for Genomes 🏛️

BioProject = Visa Purpose → "Main research ke liye ja raha hoon"
BioSample = Personal Details → "Bacteria kaun hai, kahan se hai"
SRA = Bank Statement → "Dekho, mere paas itne reads hain"
GenBank = Final Visa → Accession Number = Passport Stamp ✅
```

---

## Summary

| Phase | Steps | Key Output |
|-------|-------|------------|
| **Wet Lab** | Sample → Culture → DNA → Library → Sequencing | FASTQ files |
| **Dry Lab** | QC → Assembly → Quality Check → Annotation | Annotated genome |
| **Submission** | BioProject → BioSample → SRA → GenBank | Accession numbers |

---

## Practice Exercise

```bash
# Download practice dataset (E. coli)
fastq-dump --split-files SRR10971381 --gzip

# Follow the pipeline in this guide
# Target metrics:
# - N50 > 100 kb
# - BUSCO > 95%
# - Identify the species using Kraken2
```

---

## Additional Resources

- **NCBI Genome Submission Guide**: https://www.ncbi.nlm.nih.gov/genbank/genomesubmit/
- **SPAdes Manual**: https://github.com/ablab/spades
- **Prokka Documentation**: https://github.com/tseemann/prokka

---

**Happy Genome Sequencing! 🧬💻**

---


