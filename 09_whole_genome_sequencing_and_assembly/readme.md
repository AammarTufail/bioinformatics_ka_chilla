# Whole Genome Sequencing and Assembly Guide

Complete workflow for bacterial genome assembly using short reads, long reads, and hybrid approaches is at the [following repository](https://github.com/AammarTufail/hybrid_genome_assembly_guide_bkc).

This guide provides a comprehensive, step-by-step workflow for assembling bacterial genomes using short reads, long reads, and hybrid approaches. It covers raw data acquisition, quality control, assembly, quality assessment, and annotation, with all commands and scripts provided for reproducibility.

---

## Table of Contents

- [Whole Genome Sequencing and Assembly Guide](#whole-genome-sequencing-and-assembly-guide)
  - [Table of Contents](#table-of-contents)
  - [**Bioinformatics ka Chilla**](#bioinformatics-ka-chilla)
  - [Overview](#overview)
  - [Workflow Summary](#workflow-summary)
  - [Step 1: Download Raw Reads](#step-1-download-raw-reads)
    - [1.1. Install grabseqs](#11-install-grabseqs)
    - [1.2. Download raw reads](#12-download-raw-reads)
  - [Step 2: Tool Installation](#step-2-tool-installation)
    - [2.1. Run the installation script](#21-run-the-installation-script)
  - [Step 3: Data Preparation and Quality Control](#step-3-data-preparation-and-quality-control)
    - [3.1. Rename and organize raw reads](#31-rename-and-organize-raw-reads)
    - [3.2. Short Read Quality Control](#32-short-read-quality-control)
    - [3.3. Short Read Preprocessing](#33-short-read-preprocessing)
    - [3.4. Long Read Quality Control](#34-long-read-quality-control)
    - [3.5. Long Read Preprocessing](#35-long-read-preprocessing)
  - [Step 4: Genome Assembly](#step-4-genome-assembly)
  - [Step 5: Genome Quality Assessment](#step-5-genome-quality-assessment)
  - [Step 6: Genome Annotation](#step-6-genome-annotation)
  - [Running the Analysis](#running-the-analysis)
  - [Script Reference](#script-reference)
  - [Video Playlist](#video-playlist)
  - [Notes](#notes)
  - [Troubleshooting](#troubleshooting)
  - [Acknowledgements](#acknowledgements)

---

## **Bioinformatics ka Chilla** 
> Here is the complete detail about Bioinformatics ka Chilla, [register here](https://codanics.com/bioinformatics-ka-chilla/).   


## Overview

Genome assembly is the process of reconstructing a genome from sequencing reads. This guide demonstrates three approaches:

- **Short-read assembly** (Illumina)
- **Long-read assembly** (Nanopore/PacBio)
- **Hybrid assembly** (combining both)

We use conda environments for reproducible tool installation and provide bash scripts for each analysis step.

---

## Workflow Summary

1. **Download raw reads** (using grabseqs)
2. **Install required tools** (via conda)
3. **Quality control and preprocessing** (FastQC, fastp, NanoPlot, NanoFilt)
4. **Genome assembly** (Unicycler)
5. **Assembly quality assessment** (CheckM2, QUAST, BUSCO)
6. **Genome annotation** (Prokka, Bakta)

---

## Step 1: Download Raw Reads

We use [grabseqs](https://github.com/czbiohub/grabseqs) to download sequencing data from SRA.

### 1.1. Install grabseqs

```bash
# install grabseqs
conda create -n grabseqs -y
conda activate grabseqs
conda install python=3.9 -y
pip install grabseqs
# dependencies
conda install conda-forge::pigz -y
conda install bioconda::sra-tools -y
grabseqs --help
```

### 1.2. Download raw reads

```bash
conda activate grabseqs
# Download Illumina short reads
grabseqs sra -t 4 -m metadata.csv -o ./01_raw_reads/short_reads -r 4 SRR8893090

# Download Nanopore long reads (two runs)
grabseqs sra -t 4 -m metadata.csv -o ./01_raw_reads/long_reads -r 4 SRR8893087
grabseqs sra -t 4 -m metadata.csv -o ./01_raw_reads/long_reads -r 4 SRR8893086

# Download PacBio long reads
grabseqs sra -t 4 -m metadata.csv -o ./01_raw_reads/long_reads -r 4 SRR8893091
```

---

## Step 2: Tool Installation

All required tools are installed using conda environments for reproducibility. The script [`installation.sh`](./installation.sh) automates this process.

### 2.1. Run the installation script

```bash
bash installation.sh
```

This script sets up environments for:

- Short read QC: `fastqc`, `fastp`
- MultiQC for report aggregation
- Long read QC: `NanoPlot`, `NanoFilt`, `Filtlong`
- Assembly: `Unicycler`
- Quality assessment: `CheckM2`, `QUAST`, `BUSCO`
- Annotation: `Prokka`, `Bakta`

It also downloads necessary databases for CheckM2 and Bakta.

---

## Step 3: Data Preparation and Quality Control

All analysis steps are automated in [`analysis.sh`](./analysis.sh). Below, each step is explained.

### 3.1. Rename and organize raw reads

Raw reads are renamed for consistency and directories are created for each analysis stage.

### 3.2. Short Read Quality Control

- **FastQC**: Generates quality reports for raw short reads.
- **MultiQC**: Aggregates FastQC reports for easy review.

### 3.3. Short Read Preprocessing

- **fastp**: Performs quality trimming and filtering of short reads, generating processed files and reports.

### 3.4. Long Read Quality Control

- **NanoPlot**: Visualizes quality metrics for raw and processed long reads.

### 3.5. Long Read Preprocessing

- **NanoFilt**: Filters long reads by quality and length, and crops low-quality bases.
- **Filtlong**: (Optional, commented) Further filters long reads by length and quality.

---

## Step 4: Genome Assembly

- **Unicycler** is used for all assembly strategies:
  - **Short-read only**
  - **Long-read only**
  - **Hybrid (short + long reads)**

Each assembly is output to a separate directory.

---

## Step 5: Genome Quality Assessment

Three tools are used to assess assembly quality:

- **CheckM2**: Estimates completeness and contamination.
- **QUAST**: Provides assembly statistics and gene finding.
- **BUSCO**: Assesses completeness using single-copy orthologs.

Each tool is run on all three assemblies (short, long, hybrid).

---

## Step 6: Genome Annotation

Two annotation tools are provided:

- **Prokka**: Rapid prokaryotic genome annotation.
- **Bakta**: Modern annotation tool with up-to-date databases.

Both tools are run on all assemblies.

---

## Running the Analysis

After installing tools, run the analysis script:

```bash
bash analysis.sh
```

This script will:

1. Prepare directories and rename files
2. Run all QC, preprocessing, assembly, quality assessment, and annotation steps as described above

---

## Script Reference
> Note: Ensure conda environments are activated properly within scripts. and adjust paths as necessary before running.

- [`installation.sh`](./installation.sh): Installs all required tools and databases.
- [`analysis.sh`](./analysis.sh): Runs the full analysis workflow, step by step.
## Video Playlist


[![Genome Assembly Live Stream](https://img.youtube.com/vi/_7ebzDCXIi4/0.jpg)](https://www.youtube.com/playlist?list=PL9XvIvvVL50FmcR4XE7GCNLXPfzy215HX)

Watch the full step-by-step video guide on YouTube:  
[Genome Assembly Playlist](https://www.youtube.com/playlist?list=PL9XvIvvVL50FmcR4XE7GCNLXPfzy215HX)

---

## Notes

- Adjust thread counts (`-t`, `-c`, `-w`) as appropriate for your hardware.
- Ensure all database paths are correct and accessible.
- For BUSCO, download the required lineage datasets as needed.

---

## Troubleshooting

- If a conda environment fails to activate within a script, ensure you are using `eval "$(conda shell.bash hook)"` at the start of your shell session or script.
- Database downloads may require sufficient disk space and a stable internet connection.

---

## Acknowledgements

This guide was prepared for educational purposes to help students understand and perform bacterial genome assembly using modern bioinformatics tools.

---

