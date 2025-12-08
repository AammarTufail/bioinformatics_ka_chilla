# GrabSeqs: NCBI Sequence Data Retrieval Tool

## Overview
GrabSeqs is a critical bioinformatics utility designed to streamline the download of sequencing data from NCBI's Sequence Read Archive (SRA). It simplifies the complex process of fetching high-throughput sequencing data using standardized identifiers (SRR/SRP accessions), making large-scale genomic data acquisition more accessible and efficient.

## Why GrabSeqs is Important

### Simplified Data Retrieval
- **Automated Downloads**: Eliminates manual navigation through NCBI web interfaces
- **Batch Processing**: Download entire projects (SRP) or individual runs (SRR) with single commands
- **Metadata Management**: Automatically retrieves and organizes associated metadata

### Standardized Accession Support
- **SRR (Single Run)**: Individual sequencing run accessions (e.g., SRR35136585)
- **SRP (Project)**: Complete project accessions containing multiple runs (e.g., SRP610834)

### Research Benefits
- Ensures reproducibility by using stable NCBI accessions
- Facilitates meta-analyses and comparative genomics studies
- Reduces manual errors in data acquisition workflows

## Installation
```bash
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
```

## Usage

### Download Individual Sequences
To download a single sequencing run using its SRR accession:
```bash
grabseqs sra SRR35136585
```

### Download Entire Projects
To retrieve all sequencing runs from a complete project using its SRP accession:
```bash
grabseqs sra SRP610834
```

### Advanced Options with Threads and Metadata
Use `-t` to specify the number of threads for faster downloads, and `-m` to save associated metadata to a CSV file:
```bash
grabseqs sra -t 4 -m metadata.csv SRR8893090
```

## Additional Resources
- [GrabSeqs Documentation](https://louiejtaylor.github.io/grabseqs
- [NCBI SRA Toolkit](https://github.com/ncbi/sra-tools)
- [NCBI Sequence Read Archive](https://www.ncbi.nlm.nih.gov/sra)
- [Bioconda Package](https://bioconda.github.io/recipes/grabseqs/README.html)