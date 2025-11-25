# 🐧 Basic Linux Commands for Bioinformatics

## Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [File System Navigation](#file-system-navigation)
4. [File and Directory Operations](#file-and-directory-operations)
5. [Viewing and Reading Files](#viewing-and-reading-files)
6. [File Manipulation](#file-manipulation)
7. [File Permissions](#file-permissions)
8. [Searching and Finding](#searching-and-finding)
9. [Process Management](#process-management)
10. [System Information](#system-information)
11. [Bioinformatics-Specific Commands](#bioinformatics-specific-commands)
12. [Practice Exercises](#practice-exercises)

---

## Introduction

Linux command line is essential for bioinformatics work. Most bioinformatics tools, servers, and high-performance computing (HPC) systems use Linux. This guide will help you master the basic commands needed for your bioinformatics journey.

### Why Learn Linux for Bioinformatics?

- 🔬 Most bioinformatics tools are designed for Linux
- 💻 Remote servers and HPC clusters run on Linux
- 🚀 Faster processing of large genomic datasets
- 🔄 Easy automation of repetitive tasks
- 📊 Better file management for large-scale data analysis

---

## Getting Started

### Install Linux Mint

Watch this complete playllist to install and learn Linux Mint with dual boot option with Windows: [Linux Mint for Bioinformatics Playlist](https://www.youtube.com/playlist?list=PL9XvIvvVL50E9w6rLV3h_KFd4ZKl0tm9U)

### Opening the Terminal

#### Linux Mint:
- **Method 1**: Click Menu → Terminal
- **Method 2**: Press `Ctrl + Alt + T` (recommended - fastest way)
- **Method 3**: Right-click on desktop → Open in Terminal

### Understanding the Command Prompt

When you open the terminal, you'll see something like this:

```bash
codanics@PC-codanics:~$
```

> you may have different username and computer name based on your setup.

**What does this mean?**

- `codanics`: Your username
- `@`: Separator (literally means "at")
- `PC-codanics`: Computer hostname
- `~`: Current directory (tilde `~` represents your home directory)
- `$`: Regular user prompt
    - `#`: Root/administrator prompt (be careful!)

**Your Home Directory:**
- **Linux Mint**: `/home/codanics/`

---

> now you will see the basic linux commands used in bioinformatics and any data science related work with examples and use cases.

## File System Navigation

### 1. `pwd` - Print Working Directory

Shows your current location in the file system.

```bash
pwd
```

**Output Example:**
```
/home/codanics/bioinformatics_projects
```

**Use Case in Bioinformatics:**
- Verify you're in the correct project directory before running analysis
- Confirm location when organizing genomic data files

---

### 2. `ls` - List Directory Contents

Lists files and directories in the current location.

#### Basic Usage:

```bash
ls
```

**Output Example:**
```
data  scripts  results  references
```

#### `ls -l` - Long Format (Detailed List)

```bash
ls -l
```

**Output Example:**
```
drwxr-xr-x 2 codanics codanics 4096 Nov 15 10:30 data
drwxr-xr-x 2 codanics codanics 4096 Nov 15 10:31 scripts
drwxr-xr-x 2 codanics codanics 4096 Nov 15 10:32 results
-rw-r--r-- 1 codanics codanics 2048 Nov 15 10:33 genome.fasta
```

**Column Breakdown:**
- Column 1: File permissions (d = directory, - = file)
- Column 2: Number of links
- Column 3: Owner
- Column 4: Group
- Column 5: File size (bytes)
- Column 6-8: Last modified date and time
- Column 9: File/directory name

#### `ls -a` - Show Hidden Files

```bash
ls -a
```

Shows files starting with `.` (hidden files like `.bashrc`, `.gitignore`)

#### `ls -al` - Long Format with Hidden Files

```bash
ls -al
```

Combines both `-a` and `-l` options.

#### `ls -lh` - Human-Readable File Sizes

```bash
ls -lh
```

**Output Example:**
```
-rw-r--r-- 1 codanics codanics 2.5G Nov 15 10:33 genome.fasta
-rw-r--r-- 1 codanics codanics 150M Nov 15 10:34 reads_R1.fastq
```

Shows sizes in KB, MB, GB instead of bytes.

#### `ls -lt` - Sort by Modification Time

```bash
ls -lt
```

Lists files with newest first (useful for finding recently downloaded data).

#### `ls -lS` - Sort by File Size

```bash
ls -lS
```

Lists files with largest first (helpful for identifying large genomic files).

**Practical Examples:**

```bash
# List all files with detailed information
codanics@PC-codanics:~/projects$ ls -lah
total 25G
drwxr-xr-x  6 codanics codanics 4.0K Nov 15 10:30 .
drwxr-xr-x  3 codanics codanics 4.0K Nov 15 10:30 ..
-rw-r--r--  1 codanics codanics  25G Nov 15 10:33 genome.fasta
```

---

### 3. `cd` - Change Directory

Navigate between directories.

#### Basic Usage:

> Concepts you need to learn before using `cd`:
>   - `.` (dot) represents the current directory
>  - `..` (double dot) represents the parent directory
>  - `-` (dash) represents the previous directory
> Parent directory is the directory that contains the current directory.
> For example, if you are in `/home/codanics/projects`, the parent directory is `/home/codanics`.

Here is an example of directory structure to help you understand navigation:
```
/ (root)
├── home
│   └── codanics
│       ├── projects
│       │   └── bioinformatics
│       └── data
└── etc
```
>**/ (root)** is the top-level directory. Under root, there is `home`, which contains the user `codanics`. Inside `codanics`, there are directories like `projects` and `data`. Inside `projects`, there is a subdirectory called `bioinformatics`.


Here: to go to `projects` directory from `codanics` home directory, you would use:
```
cd projects
```
To go to `bioinformatics` directory from `projects` directory, you would use:
```
cd bioinformatics
```
To go back to `codanics` home directory from `projects` directory, you would use:
```
cd ~
```


> More examples of `cd` command:

```bash
cd directory_name
```

#### Common cd Commands:

```bash
# Go to home directory
cd ~
# or simply
cd

# Go to parent directory
cd ..

# Go to previous directory
cd -

# Go to root directory
cd /

# Go to specific path
cd /home/codanics/projects/genomics

# Go up two levels
cd ../..

# Go to subdirectory
cd data/raw_reads
```

**Examples:**

```bash
# Navigate to your genome assembly project
codanics@PC-codanics:~$ cd bioinformatics/genome_assembly
codanics@PC-codanics:~/bioinformatics/genome_assembly$ 

# Or using absolute path
codanics@PC-codanics:~$ cd /home/codanics/bioinformatics/genome_assembly

# Go to the raw data folder
codanics@PC-codanics:~/bioinformatics/genome_assembly$ cd data/raw_reads
codanics@PC-codanics:~/bioinformatics/genome_assembly/data/raw_reads$

# Go back to home
codanics@PC-codanics:~/bioinformatics/genome_assembly/data/raw_reads$ cd
codanics@PC-codanics:~$
```

---

## File and Directory Operations

### 4. `mkdir` - Make Directory

Create new directories.

```bash
# Create single directory
mkdir genomics_project

# Create multiple directories
mkdir data scripts results

# Create nested directories
mkdir -p project/data/raw_reads

# Create directory with specific permissions
mkdir -m 755 shared_data
```

**Bioinformatics Example:**

```bash
# Set up a typical bioinformatics project structure
mkdir -p rna_seq_analysis/{data/{raw,processed},scripts,results/{alignment,counts},references}
```

This creates:
```
rna_seq_analysis/
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
├── results/
│   ├── alignment/
│   └── counts/
└── references/
```

**Examples:**

```bash
# Create a bioinformatics workspace
codanics@PC-codanics:~$ cd ~
codanics@PC-codanics:~$ mkdir -p bioinformatics_workspace/{genome_assembly,rna_seq,protein_analysis}
codanics@PC-codanics:~$ ls bioinformatics_workspace/
genome_assembly  protein_analysis  rna_seq

# Create dated backup directory
codanics@PC-codanics:~/projects$ mkdir backup_$(date +%Y%m%d)
codanics@PC-codanics:~/projects$ ls
backup_20241115  data  results  scripts
```

---

### 5. `touch` - Create Empty Files

Create new empty files or update timestamps.

```bash
# Create a single file
touch analysis_log.txt

# Create multiple files
touch sample1.txt sample2.txt sample3.txt

# Create files with pattern
touch sample_{1..10}.fastq
```

**Bioinformatics Example:**

```bash
# Create placeholder files for sample data
touch sample_{A,B,C}_R{1,2}.fastq.gz

# Creates: sample_A_R1.fastq.gz, sample_A_R2.fastq.gz, sample_B_R1.fastq.gz, etc.
```

**Examples:**

```bash
codanics@PC-codanics:~/projects$ touch test_samples_{1..5}.fasta
codanics@PC-codanics:~/projects$ ls
test_samples_1.fasta  test_samples_2.fasta  test_samples_3.fasta
test_samples_4.fasta  test_samples_5.fasta

# Create with date stamp
codanics@PC-codanics:~/logs$ touch analysis_$(date +%Y%m%d).log
codanics@PC-codanics:~/logs$ ls
analysis_20241115.log
```

---

### 6. `cp` - Copy Files and Directories

Copy files from one location to another.

#### Basic Usage:

```bash
# Copy file
cp source_file destination_file

# Copy file to directory
cp file.txt /path/to/directory/

# Copy multiple files to directory
cp file1.txt file2.txt file3.txt /destination/

# Copy directory recursively
cp -r source_directory destination_directory

# Copy and preserve attributes (timestamps, permissions)
cp -p file.txt backup/

# Copy with confirmation prompt
cp -i file.txt destination/

# Verbose output (show what's being copied)
cp -v file.txt destination/
```

**Bioinformatics Examples:**

```bash
# Backup raw sequencing data
cp -r raw_data/ raw_data_backup/

# Copy reference genome to working directory
cp /home/codanics/references/hg38.fasta ./references/

# Copy all FASTQ files to processing folder
cp *.fastq.gz data/processing/

# Create backup of important analysis results
cp -p final_results.txt results_backup_$(date +%Y%m%d).txt
```

**Examples:**

```bash
# Backup raw sequencing data
codanics@PC-codanics:~/projects$ cp -r raw_data/ raw_data_backup/
codanics@PC-codanics:~/projects$ ls
raw_data  raw_data_backup  scripts

# Copy reference genome to working directory
codanics@PC-codanics:~/projects$ cp /home/codanics/references/hg38.fasta ./references/
codanics@PC-codanics:~/projects$ ls references/
hg38.fasta

# Copy with verbose output
codanics@PC-codanics:~/data$ cp -v sample1.fastq backup/
'sample1.fastq' -> 'backup/sample1.fastq'

# Create dated backup
codanics@PC-codanics:~/results$ cp -p final_results.txt results_backup_$(date +%Y%m%d).txt
codanics@PC-codanics:~/results$ ls
final_results.txt  results_backup_20241115.txt
```

---

### 7. `mv` - Move or Rename Files

Move files/directories or rename them.

#### Basic Usage:

```bash
# Rename a file
mv old_name.txt new_name.txt

# Move file to directory
mv file.txt /path/to/directory/

# Move multiple files
mv file1.txt file2.txt file3.txt /destination/

# Move directory
mv old_folder/ new_location/

# Move with confirmation prompt
mv -i file.txt destination/

# Verbose output
mv -v file.txt destination/
```

**Bioinformatics Examples:**

```bash
# Rename sample file
mv sample_001.fastq sample_control_rep1.fastq

# Move processed files to results
mv *.bam results/alignment/

# Reorganize data
mv raw_reads/*.fastq.gz data/raw/

# Rename with date stamp
mv analysis.log analysis_$(date +%Y%m%d).log
```

**Examples:**

```bash
# Rename sample file with descriptive name
codanics@PC-codanics:~/data$ mv sample_001.fastq sample_control_rep1.fastq
codanics@PC-codanics:~/data$ ls
sample_control_rep1.fastq

# Move processed BAM files to results
codanics@PC-codanics:~/analysis$ mv *.bam results/alignment/
codanics@PC-codanics:~/analysis$ ls results/alignment/
sample1.bam  sample2.bam  sample3.bam

# Rename with date stamp
codanics@PC-codanics:~/logs$ mv analysis.log analysis_$(date +%Y%m%d).log
codanics@PC-codanics:~/logs$ ls
analysis_20241115.log
```

---

### 8. `rm` - Remove Files and Directories

Delete files and directories (⚠️ **USE WITH CAUTION** - no undo!).

#### Basic Usage:

```bash
# Remove a file
rm file.txt

# Remove multiple files
rm file1.txt file2.txt file3.txt

# Remove with confirmation prompt (RECOMMENDED)
rm -i file.txt

# Remove directory and contents recursively
rm -r directory/

# Force remove (skip confirmations)
rm -f file.txt

# Remove with verbose output
rm -v file.txt

# Remove empty directory
rmdir empty_directory/
```

**Bioinformatics Examples:**

```bash
# Remove temporary files
rm temp_*.txt

# Clean up intermediate BAM files
rm -i intermediate_*.bam

# Remove old log files
rm analysis_log_2023*.log

# Clear temporary processing directory
rm -r temp_processing/

# Remove all FASTQ files in current directory (BE CAREFUL!)
rm *.fastq.gz  # DANGER: Make sure you're in correct directory!
```

**Examples:**

```bash
# Remove temporary files safely
codanics@PC-codanics:~/temp$ ls
temp_001.txt  temp_002.txt  temp_003.txt
codanics@PC-codanics:~/temp$ rm -i temp_*.txt
rm: remove regular file 'temp_001.txt'? y
rm: remove regular file 'temp_002.txt'? y
rm: remove regular file 'temp_003.txt'? y

# Clean up old log files
codanics@PC-codanics:~/logs$ ls
analysis_log_20231015.log  analysis_log_20231115.log  current.log
codanics@PC-codanics:~/logs$ rm analysis_log_2023*.log
codanics@PC-codanics:~/logs$ ls
current.log
```

**⚠️ CRITICAL SAFETY EXAMPLE:**

```bash
# WRONG - Don't do this!
codanics@PC-codanics:~$ rm -rf *  # DANGER! This deletes everything!

# RIGHT - Always check first!
codanics@PC-codanics:~/temp$ ls
file1.txt  file2.txt  important_data/
codanics@PC-codanics:~/temp$ pwd
/home/codanics/temp
codanics@PC-codanics:~/temp$ rm -i *.txt
rm: remove regular file 'file1.txt'? y
rm: remove regular file 'file2.txt'? y
```

---

## Viewing and Reading Files

### 9. `cat` - Concatenate and Display Files

Display file contents.

```bash
# Display file contents
cat file.txt

# Display multiple files
cat file1.txt file2.txt

# Display with line numbers
cat -n file.txt

# Combine files into new file
cat file1.txt file2.txt > combined.txt

# Append to existing file
cat new_data.txt >> existing_file.txt
```

**Bioinformatics Examples:**

```bash
# View FASTA file header
cat genome.fasta | head

# Combine multiple FASTA files
cat chr1.fasta chr2.fasta chr3.fasta > complete_genome.fasta

# View first few sequences
cat sample.fastq | head -n 20
```

**Examples:**

```bash
# View FASTA file content
codanics@PC-codanics:~/genomes$ cat genome.fasta
>chr1
ATGCGATCGATCGATCG
>chr2
CGTAGCTAGCTAGCTAG

# View configuration file
codanics@PC-codanics:~$ cat .bashrc | head -n 5
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files

# Number lines in output
codanics@PC-codanics:~/logs$ cat -n analysis.log | head
         1	Starting analysis...
         2	Loading reference genome...
         3	Processing sample 1...
```

---

### 10. `less` - View File with Pagination

View large files page by page (better than `cat` for large files).

```bash
less large_file.txt
```

**Navigation in less:**
- `Space` or `f`: Forward one page
- `b`: Backward one page
- `g`: Go to beginning
- `G`: Go to end
- `/pattern`: Search forward for pattern
- `?pattern`: Search backward for pattern
- `n`: Next search result
- `q`: Quit

**Bioinformatics Example:**

```bash
# View large FASTA file
less reference_genome.fasta

# View compressed file
zless reads.fastq.gz
```

**Examples:**

```bash
# View large genome file
codanics@PC-codanics:~/references$ less reference_genome.fasta
# Press 'Space' to scroll, 'q' to quit

# View compressed FASTQ file
codanics@PC-codanics:~/data$ zless reads_R1.fastq.gz
# Navigate same as 'less'

# Search while viewing
codanics@PC-codanics:~/annotations$ less genes.gff
# Inside less, press: /BRCA1
# Then press 'n' for next occurrence
```

---

### 11. `head` - Display First Lines

Show the first lines of a file (default: 10 lines).

```bash
# Show first 10 lines
head file.txt

# Show first N lines
head -n 20 file.txt

# Show first N lines of multiple files
head -n 5 *.fasta
```

**Bioinformatics Examples:**

```bash
# Check FASTQ file format
head -n 4 sample.fastq

# View FASTA headers
head -n 20 genome.fasta

# Quick check of multiple samples
head -n 8 sample*.fastq
```

**Examples:**

```bash
# Check FASTQ file format
codanics@PC-codanics:~/data$ head -n 4 sample.fastq
@SRR123456.1
ATCGATCGATCGATCG
+
IIIIIIIIIIIIIIII

# View FASTA headers
codanics@PC-codanics:~/genomes$ head -n 20 genome.fasta | grep "^>"
>chr1
>chr2
>chr3

# Preview CSV file structure
codanics@PC-codanics:~/results$ head -n 5 expression_data.csv
gene_id,sample1,sample2,sample3
GENE001,45.2,67.8,12.3
GENE002,23.4,45.6,78.9
```

---

### 12. `tail` - Display Last Lines

Show the last lines of a file (default: 10 lines).

```bash
# Show last 10 lines
tail file.txt

# Show last N lines
tail -n 20 file.txt

# Follow file (monitor in real-time)
tail -f logfile.txt

# Follow with line count
tail -f -n 100 analysis.log
```

**Bioinformatics Examples:**

```bash
# Monitor analysis progress in real-time
tail -f alignment.log

# Check last completed steps
tail -n 20 pipeline.log
```

**Examples:**

```bash
# Monitor analysis progress in real-time
codanics@PC-codanics:~/logs$ tail -f alignment.log
Processing read 95000...
Processing read 96000...
Processing read 97000...
^C  # Press Ctrl+C to stop

# Check last completed steps
codanics@PC-codanics:~/pipeline$ tail -n 20 pipeline.log
[2024-11-15 10:45:23] Alignment complete
[2024-11-15 10:45:24] Starting variant calling...
[2024-11-15 10:50:15] Variant calling complete
```

---

### 13. `wc` - Word Count

Count lines, words, and characters.

```bash
# Count lines, words, bytes
wc file.txt

# Count only lines
wc -l file.txt

# Count only words
wc -w file.txt

# Count only characters
wc -c file.txt

# Count multiple files
wc -l *.fastq
```

**Bioinformatics Examples:**

```bash
# Count sequences in FASTQ file
wc -l sample.fastq

# Calculate number of reads
echo $(( $(wc -l < sample.fastq) / 4 ))

# Count sequences in FASTA file
grep -c "^>" genome.fasta

# Check number of aligned reads
wc -l alignment.sam
```

**Examples:**

```bash
# Count sequences in FASTQ file
codanics@PC-codanics:~/data$ wc -l sample.fastq
40000000 sample.fastq
# Divide by 4 for read count: 10,000,000 reads

# Calculate number of reads
codanics@PC-codanics:~/data$ echo $(( $(wc -l < sample.fastq) / 4 ))
10000000

# Count sequences in FASTA
codanics@PC-codanics:~/genomes$ grep -c "^>" genome.fasta
24

# Compare file sizes
codanics@PC-codanics:~/data$ wc -l *.fastq
10000000 sample_1.fastq
10000000 sample_2.fastq
 8500000 sample_3.fastq
28500000 total
```

---

## File Manipulation

### 14. `grep` - Search Text Patterns

Search for patterns in files.

```bash
# Basic search
grep "pattern" file.txt

# Case-insensitive search
grep -i "pattern" file.txt

# Count matches
grep -c "pattern" file.txt

# Show line numbers
grep -n "pattern" file.txt

# Invert match (lines NOT containing pattern)
grep -v "pattern" file.txt

# Recursive search in directories
grep -r "pattern" directory/

# Search multiple files
grep "pattern" *.txt

# Show only matching part
grep -o "pattern" file.txt
```

**Bioinformatics Examples:**

```bash
# Find specific gene in FASTA
grep "BRCA1" annotations.fasta

# Count sequences in FASTA
grep -c "^>" genome.fasta

# Extract all sequence headers
grep "^>" sequences.fasta

# Case-insensitive search for gene name
grep -i "insulin" gene_names.txt

# Search in compressed files
zgrep "ATCGATCG" file.fastq.gz | wc -l
```

**Examples:**

```bash
# Find specific gene in FASTA
codanics@PC-codanics:~/data$ grep "BRCA1" annotations.fasta
>ENSG00000012048|BRCA1|chr17:43044295-43125483

# Count sequences in FASTA
codanics@PC-codanics:~/genomes$ grep -c "^>" genome.fasta
24

# Extract all sequence headers
codanics@PC-codanics:~/data$ grep "^>" sequences.fasta
>chr1
>chr2
>chrX
>chrY

# Case-insensitive search for gene name
codanics@PC-codanics:~/results$ grep -i "insulin" gene_names.txt
INSULIN
Insulin-like growth factor 1
insulin receptor

# Search in compressed files
codanics@PC-codanics:~/data$ zgrep "ATCGATCG" file.fastq.gz | wc -l
1523
```

---

### 15. `cut` - Extract Columns

Extract specific columns from files.

```bash
# Cut by character position
cut -c 1-10 file.txt

# Cut by delimiter (tab by default)
cut -f 1,3 file.txt

# Cut with different delimiter
cut -d "," -f 1,2 file.csv

# Cut multiple fields
cut -f 1-3,5 file.txt
```

**Bioinformatics Examples:**

```bash
# Extract sequence IDs from FASTA
grep "^>" genome.fasta | cut -d " " -f 1

# Extract gene names from GFF
cut -f 9 genes.gff | cut -d ";" -f 1 | head

# Get first column from TSV file
cut -f 1 expression_data.tsv | head

# Extract coordinates from BED file
cut -f 1-3 regions.bed | head
```

**Examples:**

```bash
# Extract sequence IDs from FASTA
codanics@PC-codanics:~/data$ grep "^>" genome.fasta | cut -d " " -f 1
>chr1
>chr2
>chr3

# Extract gene names from GFF
codanics@PC-codanics:~/annotations$ cut -f 9 genes.gff | cut -d ";" -f 1 | head
gene_id "ENSG00000000003"
gene_id "ENSG00000000005"

# Get first column from TSV file
codanics@PC-codanics:~/results$ cut -f 1 expression_data.tsv | head
gene_id
GENE001
GENE002

# Extract coordinates from BED file
codanics@PC-codanics:~/regions$ cut -f 1-3 regions.bed | head
chr1    1000    2000
chr1    3000    4000
chr2    5000    6000
```

---

### 16. `sort` - Sort Lines

Sort lines in text files.

```bash
# Sort alphabetically
sort file.txt

# Sort numerically
sort -n numbers.txt

# Reverse sort
sort -r file.txt

# Sort by specific column
sort -k 2 file.txt

# Sort numerically by column
sort -k 2 -n file.txt

# Remove duplicates while sorting
sort -u file.txt

# Sort and save to new file
sort file.txt > sorted_file.txt
```

**Bioinformatics Examples:**

```bash
# Sort BED file by chromosome and position
sort -k1,1 -k2,2n regions.bed > sorted_regions.bed

# Sort expression values (highest first)
sort -k 2 -n -r expression.txt | head

# Sort gene list alphabetically
sort genes.txt > genes_sorted.txt

# Remove duplicate sequence IDs
cut -f 1 sequences.txt | sort -u
```

**Examples:**

```bash
# Sort BED file by chromosome and position
codanics@PC-codanics:~/regions$ sort -k1,1 -k2,2n regions.bed > sorted_regions.bed
codanics@PC-codanics:~/regions$ head sorted_regions.bed
chr1    1000    2000    region1
chr1    3000    4000    region2
chr1    5000    6000    region3

# Sort expression values (highest first)
codanics@PC-codanics:~/results$ sort -k 2 -n -r expression.txt | head
gene1    1523.45    high_expression
gene2    1402.33    high_expression

# Sort gene list alphabetically
codanics@PC-codanics:~/genes$ sort genes.txt > genes_sorted.txt
codanics@PC-codanics:~/genes$ head genes_sorted.txt
BRCA1
BRCA2
EGFR
```

---

### 17. `uniq` - Remove Duplicate Lines

Remove or count duplicate adjacent lines (use with `sort`).

```bash
# Remove duplicates
sort file.txt | uniq

# Count duplicates
sort file.txt | uniq -c

# Show only duplicates
sort file.txt | uniq -d

# Show only unique lines
sort file.txt | uniq -u
```

**Bioinformatics Examples:**

```bash
# Count unique sequences
sort sequences.txt | uniq -c

# Find duplicate gene IDs
sort gene_ids.txt | uniq -d

# Get unique chromosomes
cut -f 1 alignment.bed | sort | uniq

# Count reads per chromosome
cut -f 1 alignment.sam | sort | uniq -c
```

**Examples:**

```bash
# Count unique sequences
codanics@PC-codanics:~/data$ sort sequences.txt | uniq -c
            3 ATCGATCG
            5 GCTAGCTA
            2 TTAATTAA

# Find duplicate gene IDs
codanics@PC-codanics:~/genes$ sort gene_ids.txt | uniq -d
ENSG00000000003
ENSG00000000005

# Get unique chromosomes
codanics@PC-codanics:~/alignment$ cut -f 1 alignment.bed | sort | uniq
chr1
chr2
chrX
chrY

# Count reads per chromosome
codanics@PC-codanics:~/sam$ cut -f 3 alignment.sam | sort | uniq -c
 125000 chr1
    98000 chr2
    45000 chrX
    12000 chrY
```

---

## File Permissions

### 18. `chmod` - Change File Permissions

Modify file access permissions.

```bash
# Give execute permission to script
chmod +x script.sh

# Remove write permission
chmod -w file.txt

# Set specific permissions (rwxr-xr-x)
chmod 755 script.sh

# Recursive permission change
chmod -R 755 directory/
```

**Permission Numbers:**
- `4` = read (r)
- `2` = write (w)
- `1` = execute (x)

**Common Combinations:**
- `755` = rwxr-xr-x (owner: all, group/others: read+execute)
- `644` = rw-r--r-- (owner: read+write, others: read only)
- `777` = rwxrwxrwx (all permissions for everyone)

**Bioinformatics Examples:**

```bash
# Make analysis script executable
chmod +x run_analysis.sh

# Secure sensitive data
chmod 600 patient_data.txt

# Make all scripts executable
chmod +x *.sh

# Set directory permissions
chmod -R 755 shared_results/
```

**Examples:**

```bash
# Make analysis script executable
codanics@PC-codanics:~/scripts$ ls -l run_analysis.sh
-rw-r--r-- 1 codanics codanics 2048 Nov 15 10:30 run_analysis.sh

codanics@PC-codanics:~/scripts$ chmod +x run_analysis.sh

codanics@PC-codanics:~/scripts$ ls -l run_analysis.sh
-rwxr-xr-x 1 codanics codanics 2048 Nov 15 10:30 run_analysis.sh

# Secure sensitive patient data
codanics@PC-codanics:~/data$ chmod 600 patient_data.txt
codanics@PC-codanics:~/data$ ls -l patient_data.txt
-rw------- 1 codanics codanics 15000 Nov 15 10:35 patient_data.txt

# Make all scripts executable
codanics@PC-codanics:~/scripts$ chmod +x *.sh
codanics@PC-codanics:~/scripts$ ls -l
-rwxr-xr-x 1 codanics codanics 1024 Nov 15 10:30 align.sh
-rwxr-xr-x 1 codanics codanics 2048 Nov 15 10:31 analysis.sh
-rwxr-xr-x 1 codanics codanics 1536 Nov 15 10:32 qc.sh
```

---

## Searching and Finding

### 20. `find` - Search for Files

Find files and directories.

```bash
# Find by name
find . -name "*.fastq"

# Find by type (f=file, d=directory)
find . -type f -name "*.txt"

# Find by size
find . -size +100M

# Find and execute command
find . -name "*.log" -delete

# Find modified in last N days
find . -mtime -7

# Find larger than size
find . -size +1G
```

**Bioinformatics Examples:**

```bash
# Find all FASTQ files
find . -name "*.fastq.gz"

# Find large BAM files
find . -type f -name "*.bam" -size +5G

# Find recently modified results
find ./results -mtime -1

# Count FASTA files
find . -name "*.fasta" | wc -l

# Delete temporary files
find . -name "temp_*" -delete

# Find empty directories
find . -type d -empty
```

**Examples:**

```bash
# Find all FASTQ files in project
codanics@PC-codanics:~/bioinfo$ find . -name "*.fastq.gz"
./data/raw/sample1_R1.fastq.gz
./data/raw/sample1_R2.fastq.gz
./data/raw/sample2_R1.fastq.gz
./data/raw/sample2_R2.fastq.gz

# Find large BAM files (>5GB)
codanics@PC-codanics:~/alignment$ find . -type f -name "*.bam" -size +5G
./results/sample1_sorted.bam
./results/sample2_sorted.bam

# Find recently modified results (last 24 hours)
codanics@PC-codanics:~/project$ find ./results -mtime -1
./results/latest_analysis.txt
./results/summary.pdf

# Find and make scripts executable
codanics@PC-codanics:~/scripts$ find . -name "*.sh" -exec chmod +x {} \;

# Find large files to clean up
codanics@PC-codanics:~$ find . -type f -size +1G -exec ls -lh {} \;
-rw-r--r-- 1 codanics codanics 2.5G Nov 15 10:30 ./data/genome.bam
-rw-r--r-- 1 codanics codanics 1.8G Nov 15 10:31 ./backup/old_data.tar.gz
```

---

### 21. `locate` - Quick File Search

Fast file search using database (faster than `find`).

```bash
# Update locate database first
sudo updatedb

# Search for file
locate genome.fasta

# Case-insensitive search
locate -i GENOME.FASTA

# Limit results
locate -n 10 *.fastq
```

**Bioinformatics Examples:**

```bash
# Locate all FASTQ files
locate "*.fastq"

# Find specific sample file
locate -i "sample_control_R1.fastq"

# Count number of reference genomes
locate -c "genome.fasta"
```

**Examples:**

```bash
# Update the database first
codanics@PC-codanics:~$ sudo updatedb
[sudo] password for codanics: ****

# Search for genome files
codanics@PC-codanics:~$ locate genome.fasta
/home/codanics/references/genome.fasta
/home/codanics/projects/genome_assembly/genome.fasta
/home/codanics/backup/old_genome.fasta

# Case-insensitive search
codanics@PC-codanics:~$ locate -i GENOME.FASTA
/home/codanics/references/genome.fasta
/home/codanics/references/GENOME.FASTA
/home/codanics/downloads/Genome.fasta

# Count how many FASTQ files
codanics@PC-codanics:~$ locate -c "*.fastq.gz"
42
```

---

## Process Management

### 22. `ps` - Process Status

Display running processes.

```bash
# Show your processes
ps

# Show all processes
ps aux

# Show processes for specific user
ps -u username

# Show processes with full details
ps -ef

# Show process tree
ps auxf
```

**Bioinformatics Example:**

```bash
# Check running analysis
ps aux | grep python

# Monitor alignment jobs
ps aux | grep bowtie
```

**Examples:**

```bash
# Check your running processes
codanics@PC-codanics:~$ ps
        PID TTY          TIME CMD
     1234 pts/0    00:00:00 bash
     5678 pts/0    00:00:05 python

# Check running analysis
codanics@PC-codanics:~$ ps aux | grep python
codanics   5678  45.2  12.3 2456780 1024000 pts/0 R+ 10:30   5:23 python genome_assembly.py
codanics   5691   0.0   0.0   8900    840 pts/1 S+  10:45   0:00 grep python

# Monitor alignment jobs
codanics@PC-codanics:~$ ps aux | grep bowtie
codanics   6234  98.5  25.4 5678900 2048000 ?     R    10:30  45:23 bowtie2 -x genome -1 R1.fastq -2 R2.fastq
```

---

### 23. `top` / `htop` - Monitor Processes

Real-time process monitoring.

```bash
# Start top
top

# Start htop (more user-friendly)
htop
```

**Navigation in top:**
- `q`: Quit
- `k`: Kill process
- `M`: Sort by memory
- `P`: Sort by CPU
- `1`: Show individual CPUs

**Bioinformatics Use:**
- Monitor memory usage during genome assembly
- Check CPU utilization of alignment jobs
- Identify memory-intensive processes

**Example:**

```bash
codanics@PC-codanics:~$ top

top - 10:45:23 up 5 days,  3:24,  2 users,  load average: 2.45, 1.87, 1.23
Tasks: 287 total,   2 running, 285 sleeping,   0 stopped,   0 zombie
%Cpu(s): 67.3 us,  5.2 sy,  0.0 ni, 25.1 id,  2.4 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  32167.8 total,   2345.7 free,  18234.5 used,  11587.6 buff/cache
MiB Swap:   8192.0 total,   6234.0 free,   1958.0 used.  12456.3 avail Mem

        PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
     5678 codanics  20   0 2456780 1024000  45632 R  98.3  12.5  45:23.45 python
     6234 codanics  20   0 5678900 2048000  89234 R  89.7  25.4 123:45.67 bowtie2

# Press 'q' to quit
```

---

### 24. `kill` - Terminate Processes

Stop running processes.

```bash
# Kill by process ID
kill 1234

# Force kill
kill -9 1234

# Kill by name
killall process_name

# Kill all user processes
pkill -u username
```

**Bioinformatics Example:**

```bash
# Stop hung analysis
kill -9 12345

# Stop all Python processes
killall python

# Stop specific analysis
pkill -f "genome_assembly"
```

**Examples:**

```bash
# Find and kill hung process
codanics@PC-codanics:~$ ps aux | grep analysis
codanics   5678  0.0  2.3 123456 98765 pts/0 S+ 10:30   0:45 python analysis.py

codanics@PC-codanics:~$ kill 5678

# Force kill if not responding
codanics@PC-codanics:~$ kill -9 5678

# Kill all Python processes (be careful!)
codanics@PC-codanics:~$ killall python
```

---

### 25. `nohup` - Run Process in Background

Run command that continues after logout.

```bash
# Run in background
nohup python analysis.py &

# Run with output to file
nohup python analysis.py > output.log 2>&1 &

# Check background jobs
jobs
```

**Bioinformatics Example:**

```bash
# Long-running genome assembly
nohup genome_assembler -i reads.fastq -o assembly/ > assembly.log 2>&1 &

# Background alignment
nohup bwa mem reference.fa reads.fastq > aligned.sam 2> align.log &
```

**Examples:**

```bash
# Long-running genome assembly
codanics@PC-codanics:~/analysis$ nohup genome_assembler -i reads.fastq -o assembly/ > assembly.log 2>&1 &
[1] 5678
nohup: ignoring input and appending output to 'nohup.out'

codanics@PC-codanics:~/analysis$ jobs
[1]+  Running                 nohup genome_assembler -i reads.fastq -o assembly/ > assembly.log 2>&1 &

# Monitor progress
codanics@PC-codanics:~/analysis$ tail -f assembly.log
Processing contig 1000...
Processing contig 1001...

# Background alignment
codanics@PC-codanics:~/alignment$ nohup bwa mem reference.fa reads.fastq > aligned.sam 2> align.log &
[2] 5789
```

---

## System Information

### 26. `df` - Disk Space

Check disk space usage.

```bash
# Show disk usage
df

# Human-readable format
df -h

# Show specific filesystem
df -h /home
```

**Output Example:**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       100G   60G   40G  60% /
/dev/sdb1       1.0T  500G  500G  50% /home/codanics/data
tmpfs            16G  2.1G   14G  14% /dev/shm
```

**Example:**

```bash
codanics@PC-codanics:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       100G   60G   40G  60% /
/dev/sdb1       1.0T  500G  500G  50% /home/codanics/data
tmpfs            16G  2.1G   14G  14% /dev/shm

# Check specific directory
codanics@PC-codanics:~$ df -h /home/codanics/data
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb1       1.0T  500G  500G  50% /home/codanics/data
```

---

### 27. `du` - Directory Size

Check directory/file sizes.

```bash
# Show directory size
du -sh directory/

# Show sizes of all subdirectories
du -h directory/

# Show top 10 largest directories
du -h | sort -rh | head -10

# Show size of current directory
du -sh .
```

**Bioinformatics Examples:**

```bash
# Check sequencing data size
du -sh raw_data/

# Find largest analysis folders
du -h results/ | sort -rh | head -10

# Check total project size
du -sh bioinformatics_project/
```

**Examples:**

```bash
# Check sequencing data size
codanics@PC-codanics:~$ du -sh raw_data/
125G    raw_data/

# Find largest analysis folders
codanics@PC-codanics:~$ du -h results/ | sort -rh | head -10
125G    results/
85G     results/alignment
40G     results/variants
15G     results/expression
8.5G    results/quality_control

# Check total project size
codanics@PC-codanics:~$ du -sh bioinformatics_project/
287G    bioinformatics_project/

# Check each subdirectory
codanics@PC-codanics:~/project$ du -h --max-depth=1 .
125G    ./data
45G     ./results
2.5G    ./scripts
500M    ./references
173G    .
```

---

### 28. `free` - Memory Usage

```bash
codanics@PC-codanics:~$ free -h
                             total        used        free      shared  buff/cache   available
Mem:            31Gi        18Gi       2.3Gi       2.1Gi        11Gi        12Gi
Swap:          8.0Gi       1.9Gi       6.1Gi

# Watch memory in real-time
codanics@PC-codanics:~$ watch -n 1 free -h
```

---

## Bioinformatics-Specific Commands

### 29. Working with Compressed Files

```bash
# View compressed file
zcat file.gz
zless file.gz

# Compress file
gzip file.txt

# Decompress file
gunzip file.gz

# Compress keeping original
gzip -k file.txt

# Compress directory
tar -czf archive.tar.gz directory/

# Extract tar.gz
tar -xzf archive.tar.gz
```

**Examples:**

```bash
# View compressed FASTQ
zcat reads.fastq.gz | head

# Count reads in compressed file
zcat reads.fastq.gz | wc -l

# Compress BAM file
gzip alignment.sam

# Backup project
tar -czf project_backup_$(date +%Y%m%d).tar.gz project_directory/
```

---

### 30. Piping and Redirection

Combine multiple commands.

```bash
# Pipe output to another command
cat file.txt | grep "pattern" | sort

# Redirect output to file
command > output.txt

# Append to file
command >> output.txt

# Redirect errors
command 2> errors.log

# Redirect both output and errors
command > output.txt 2>&1
```

**Bioinformatics Examples:**

```bash
# Count sequences with specific pattern
zcat genome.fastq.gz | grep "ATGC" | wc -l

# Extract and sort gene IDs
grep "gene" annotations.gff | cut -f 9 | sort -u > gene_list.txt

# Process SAM file
cat alignment.sam | grep -v "^@" | cut -f 1 | sort | uniq -c > read_counts.txt

# Chain multiple filters
zcat reads.fastq.gz | head -n 1000000 | grep "QUALITY" > filtered_reads.txt
```

---

### 31. `awk` - Text Processing

AWK is a powerful text processing language, perfect for column-based data manipulation in bioinformatics.

#### Basic Usage:

```bash
# Print specific column
awk '{print $1}' file.txt

# Print multiple columns
awk '{print $1, $3}' file.txt

# Print with custom separator
awk '{print $1"\t"$2}' file.txt

# Use different field separator
awk -F "," '{print $1}' file.csv

# Print lines matching pattern
awk '/pattern/ {print $0}' file.txt

# Conditional printing
awk '$3 > 100 {print $1, $3}' file.txt

# Calculate sum of column
awk '{sum += $2} END {print sum}' file.txt
```

#### Advanced Usage:

```bash
# Print with column headers
awk 'NR==1 {print $0} NR>1 {print $1, $2}' file.txt

# Calculate average
awk '{sum+=$2; count++} END {print sum/count}' file.txt

# Format output
awk '{printf "%-10s %10.2f\n", $1, $2}' file.txt

# Multiple conditions
awk '$3>50 && $4<100 {print $1}' file.txt
```

**Bioinformatics Examples:**

```bash
# Extract sequences longer than 100bp from FASTA
awk '/^>/ {if(seq) {if(length(seq)>100) print header"\n"seq} header=$0; seq=""; next} {seq=seq$0} END {if(length(seq)>100) print header"\n"seq}' genome.fasta

# Calculate average read quality from SAM file
awk '{sum+=$5; count++} END {print sum/count}' alignment.sam

# Extract high-quality reads
awk '$5 > 30 {print $1}' alignment.sam

# Count features in GFF file
awk '$3=="gene" {count++} END {print "Total genes:", count}' annotations.gff

# Calculate GC content
awk '/^[^>]/ {gc+=gsub(/[GCgc]/,""); total+=length($0)} END {print "GC%:", (gc/total)*100}' genome.fasta

# Filter BED file by chromosome
awk '$1=="chr1" {print $0}' regions.bed

# Extract gene coordinates from GTF
awk '$3=="gene" {print $1, $4, $5, $10}' annotations.gtf | tr -d '";'
```

**Examples:**

```bash
# Process expression data
codanics@PC-codanics:~/results$ awk '$2 > 100 {print $1, $2}' expression.txt
gene1    150.5
gene2    234.7
gene3    102.3

# Calculate average expression
codanics@PC-codanics:~/results$ awk '{sum+=$2; n++} END {print "Average:", sum/n}' expression.txt
Average: 45.67

# Extract specific fields from GFF
codanics@PC-codanics:~/annotations$ awk -F"\t" '$3=="gene" {print $1, $4, $5, $9}' genes.gff | head
chr1 1000 2000 ID=gene001;Name=BRCA1
chr1 5000 6000 ID=gene002;Name=TP53

# Count reads per chromosome
codanics@PC-codanics:~/alignment$ awk '{chr[$3]++} END {for(c in chr) print c, chr[c]}' alignment.sam
chr1    125000
chr2    98000
chrX    45000

# Filter by multiple conditions
codanics@PC-codanics:~/data$ awk '$3>50 && $4<100 && $5=="pass" {print $1}' qc_results.txt
sample1
sample4
sample7
```

---

### 32. `sed` - Stream Editor

SED is a stream editor for filtering and transforming text.

#### Basic Usage:

```bash
# Substitute text (first occurrence)
sed 's/old/new/' file.txt

# Substitute all occurrences
sed 's/old/new/g' file.txt

# Delete lines matching pattern
sed '/pattern/d' file.txt

# Delete specific line
sed '5d' file.txt

# Print specific lines
sed -n '10,20p' file.txt

# Replace in-place
sed -i 's/old/new/g' file.txt

# Multiple commands
sed -e 's/old/new/g' -e 's/foo/bar/g' file.txt
```

#### Advanced Usage:

```bash
# Case-insensitive replacement
sed 's/pattern/replacement/gi' file.txt

# Delete empty lines
sed '/^$/d' file.txt

# Add line after pattern
sed '/pattern/a\new line' file.txt

# Replace with regex
sed 's/[0-9]\+/NUMBER/g' file.txt

# Delete lines between patterns
sed '/start/,/end/d' file.txt
```

**Bioinformatics Examples:**

```bash
# Remove header lines from FASTA
sed '/^>/d' genome.fasta

# Convert FASTQ to FASTA
sed -n '1~4s/^@/>/p;2~4p' reads.fastq > reads.fasta

# Remove quality scores from FASTQ
sed -n '1,2p' reads.fastq

# Replace chromosome names
sed 's/chr/chromosome_/g' alignment.sam

# Remove comment lines from GFF
sed '/^#/d' annotations.gff

# Extract sequences (remove headers)
sed -n '/^>/!p' sequences.fasta

# Clean up gene names
sed 's/gene_id "\([^"]*\)".*/\1/' annotations.gtf

# Format conversion
sed 's/\t/,/g' data.tsv > data.csv
```

**Examples:**

```bash
# Convert FASTQ to FASTA
codanics@PC-codanics:~/data$ sed -n '1~4s/^@/>/p;2~4p' reads.fastq > reads.fasta
codanics@PC-codanics:~/data$ head -n 4 reads.fasta
>SRR123456.1
ATCGATCGATCGATCG
>SRR123456.2
GCTAGCTAGCTAGCTA

# Remove header lines from SAM
codanics@PC-codanics:~/alignment$ sed '/^@/d' alignment.sam > alignment_no_header.sam
codanics@PC-codanics:~/alignment$ head -n 2 alignment_no_header.sam
read1    0    chr1    1000    60    50M    *    0    0    ATCG...
read2    0    chr1    1050    60    50M    *    0    0    GCTA...

# Replace chromosome names
codanics@PC-codanics:~/regions$ sed 's/^chr/chromosome_/' regions.bed > regions_renamed.bed
codanics@PC-codanics:~/regions$ head -n 2 regions_renamed.bed
chromosome_1    1000    2000    region1
chromosome_1    3000    4000    region2

# Clean up whitespace
codanics@PC-codanics:~/data$ sed 's/[[:space:]]\+/\t/g' messy_data.txt > clean_data.txt

# Extract gene IDs from GTF
codanics@PC-codanics:~/annotations$ sed -n 's/.*gene_id "\([^"]*\)".*/\1/p' genes.gtf | head
ENSG00000000003
ENSG00000000005
ENSG00000000419
```

---

### 33. Using `wget` and `curl`

Tools for downloading files from the internet via command line.

#### `wget` - Non-interactive Downloader

```bash
# Basic download
wget https://example.com/file.txt

# Download with custom name
wget -O newname.txt https://example.com/file.txt

# Resume incomplete download
wget -c https://example.com/largefile.tar.gz

# Download multiple files
wget -i urls.txt

# Download entire website (recursive)
wget -r https://example.com/

# Download in background
wget -b https://example.com/file.txt

# Limit download speed
wget --limit-rate=1m https://example.com/file.txt

# Download to specific directory
wget -P /path/to/directory https://example.com/file.txt
```

#### `curl` - Transfer Data

```bash
# Basic download
curl -O https://example.com/file.txt

# Download with custom name
curl -o newname.txt https://example.com/file.txt

# Resume download
curl -C - -O https://example.com/largefile.tar.gz

# Follow redirects
curl -L https://example.com/file.txt

# Show progress bar
curl -# -O https://example.com/file.txt

# Silent mode
curl -s https://example.com/file.txt

# Download multiple files
curl -O https://example.com/file1.txt -O https://example.com/file2.txt
```

**Bioinformatics Examples:**

```bash
# Download reference genome from NCBI
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz

# Download SRA data
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos/sra-pub-run-5/SRR000001/SRR000001.1

# Download multiple files from list
wget -i genome_urls.txt

# Download with retry and continue
wget -c -t 5 https://large-genome-file.fasta.gz

# Download BLAST database
wget https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz

# Download from Ensembl
curl -O ftp://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

# API call to retrieve data
curl "https://rest.ensembl.org/sequence/id/ENSG00000139618?content-type=text/plain" > BRCA2_sequence.txt

# Download protein sequences
curl -O https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
```

**Examples:**

```bash
# Download human reference genome
codanics@PC-codanics:~/references$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz
--2024-11-15 10:30:45--  https://ftp.ncbi.nlm.nih.gov/...
Resolving ftp.ncbi.nlm.nih.gov... 130.14.250.10
Connecting to ftp.ncbi.nlm.nih.gov|130.14.250.10|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 987654321 (942M) [application/x-gzip]
Saving to: 'GCF_000001405.40_GRCh38.p14_genomic.fna.gz'

GCF_000001405.40... 100%[===================>] 942.00M  5.23MB/s    in 3m 45s

2024-11-15 10:34:30 (4.18 MB/s) - 'GCF_000001405.40_GRCh38.p14_genomic.fna.gz' saved

# Resume interrupted download
codanics@PC-codanics:~/data$ wget -c https://large-genome-file.fasta.gz
--2024-11-15 10:35:00--  https://large-genome-file.fasta.gz
Connecting to server... connected.
HTTP request sent, awaiting response... 206 Partial Content
Length: 2147483648 (2.0G), 1073741824 (1.0G) remaining [application/x-gzip]
Saving to: 'large-genome-file.fasta.gz'

# Download multiple genome annotations
codanics@PC-codanics:~/annotations$ cat genome_urls.txt
https://ftp.ensembl.org/pub/release-108/gtf/homo_sapiens/Homo_sapiens.GRCh38.108.gtf.gz
https://ftp.ensembl.org/pub/release-108/gtf/mus_musculus/Mus_musculus.GRCm39.108.gtf.gz

codanics@PC-codanics:~/annotations$ wget -i genome_urls.txt

# Using curl for API calls
codanics@PC-codanics:~/sequences$ curl "https://rest.ensembl.org/sequence/id/ENSG00000139618?content-type=text/plain" > BRCA2_sequence.txt
codanics@PC-codanics:~/sequences$ head BRCA2_sequence.txt
>ENSG00000139618
ATGCCTATTGGATCCAAAGAGAGGCCAACATTTTTTGAAATTTTTAAGACACGCTGCAA...

# Download with specific naming
codanics@PC-codanics:~/db$ wget -O human_genome_hg38.fa.gz https://ftp.ncbi.nlm.nih.gov/.../genome.fa.gz

# Check if file exists before downloading
codanics@PC-codanics:~/data$ wget -nc https://example.com/existing_file.txt
File 'existing_file.txt' already there; not retrieving.
```

**Comparison: wget vs curl**

| Feature | wget | curl |
|---------|------|------|
| Recursive download | ✅ Yes | ❌ No |
| Resume download | `-c` | `-C -` |
| Background download | ✅ Yes | ❌ No |
| Multiple protocols | HTTP, HTTPS, FTP | HTTP, HTTPS, FTP, and many more |
| API calls | Basic | Advanced |
| Progress bar | ✅ Built-in | Use `-#` |
| Best for | Downloading files | API calls and transfers |

---

## Practice Exercises

### Exercise 1: Project Setup

Create a bioinformatics project structure:

```bash
codanics@PC-codanics:~$ mkdir -p bioinfo_project/{data/{raw,processed},scripts,results,references}
codanics@PC-codanics:~$ cd bioinfo_project
codanics@PC-codanics:~/bioinfo_project$ touch README.md
codanics@PC-codanics:~/bioinfo_project$ ls -R
.:
data  references  results  scripts  README.md

./data:
processed  raw

./data/processed:

./data/raw:

./references:

./results:

./scripts:
```

### Exercise 2: File Operations

```bash
# Create sample files
touch sample_{1..5}.fastq
ls -l *.fastq

# Create backup
mkdir backup
cp *.fastq backup/

# Rename files
for file in *.fastq; do mv "$file" "${file%.fastq}_R1.fastq"; done
```

### Exercise 3: Text Processing

```bash
# Create a sample FASTA-like file
echo -e ">seq1\nATGCGATCGATCG\n>seq2\nCGATCGATCGATC" > sample.fasta

# Count sequences
grep -c "^>" sample.fasta

# Extract sequence IDs
grep "^>" sample.fasta | cut -d " " -f 1
```

### Exercise 4: Finding Files

```bash
# Find all script files
find . -name "*.sh"

# Find large files (>100MB)
find . -size +100M

# Find recently modified
find . -mtime -1
```

---

## Quick Reference Cheat Sheet

```bash
# Navigation
pwd                                    # Print working directory
ls -lah                               # List all files with details
cd ~/projects                         # Change to projects directory
cd                                    # Go home

# File Operations
mkdir -p project/data                 # Create nested directories
touch file.txt                        # Create empty file
cp -r source/ dest/                   # Copy directory
mv old.txt new.txt                    # Rename file
rm -i file.txt                        # Delete with confirmation

# Viewing Files
cat file.txt                          # Display entire file
less large_file.txt                   # Page through file
head -n 20 file.txt                   # First 20 lines
tail -f logfile.txt                   # Follow file updates
wc -l file.txt                        # Count lines

# Searching
grep "pattern" file.txt               # Search in file
find . -name "*.fastq"                # Find files
locate genome.fasta                   # Quick search

# Text Processing
cut -f 1,3 data.tsv                   # Extract columns
sort -k2,2n file.txt                  # Sort by column 2 numerically
uniq -c sorted.txt                    # Count unique lines

# Compression
gzip file.txt                         # Compress file
gunzip file.gz                        # Decompress file
tar -czf archive.tar.gz dir/          # Create archive
tar -xzf archive.tar.gz               # Extract archive
zcat file.gz | head                   # View compressed file

# Permissions
chmod +x script.sh                    # Make executable
chmod 644 data.txt                    # Set read/write for owner
chmod -R 755 directory/               # Recursive permissions

# System Info
df -h                                 # Disk space
du -sh directory/                     # Directory size
free -h                               # Memory usage
top                                   # Monitor processes
ps aux | grep python                  # Find processes

# Process Management
nohup command &                       # Run in background
jobs                                  # List background jobs
kill 1234                             # Stop process
killall python                        # Stop all Python processes

# Example prompt
codanics@PC-codanics:~$              # Linux Mint prompt
```

---

## Tips for Bioinformatics Work

1. **Always use tab completion** - Press `Tab` to auto-complete filenames
2. **Use descriptive filenames** - `sample1_control_R1.fastq` better than `s1.fastq`
3. **Keep backups** - Copy important data before processing
4. **Document your commands** - Save commands in script files
5. **Check file sizes** - Use `ls -lh` before and after operations
6. **Monitor disk space** - Use `df -h` regularly
7. **Use version control** - Git for scripts and analysis pipelines
8. **Test on small datasets first** - Before running on full genome data
9. **Keep organized** - Use clear directory structures
10. **Use screen/tmux** - For long-running analyses on remote servers

---

## Next Steps

After mastering these basic commands, you should:

1. Learn **shell scripting** (bash) for automation
2. Understand **regular expressions** for advanced pattern matching
3. Master **awk and sed** for text processing
4. Learn about **conda/mamba** for package management
5. Understand **Docker/Singularity** for containerization
6. Get comfortable with **SSH and remote servers**
7. Learn **version control with Git**

---

## Additional Resources

- **Linux Command Cheat Sheet**: https://www.linuxtrainingacademy.com/linux-commands-cheat-sheet/
- **Bash Scripting Guide**: https://www.gnu.org/software/bash/manual/
- **Bioinformatics Command Line**: https://www.bioinformaticsworkbook.org/

---

**Happy Learning! 🐧💻🧬**

*Remember: Practice makes perfect. The more you use these commands, the more natural they'll become!*

---

*Last Updated: November 2024*
*Course: Bioinformatics Ka Chilla 2025-2026*
*Instructor: M Aammar Tufail*
*Website: www.codanics.com*

