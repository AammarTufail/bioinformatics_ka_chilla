# 🔬 Short-Read Quality Control (QC) for Illumina Sequencing

## Table of Contents

- [🔬 Short-Read Quality Control (QC) for Illumina Sequencing](#-short-read-quality-control-qc-for-illumina-sequencing)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Why is Quality Control Important?](#why-is-quality-control-important)
    - [What Can Go Wrong Without QC?](#what-can-go-wrong-without-qc)
  - [Understanding FASTQ Format](#understanding-fastq-format)
    - [The Four Lines of FASTQ](#the-four-lines-of-fastq)
    - [Real Example](#real-example)
  - [Understanding Phred Quality Scores](#understanding-phred-quality-scores)
    - [What is a Phred Score?](#what-is-a-phred-score)
    - [The Math Behind Phred Scores](#the-math-behind-phred-scores)
    - [Phred Score Quality Table](#phred-score-quality-table)
    - [Visual Understanding](#visual-understanding)
  - [ASCII Encoding of Quality Scores](#ascii-encoding-of-quality-scores)
    - [Why Use ASCII Characters?](#why-use-ascii-characters)
    - [Phred+33 Encoding (Illumina 1.8+)](#phred33-encoding-illumina-18)
    - [ASCII Character Reference Table](#ascii-character-reference-table)
    - [How to Decode Quality Scores](#how-to-decode-quality-scores)
    - [Practice: Decode This Quality String](#practice-decode-this-quality-string)
  - [Setting Up the Environment](#setting-up-the-environment)
    - [Step 1: Create Conda Environment](#step-1-create-conda-environment)
    - [Step 2: Install QC Tools](#step-2-install-qc-tools)
    - [Step 3: Verify Installation](#step-3-verify-installation)
  - [Organizing Your Data](#organizing-your-data)
    - [Create Project Structure](#create-project-structure)
    - [Copy Raw Data](#copy-raw-data)
  - [FastQC: Quality Assessment](#fastqc-quality-assessment)
    - [What is FastQC?](#what-is-fastqc)
    - [Running FastQC](#running-fastqc)
      - [Basic Usage](#basic-usage)
      - [Expert Usage (Recommended)](#expert-usage-recommended)
    - [FastQC Command Options Explained](#fastqc-command-options-explained)
    - [Understanding FastQC Output](#understanding-fastqc-output)
      - [Output Files](#output-files)
      - [Key Modules in FastQC Report](#key-modules-in-fastqc-report)
    - [Interpreting FastQC Results](#interpreting-fastqc-results)
      - [1. Per Base Sequence Quality](#1-per-base-sequence-quality)
      - [2. Per Sequence Quality Scores](#2-per-sequence-quality-scores)
      - [3. Per Base Sequence Content](#3-per-base-sequence-content)
      - [4. GC Content](#4-gc-content)
      - [5. Sequence Duplication Levels](#5-sequence-duplication-levels)
      - [6. Overrepresented Sequences](#6-overrepresented-sequences)
      - [7. Adapter Content](#7-adapter-content)
  - [MultiQC: Aggregating Reports](#multiqc-aggregating-reports)
    - [What is MultiQC?](#what-is-multiqc)
    - [Setting Up MultiQC](#setting-up-multiqc)
    - [Running MultiQC](#running-multiqc)
      - [Basic Usage](#basic-usage-1)
      - [Expert Usage (Recommended)](#expert-usage-recommended-1)
    - [MultiQC Command Options Explained](#multiqc-command-options-explained)
    - [Understanding MultiQC Output](#understanding-multiqc-output)
  - [Fastp: Quality Control and Trimming](#fastp-quality-control-and-trimming)
    - [What is Fastp?](#what-is-fastp)
    - [Why Use Fastp?](#why-use-fastp)
    - [Running Fastp](#running-fastp)
      - [For Single-End Reads](#for-single-end-reads)
      - [For Paired-End Reads (Most Common)](#for-paired-end-reads-most-common)
      - [Expert Usage with All Options](#expert-usage-with-all-options)
    - [Fastp Options Explained](#fastp-options-explained)
    - [Understanding Fastp Output](#understanding-fastp-output)
  - [Complete QC Workflow](#complete-qc-workflow)
    - [Step-by-Step Pipeline](#step-by-step-pipeline)
    - [Bash Script for Automation](#bash-script-for-automation)
  - [Common QC Issues and Solutions](#common-qc-issues-and-solutions)
    - [Issue 1: Low Quality Scores at Read Ends](#issue-1-low-quality-scores-at-read-ends)
    - [Issue 2: Adapter Contamination](#issue-2-adapter-contamination)
    - [Issue 3: High Duplication Levels](#issue-3-high-duplication-levels)
    - [Issue 4: Abnormal GC Content](#issue-4-abnormal-gc-content)
    - [Issue 5: Overrepresented Sequences](#issue-5-overrepresented-sequences)
  - [Best Practices](#best-practices)
    - [Before Sequencing](#before-sequencing)
    - [During QC](#during-qc)
    - [After QC](#after-qc)
  - [Quick Reference Commands](#quick-reference-commands)
  - [Glossary](#glossary)
  - [Practice Exercise](#practice-exercise)
    - [Exercise: Complete QC Analysis](#exercise-complete-qc-analysis)
  - [Summary](#summary)
    - [Key Takeaways](#key-takeaways)
    - [QC Workflow Summary](#qc-workflow-summary)
  - [Desi examples for Short Reads QC](#desi-examples-for-short-reads-qc)
    - [Samjho Short Reads QC nu Lahori Andaaz main! 🧬🥘](#samjho-short-reads-qc-nu-lahori-andaaz-main-)
      - [Biryani te Sequencing: Ek Comparison](#biryani-te-sequencing-ek-comparison)
      - [Quality Score = Biryani di Quality](#quality-score--biryani-di-quality)
      - [FastQC = Dawakhana (Hospital) Jaana](#fastqc--dawakhana-hospital-jaana)
      - [Fastp = Nai (Barber) Wala Kaam](#fastp--nai-barber-wala-kaam)
      - [Adapter Contamination = Biryani mein Alu](#adapter-contamination--biryani-mein-alu)
      - [Duplication = Andhra Chicken Repeat](#duplication--andhra-chicken-repeat)
      - [GC Content = Biryani da Balance](#gc-content--biryani-da-balance)
      - [Complete Pipeline: Shaddi di Dawat Tayyar Karna](#complete-pipeline-shaddi-di-dawat-tayyar-karna)
      - [Quality Check Mnemonic (Yaad Rakhne di Trick)](#quality-check-mnemonic-yaad-rakhne-di-trick)
      - [Lahori Wisdom 🌟](#lahori-wisdom-)
      - [Practice Exercise: Anarkali Bazaar Style](#practice-exercise-anarkali-bazaar-style)

---

## Introduction

Quality Control (QC) is the **first and most critical step** in any bioinformatics analysis pipeline. Before analyzing your sequencing data, you must ensure that the data quality is good enough to produce reliable results.

### Why is Quality Control Important?

```
Raw Sequencing Data
        ↓
   ┌─────────────┐
   │  Quality    │  ← YOU ARE HERE!
   │  Control    │
   └─────────────┘
        ↓
   Downstream Analysis
   (Alignment, Assembly, Variant Calling, etc.)
```

1. **Garbage In, Garbage Out**: Poor quality data leads to unreliable results
2. **Identify Problems Early**: Detect issues before wasting time on analysis
3. **Save Resources**: Avoid re-running expensive analyses
4. **Ensure Reproducibility**: Document data quality for publications

### What Can Go Wrong Without QC?

| Problem | Consequence |
|---------|-------------|
| Low quality bases | False positive variants |
| Adapter contamination | Incorrect alignments |
| Contaminated samples | Mixed species results |
| Over-amplification | Biased quantification |
| Technical artifacts | Misleading conclusions |

---

## Understanding FASTQ Format

Before we can do QC, we need to understand the data format. Illumina sequencers produce **FASTQ** files.

### The Four Lines of FASTQ

Each sequencing read in a FASTQ file consists of exactly **4 lines**:

```
Line 1: @Sequence_Identifier (starts with @)
Line 2: Raw sequence (A, T, G, C, N)
Line 3: + (separator, sometimes repeats identifier)
Line 4: Quality scores (ASCII encoded)
```

### Real Example

```
@SRR123456.1 HWI-ST999:100:C6HKWANXX:1:1101:1234:2100 length=150
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTTNTGACCA
+
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65/A#####
```

**Breakdown:**

| Line | Content | Meaning |
|------|---------|---------|
| 1 | `@SRR123456.1...` | Unique read identifier + instrument info |
| 2 | `GATTTGGGG...` | The actual DNA sequence (150 bp) |
| 3 | `+` | Separator line |
| 4 | `!''*((((***...` | Quality score for EACH base (ASCII encoded) |

---

## Understanding Phred Quality Scores

### What is a Phred Score?

A **Phred score** (Q) is a measure of the quality of base calling. It represents the probability that a base call is **incorrect**.

> Named after the program "Phred" developed by Phil Green at the University of Washington.

### The Math Behind Phred Scores

```
Q = -10 × log₁₀(P)

Where:
Q = Phred quality score
P = Probability of incorrect base call
```

**Rearranging to find probability:**

```
P = 10^(-Q/10)
```

### Phred Score Quality Table

| Phred Score (Q) | Probability of Error | Accuracy | Quality |
|-----------------|---------------------|----------|---------|
| 10 | 1 in 10 (10%) | 90% | ❌ Poor |
| 20 | 1 in 100 (1%) | 99% | ⚠️ Acceptable |
| 30 | 1 in 1,000 (0.1%) | 99.9% | ✅ Good |
| 40 | 1 in 10,000 (0.01%) | 99.99% | ✅ Excellent |
| 50 | 1 in 100,000 (0.001%) | 99.999% | ✅ Perfect |

### Visual Understanding

```
Quality Score Scale:
0    10    20    30    40    50
|-----|-----|-----|-----|-----|
 Poor  Bad   OK   Good  Great

Illumina Data Typically:
- Good quality: Q ≥ 30
- Acceptable: Q ≥ 20
- Poor: Q < 20

Rule of Thumb:
🔴 Q < 20  → Consider trimming or discarding
🟡 Q 20-30 → Acceptable for most analyses
🟢 Q ≥ 30  → High confidence base calls
```

---

## ASCII Encoding of Quality Scores

### Why Use ASCII Characters?

Storing quality scores as numbers would take too much space:
- Number "40" = 2 characters
- ASCII character = 1 character

**Solution**: Encode each quality score as a single ASCII character!

### Phred+33 Encoding (Illumina 1.8+)

Modern Illumina sequencers use **Phred+33** encoding:

```
ASCII value = Phred score + 33
```

**Example:**
- Phred score = 30
- ASCII value = 30 + 33 = 63
- ASCII character = "?" (character with ASCII code 63)

### ASCII Character Reference Table

```
Quality Score → ASCII Character (Phred+33)

Score:  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
ASCII:  !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4

Score: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
ASCII:  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H

Score: 40 41 42
ASCII:  I  J  K
```

### How to Decode Quality Scores

**Step-by-step:**

1. Take an ASCII character from the quality line
2. Find its ASCII code (decimal value)
3. Subtract 33
4. Result = Phred quality score

**Example:**

```
Character: 'I'
ASCII code: 73
Phred score: 73 - 33 = 40

Character: '!'
ASCII code: 33
Phred score: 33 - 33 = 0

Character: '5'
ASCII code: 53
Phred score: 53 - 33 = 20
```

### Practice: Decode This Quality String

```
Quality string: IIIIIIIIIII5555!!!!!

Position 1-11: 'I' = Q40 (99.99% accurate) ✅ Excellent
Position 12-16: '5' = Q20 (99% accurate) ⚠️ OK
Position 17-21: '!' = Q0 (0% confident) ❌ Very Poor
```

---

## Setting Up the Environment

### Step 1: Create Conda Environment

```bash
# Create a new conda environment for QC
conda create -n short_read_qc -y

# Activate the environment
conda activate short_read_qc
```

**Why create a separate environment?**
- Isolates dependencies from other projects
- Ensures reproducibility
- Avoids package conflicts
- Easy to share with collaborators

### Step 2: Install QC Tools

```bash
# Install FastQC for quality assessment
conda install bioconda::fastqc -y

# Install fastp for quality control AND trimming
conda install bioconda::fastp -y
```

**What each tool does:**

| Tool | Purpose | Key Features |
|------|---------|--------------|
| **FastQC** | Quality assessment | Visual reports, identifies problems |
| **fastp** | QC + Trimming | All-in-one preprocessing |
| **MultiQC** | Report aggregation | Combines multiple reports |

### Step 3: Verify Installation

```bash
# Check FastQC version
fastqc --version
# Expected: FastQC v0.12.1 (or similar)

# Check fastp version
fastp --version
# Expected: fastp 0.23.4 (or similar)
```

---

## Organizing Your Data

Good organization is crucial for reproducible research!

### Create Project Structure

```bash
# Create organized directory structure
mkdir -p qc_analysis/{raw_data,fastqc_reports,fastp_output,multiqc_reports}

# Navigate to project directory
cd qc_analysis

# View structure
tree .
```

**Expected structure:**

```
qc_analysis/
├── raw_data/           # Original FASTQ files
├── fastqc_reports/     # FastQC output
├── fastp_output/       # Trimmed reads + reports
└── multiqc_reports/    # Aggregated reports
```

### Copy Raw Data

```bash
# Navigate to raw_data folder
cd raw_data

# Copy your FASTQ files (adjust path as needed)
cp /path/to/your/data/*.fastq.gz ./

# Or for the course data:
cp /home/codanics/00_bioinformatics_basics/01_grab_seqs/*.fastq.gz ./

# List files to verify
ls -lh *.fastq.gz
```

**Expected output:**

```
-rw-r--r-- 1 codanics codanics 1.2G Dec 10 10:00 sample1_R1.fastq.gz
-rw-r--r-- 1 codanics codanics 1.3G Dec 10 10:00 sample1_R2.fastq.gz
-rw-r--r-- 1 codanics codanics 1.1G Dec 10 10:00 sample2_R1.fastq.gz
-rw-r--r-- 1 codanics codanics 1.2G Dec 10 10:00 sample2_R2.fastq.gz
```

---

## FastQC: Quality Assessment

### What is FastQC?

**FastQC** is a quality control tool that provides a quick overview of your sequencing data quality through visual reports.

> 🔗 Official website: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

### Running FastQC

#### Basic Usage

```bash
# Activate environment
conda activate short_read_qc

# Navigate to data directory
cd raw_data

# Run FastQC on all FASTQ files
fastqc *
```

This creates `.html` and `.zip` files for each input file.

#### Expert Usage (Recommended)

```bash
# Create output directory
mkdir -p ../fastqc_reports

# Run FastQC with options
fastqc \
    -o ../fastqc_reports \
    --extract \
    --svg \
    -t 12 \
    *.fastq.gz
```

### FastQC Command Options Explained

| Option | Meaning | Why Use It? |
|--------|---------|-------------|
| `-o DIR` | Output directory | Keep reports organized |
| `--extract` | Extract zip files | Easy access to data files |
| `--svg` | Create SVG plots | Better quality for publications |
| `-t N` | Number of threads | Faster processing (use # of CPU cores) |
| `--noextract` | Don't extract zips | Save disk space |
| `-q` | Quiet mode | Less verbose output |

**Full command breakdown:**

```bash
fastqc \
    -o ../fastqc_reports \     # Output to specific folder
    --extract \                # Auto-extract the zip files
    --svg \                    # Generate SVG images (scalable)
    -t 12 \                    # Use 12 CPU threads
    *.fastq.gz                 # Process all gzipped FASTQ files
```

### Understanding FastQC Output

#### Output Files

For each input file (e.g., `sample1_R1.fastq.gz`), FastQC creates:

```
sample1_R1_fastqc.html    # Visual report (open in browser)
sample1_R1_fastqc.zip     # Zipped results
sample1_R1_fastqc/        # Extracted folder (if --extract used)
├── fastqc_data.txt       # Raw data for each module
├── fastqc_report.html    # Same as above HTML
├── Icons/                # Icons for report
├── Images/               # PNG/SVG plots
└── summary.txt           # Pass/Warn/Fail summary
```

#### Key Modules in FastQC Report

| Module | What It Shows | What to Look For |
|--------|---------------|------------------|
| **Basic Statistics** | File info, # reads, length | Verify expected values |
| **Per Base Sequence Quality** | Quality across read | Should be mostly green (Q>28) |
| **Per Sequence Quality Scores** | Overall quality distribution | Peak should be Q>30 |
| **Per Base Sequence Content** | A/T/G/C proportions | Should be ~parallel lines |
| **Per Sequence GC Content** | GC distribution | Should match expected genome |
| **Sequence Duplication** | Duplicate levels | High = over-amplification |
| **Overrepresented Sequences** | Common sequences | May indicate adapters/primers |
| **Adapter Content** | Adapter contamination | Should be near 0% |

### Interpreting FastQC Results

#### 1. Per Base Sequence Quality

**Good Result:**
```
Position:  1    50   100  150
Quality:   🟢   🟢   🟢   🟡
           38   36   34   28

Green zone (Q>28): Good quality
Yellow zone (Q20-28): Acceptable
Red zone (Q<20): Poor - consider trimming
```

**What it means:**
- Quality typically decreases toward the 3' end of reads
- Some quality drop at the end is normal
- Severe drops indicate sequencing problems

#### 2. Per Sequence Quality Scores

**Good Result:**
```
Most reads should have mean quality >30

Distribution:
        ▓
       ▓▓▓
      ▓▓▓▓▓
    ▓▓▓▓▓▓▓▓
|-----|-----|-----|-----|
0    10    20    30    40
              Peak here → Good!
```

#### 3. Per Base Sequence Content

**Good Result:**
```
%A and %T should be similar (~parallel)
%G and %C should be similar (~parallel)

Position: 1    50   100  150
%A:       25   26   25   25   ═══════
%T:       25   25   26   25   ═══════
%G:       25   24   24   25   ═══════
%C:       25   25   25   25   ═══════
```

**Warning Signs:**
- First 10-15 bases often show bias (random hexamer priming) - usually OK
- Large fluctuations throughout = contamination or bias

#### 4. GC Content

**Good Result:**
```
Should follow normal distribution
Peak should match expected genome GC%

Human genome: ~40-41% GC
E. coli: ~50% GC
AT-rich organisms: <40% GC

Distribution should be:
        ▓▓▓
      ▓▓▓▓▓▓▓
    ▓▓▓▓▓▓▓▓▓▓▓
|-----|-----|-----|
20%   40%   60%   80%
      Peak here (for human)
```

#### 5. Sequence Duplication Levels

**Understanding Duplication:**
```
Expected for different library types:

RNA-seq: Some duplication expected (highly expressed genes)
WGS: Low duplication expected
Amplicon: High duplication expected

>50% unique sequences = Generally good
<20% unique sequences = May indicate over-amplification
```

#### 6. Overrepresented Sequences

**What to check:**
- Adapter sequences (should be trimmed)
- Primer sequences
- rRNA contamination
- Poly-A/T sequences

**Example output:**
```
Sequence                              Count    %     Source
AGATCGGAAGAGCACACGTCTGAACTCCAGTCA    50000   2.5   TruSeq Adapter
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA     10000   0.5   Poly-A
```

#### 7. Adapter Content

**Good Result:**
```
Position:  1    50   100  150
Adapter%:  0%   0%   0%   0.5%

All lines should be near 0%
High adapter content = reads contain adapter sequences
Solution: Trim adapters with fastp or Trimmomatic
```

---

## MultiQC: Aggregating Reports

### What is MultiQC?

**MultiQC** aggregates results from multiple bioinformatics tools into a single, interactive HTML report.

> 🔗 Official website: https://multiqc.info/

### Setting Up MultiQC

```bash
# Create separate environment (recommended)
conda create -n multiqc -y
conda activate multiqc

# Install MultiQC
conda install bioconda::multiqc -y

# Verify installation
multiqc --version
```

### Running MultiQC

#### Basic Usage

```bash
# Navigate to directory containing FastQC reports
cd fastqc_reports

# Run MultiQC
multiqc .
```

This creates `multiqc_report.html` and `multiqc_data/` folder.

#### Expert Usage (Recommended)

```bash
# Run with additional options
multiqc \
    -p \
    -o ../multiqc_reports \
    -n fastqc_summary \
    --title "My Project QC Report" \
    ./fastqc_reports
```

### MultiQC Command Options Explained

| Option | Meaning | Why Use It? |
|--------|---------|-------------|
| `-p` | Export plots | Get separate plot files |
| `-o DIR` | Output directory | Organize output |
| `-n NAME` | Report filename | Custom naming |
| `--title` | Report title | For publication/sharing |
| `-f` | Force overwrite | Replace existing reports |
| `--interactive` | Interactive plots | Zoomable charts |
| `-c CONFIG` | Config file | Custom settings |

### Understanding MultiQC Output

**Output files:**
```
multiqc_reports/
├── fastqc_summary.html          # Main interactive report
├── multiqc_data/                # Raw data
│   ├── multiqc_fastqc.txt       # FastQC summary data
│   ├── multiqc_general_stats.txt
│   └── multiqc_sources.txt
└── multiqc_plots/               # If -p was used
    ├── png/
    └── svg/
```

**What MultiQC shows:**
1. General statistics table (all samples)
2. Per-base quality across all samples
3. Per-sequence quality scores
4. Per-sequence GC content
5. Sequence duplication levels
6. Adapter content
7. Status checks (Pass/Warn/Fail) summary

---

## Fastp: Quality Control and Trimming

### What is Fastp?

**Fastp** is an ultra-fast all-in-one FASTQ preprocessor that performs:
- Quality profiling (like FastQC)
- Adapter trimming
- Quality filtering
- Read trimming
- Polyg/X tail trimming
- Deduplication (optional)

> 🔗 GitHub: https://github.com/OpenGene/fastp

### Why Use Fastp?

| Feature | FastQC | fastp |
|---------|--------|-------|
| Quality report | ✅ | ✅ |
| Trimming | ❌ | ✅ |
| Filtering | ❌ | ✅ |
| Speed | Fast | Very Fast |
| All-in-one | ❌ | ✅ |

### Running Fastp

#### For Single-End Reads

```bash
fastp \
    -i input.fastq.gz \
    -o output_trimmed.fastq.gz \
    -h report.html \
    -j report.json
```

#### For Paired-End Reads (Most Common)

```bash
fastp \
    -i sample_R1.fastq.gz \
    -I sample_R2.fastq.gz \
    -o sample_R1_trimmed.fastq.gz \
    -O sample_R2_trimmed.fastq.gz \
    -h sample_fastp_report.html \
    -j sample_fastp_report.json
```

#### Expert Usage with All Options

```bash
# Create output directory
mkdir -p ../fastp_output

# Run fastp with comprehensive options
fastp \
    --in1 sample_R1.fastq.gz \
    --in2 sample_R2.fastq.gz \
    --out1 ../fastp_output/sample_R1_clean.fastq.gz \
    --out2 ../fastp_output/sample_R2_clean.fastq.gz \
    --unpaired1 ../fastp_output/sample_unpaired_R1.fastq.gz \
    --unpaired2 ../fastp_output/sample_unpaired_R2.fastq.gz \
    --failed_out ../fastp_output/sample_failed.fastq.gz \
    --html ../fastp_output/sample_fastp.html \
    --json ../fastp_output/sample_fastp.json \
    --thread 12 \
    --qualified_quality_phred 20 \
    --unqualified_percent_limit 40 \
    --n_base_limit 5 \
    --length_required 50 \
    --cut_front \
    --cut_tail \
    --cut_window_size 4 \
    --cut_mean_quality 20 \
    --detect_adapter_for_pe \
    --correction \
    --overrepresentation_analysis \
    --report_title "Sample QC Report"
```

### Fastp Options Explained

| Option | Meaning | Default | Recommendation |
|--------|---------|---------|----------------|
| `--in1/-i` | Input R1 file | - | Required |
| `--in2/-I` | Input R2 file | - | For paired-end |
| `--out1/-o` | Output R1 file | - | Required |
| `--out2/-O` | Output R2 file | - | For paired-end |
| `--unpaired1` | Unpaired R1 output | - | Keep orphan reads |
| `--unpaired2` | Unpaired R2 output | - | Keep orphan reads |
| `--failed_out` | Failed reads output | - | For troubleshooting |
| `--html/-h` | HTML report | - | Always use |
| `--json/-j` | JSON report | - | For MultiQC |
| `--thread/-w` | CPU threads | 3 | Use available cores |
| `--qualified_quality_phred/-q` | Min quality | 15 | 20 for stringent |
| `--unqualified_percent_limit/-u` | Max low-qual % | 40 | Lower for stringent |
| `--n_base_limit/-n` | Max N bases | 5 | 5 is good |
| `--length_required/-l` | Min read length | 15 | 50 for Illumina |
| `--cut_front/-5` | Trim 5' end | off | Use sliding window |
| `--cut_tail/-3` | Trim 3' end | off | Use sliding window |
| `--cut_window_size` | Window size | 4 | 4 is good |
| `--cut_mean_quality/-M` | Min window qual | 20 | 20 is standard |
| `--detect_adapter_for_pe` | Auto-detect adapters | off | Always use for PE |
| `--correction` | Base correction | off | Use for PE reads |
| `--dedup` | Remove duplicates | off | Use for PCR libraries |

### Understanding Fastp Output

**Output files:**
```
fastp_output/
├── sample_R1_clean.fastq.gz       # Trimmed R1 reads
├── sample_R2_clean.fastq.gz       # Trimmed R2 reads
├── sample_unpaired_R1.fastq.gz    # Orphan R1 reads
├── sample_unpaired_R2.fastq.gz    # Orphan R2 reads
├── sample_failed.fastq.gz         # Failed reads
├── sample_fastp.html              # Visual report
└── sample_fastp.json              # Machine-readable report
```

**Fastp HTML report includes:**
1. Summary statistics (before/after filtering)
2. Read quality graphs
3. Base content
4. KMER analysis
5. Adapter detection results
6. Duplication rate
7. Insert size distribution (paired-end)

---

## Complete QC Workflow

### Step-by-Step Pipeline

```bash
#!/bin/bash
# Complete QC Pipeline for Illumina Short Reads

# ============================================
# STEP 0: Setup
# ============================================
PROJECT_DIR="/home/codanics/qc_analysis"
RAW_DATA="${PROJECT_DIR}/raw_data"
FASTQC_OUT="${PROJECT_DIR}/fastqc_reports"
FASTP_OUT="${PROJECT_DIR}/fastp_output"
MULTIQC_OUT="${PROJECT_DIR}/multiqc_reports"
THREADS=12

# Create directories
mkdir -p ${RAW_DATA} ${FASTQC_OUT} ${FASTP_OUT} ${MULTIQC_OUT}

# ============================================
# STEP 1: Initial Quality Check with FastQC
# ============================================
echo "Step 1: Running FastQC on raw data..."
conda activate short_read_qc

fastqc \
    -o ${FASTQC_OUT}/raw \
    --extract \
    -t ${THREADS} \
    ${RAW_DATA}/*.fastq.gz

# ============================================
# STEP 2: Trimming and Filtering with Fastp
# ============================================
echo "Step 2: Running fastp..."

# Loop through paired-end samples
for R1 in ${RAW_DATA}/*_R1.fastq.gz; do
    # Get sample name and R2 file
    SAMPLE=$(basename ${R1} _R1.fastq.gz)
    R2="${RAW_DATA}/${SAMPLE}_R2.fastq.gz"
    
    echo "Processing: ${SAMPLE}"
    
    fastp \
        --in1 ${R1} \
        --in2 ${R2} \
        --out1 ${FASTP_OUT}/${SAMPLE}_R1_clean.fastq.gz \
        --out2 ${FASTP_OUT}/${SAMPLE}_R2_clean.fastq.gz \
        --html ${FASTP_OUT}/${SAMPLE}_fastp.html \
        --json ${FASTP_OUT}/${SAMPLE}_fastp.json \
        --thread ${THREADS} \
        --qualified_quality_phred 20 \
        --length_required 50 \
        --cut_front \
        --cut_tail \
        --cut_mean_quality 20 \
        --detect_adapter_for_pe
done

# ============================================
# STEP 3: Post-trimming Quality Check
# ============================================
echo "Step 3: Running FastQC on cleaned data..."

mkdir -p ${FASTQC_OUT}/clean

fastqc \
    -o ${FASTQC_OUT}/clean \
    --extract \
    -t ${THREADS} \
    ${FASTP_OUT}/*_clean.fastq.gz

# ============================================
# STEP 4: Aggregate Reports with MultiQC
# ============================================
echo "Step 4: Running MultiQC..."
conda activate multiqc

# Aggregate all reports
multiqc \
    -p \
    -f \
    -o ${MULTIQC_OUT} \
    -n complete_qc_report \
    --title "Complete QC Report" \
    ${FASTQC_OUT} ${FASTP_OUT}

echo "QC Pipeline Complete!"
echo "Check reports at: ${MULTIQC_OUT}/complete_qc_report.html"
```

### Bash Script for Automation

Save the above as `run_qc_pipeline.sh` and run:

```bash
# Make executable
chmod +x run_qc_pipeline.sh

# Run the pipeline
./run_qc_pipeline.sh
```

---

## Common QC Issues and Solutions

### Issue 1: Low Quality Scores at Read Ends

**Symptoms:**
- FastQC shows quality drop at 3' end
- Yellow/red zone in per-base quality plot

**Solution:**
```bash
# Trim low quality bases with fastp
fastp \
    -i input.fastq.gz \
    -o output.fastq.gz \
    --cut_tail \
    --cut_mean_quality 20
```

### Issue 2: Adapter Contamination

**Symptoms:**
- High adapter content in FastQC
- Overrepresented sequences show adapter

**Solution:**
```bash
# fastp auto-detects and removes adapters
fastp \
    -i input_R1.fastq.gz \
    -I input_R2.fastq.gz \
    -o output_R1.fastq.gz \
    -O output_R2.fastq.gz \
    --detect_adapter_for_pe

# Or specify adapters manually
fastp \
    --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
    --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
    ...
```

### Issue 3: High Duplication Levels

**Symptoms:**
- Low unique read percentage
- Possible over-amplification

**Solution:**
```bash
# Remove duplicates (use carefully - affects quantification!)
fastp \
    -i input.fastq.gz \
    -o output.fastq.gz \
    --dedup

# Note: For RNA-seq, high duplication may be biological (highly expressed genes)
# Consider NOT removing duplicates for RNA-seq
```

### Issue 4: Abnormal GC Content

**Symptoms:**
- GC distribution doesn't match expected
- Multiple peaks in GC plot

**Possible causes:**
- Contamination from other organisms
- Library preparation bias
- Sample quality issues

**Solution:**
- Check for contamination with Kraken2 or similar
- Review wet lab protocols
- Consider resequencing

### Issue 5: Overrepresented Sequences

**Symptoms:**
- High percentage of reads match specific sequences
- May indicate primers, adapters, or rRNA

**Solution:**
```bash
# Check what the sequences are
grep -A 1 "AGATCGGAAGAG" input.fastq | head

# Remove with fastp
fastp \
    --overrepresentation_analysis \
    ...
```

---

## Best Practices

### Before Sequencing

1. ✅ Ensure high-quality DNA/RNA input
2. ✅ Use appropriate library preparation kit
3. ✅ Check input quantity (Qubit, Bioanalyzer)
4. ✅ Include positive/negative controls

### During QC

1. ✅ Always run FastQC on raw data first
2. ✅ Document all parameters used
3. ✅ Compare samples to identify outliers
4. ✅ Keep raw data - never modify originals
5. ✅ Use consistent naming conventions

### After QC

1. ✅ Verify trimmed data with FastQC again
2. ✅ Check read loss statistics
3. ✅ Archive raw data securely
4. ✅ Document QC decisions for methods section
5. ✅ Generate MultiQC report for overview

---

## Quick Reference Commands

```bash
# ========================================
# ENVIRONMENT SETUP
# ========================================
conda create -n short_read_qc -y
conda activate short_read_qc
conda install bioconda::fastqc bioconda::fastp -y

# ========================================
# FASTQC
# ========================================
# Basic
fastqc *.fastq.gz

# Expert
fastqc -o reports --extract --svg -t 12 *.fastq.gz

# ========================================
# MULTIQC
# ========================================
conda create -n multiqc -y && conda activate multiqc
conda install bioconda::multiqc -y

# Basic
multiqc .

# Expert
multiqc -p -o output_dir -n report_name ./input_dir

# ========================================
# FASTP (Paired-End)
# ========================================
# Basic
fastp -i R1.fastq.gz -I R2.fastq.gz -o R1_clean.fastq.gz -O R2_clean.fastq.gz

# Expert
fastp \
    -i R1.fastq.gz -I R2.fastq.gz \
    -o R1_clean.fastq.gz -O R2_clean.fastq.gz \
    -h report.html -j report.json \
    -w 12 -q 20 -l 50 \
    --cut_front --cut_tail --cut_mean_quality 20 \
    --detect_adapter_for_pe

# ========================================
# COUNT READS
# ========================================
# Count reads in FASTQ
zcat file.fastq.gz | echo $((`wc -l`/4))

# Or using seqkit
seqkit stats *.fastq.gz
```

---

## Glossary

| Term | Definition |
|------|------------|
| **ASCII** | American Standard Code for Information Interchange - character encoding |
| **Adapter** | Short synthetic DNA sequences added during library prep |
| **Base calling** | Converting raw signals to nucleotide sequences |
| **Duplication** | Multiple identical reads (PCR duplicates or biological) |
| **FASTQ** | Text format for sequences + quality scores |
| **GC content** | Percentage of G and C nucleotides |
| **Homopolymer** | Run of identical nucleotides (AAAA, TTTT, etc.) |
| **Paired-end** | Sequencing both ends of DNA fragment |
| **Phred score** | Logarithmic quality score (Q = -10 log₁₀ P) |
| **QC** | Quality Control |
| **Read** | Single sequenced DNA fragment |
| **Trimming** | Removing low-quality bases or adapters |

---

## Practice Exercise

### Exercise: Complete QC Analysis

**Objective:** Perform quality control on provided sample data

**Steps:**

1. **Setup environment:**
```bash
conda create -n qc_practice -y
conda activate qc_practice
conda install bioconda::fastqc bioconda::fastp -y
```

2. **Download practice data:**
```bash
# Use your course data or download from SRA
mkdir qc_practice && cd qc_practice
# Copy sample files here
```

3. **Run initial FastQC:**
```bash
mkdir raw_fastqc
fastqc -o raw_fastqc -t 4 *.fastq.gz
```

4. **Analyze the reports:**
   - Open HTML reports in browser
   - Note any issues (quality, adapters, etc.)
   - Document your findings

5. **Run fastp for trimming:**
```bash
fastp \
    -i sample_R1.fastq.gz \
    -I sample_R2.fastq.gz \
    -o sample_R1_clean.fastq.gz \
    -O sample_R2_clean.fastq.gz \
    -h fastp_report.html \
    --detect_adapter_for_pe \
    -q 20 -l 50
```

6. **Run post-trim FastQC:**
```bash
mkdir clean_fastqc
fastqc -o clean_fastqc -t 4 *_clean.fastq.gz
```

7. **Compare before/after:**
   - Create MultiQC report
   - Compare quality metrics
   - Document improvement

**Questions to answer:**
1. What was the initial quality like?
2. What adapters were detected (if any)?
3. How many reads were removed?
4. Did quality improve after trimming?

---

## Summary

### Key Takeaways

1. **QC is essential** - Always check data quality before analysis
2. **Understand Phred scores** - Q30 = 99.9% accuracy = good quality
3. **ASCII encoding** - Quality stored as characters (Phred + 33)
4. **FastQC** - Visual quality assessment (doesn't modify data)
5. **fastp** - All-in-one trimming and filtering
6. **MultiQC** - Aggregate multiple reports

### QC Workflow Summary

```
Raw FASTQ Files
      ↓
FastQC (initial assessment)
      ↓
fastp (trimming + filtering)
      ↓
FastQC (verify improvement)
      ↓
MultiQC (aggregate reports)
      ↓
Ready for Downstream Analysis!
```

---

## Desi examples for Short Reads QC
### Samjho Short Reads QC nu Lahori Andaaz main! 🧬🥘

Oye! QC samajhna hai? Chalo ji, ek biryani ki misaal naal samjhte haan!

#### Biryani te Sequencing: Ek Comparison

| Biryani Banani | Sequencing Data |
|----------------|-----------------|
| **Chaawal (Rice)** | Raw Reads |
| **Masalay (Spices)** | Quality Scores |
| **Kankar (Stones in rice)** | Low Quality Bases |
| **Alu (Potato)** | Adapter Sequences |
| **Mirch (Chili)** | Contamination |

#### Quality Score = Biryani di Quality

```
Phred Score 40: Wah ji wah! Lakshmi Chowk waali biryani! 🌟
Phred Score 30: Achi biryani hai ji, kha sakte ho
Phred Score 20: Thori si masala kami hai, chalega
Phred Score 10: Bhai ye kaisi biryani hai? Pani pata hi nahi!
Phred Score 0:  Oye hoye! Ye taan khraab ho gayi! 🤢
```

#### FastQC = Dawakhana (Hospital) Jaana

Jaise doctor pehle checkup karta hai, waise hi FastQC pehle data check karta hai:

```bash
# Doctor saab nu bulao (FastQC run karo)
fastqc mere_sample.fastq.gz

# Doctor ki report dekho
# Green = "Mooh dikhao beta, theek ho!"
# Yellow = "Thori medicine lo"  
# Red = "Oye! Hospital dakhil hona paega!"
```

#### Fastp = Nai (Barber) Wala Kaam

Jaise Lakshmi Chowk da nai baal kaatda hai, waise fastp kharab bases trim karda hai:

```bash
# Nai saab nu bulao
fastp \
    -i kharab_baal.fastq.gz \    # Pehle waale lambe baal
    -o saaf_baal.fastq.gz \       # Trim hoe saaf baal
    --cut_tail \                   # Pichhle baal kaat do
    --cut_front                    # Aggey waale bhi thore
```

#### Adapter Contamination = Biryani mein Alu

```
Asli Hyderabadi: "Biryani mein alu? Taubah taubah!"
Lahori Banda:    "Alu de bina biryani kiven?"

Bioinformatician: "Adapter sequences = unwanted alu"
                  "fastp se hata do, pure chawal raho!"
```

**Remove adapters:**
```bash
fastp --detect_adapter_for_pe \   # Alu dhoondhdo
    -i biryani_R1.fastq.gz \
    -I biryani_R2.fastq.gz \
    -o asli_biryani_R1.fastq.gz \  # Bina alu di biryani
    -O asli_biryani_R2.fastq.gz
```

#### Duplication = Andhra Chicken Repeat

Jaise wedding mein uncle kehte hain: *"Beta, ek aur plate le ao!"*

```
High Duplication:
Uncle 1: "Chicken!"
Uncle 2: "Chicken!"
Uncle 3: "Chicken!"
Uncle 4: "Chicken!"

Ye taan wohi uncle baar baar aa rahe hain! 😄

Solution:
fastp --dedup   # Ek uncle ek baar hi count hoga
```

#### GC Content = Biryani da Balance

```
Perfect Biryani (40% GC):
   🍚 Chawal = 60%
   🍗 Gosht = 40%
   
Kharab Balance:
   🍚🍚🍚 Sirf Chawal = "Ye taan pulao ban gaya!"
   🍗🍗🍗 Sirf Gosht = "Ye taan karahi hai!"
```

#### Complete Pipeline: Shaddi di Dawat Tayyar Karna

```bash
#!/bin/bash
# Lahori Wedding Biryani Pipeline

# Step 1: Dawakhana (Health Check)
echo "Doctor saab, check kar lo..."
fastqc raw_data/*.fastq.gz

# Step 2: Nai da Kaam (Trimming)
echo "Nai saab, thora kaato..."
fastp -i raw_R1.fastq.gz -I raw_R2.fastq.gz \
    -o clean_R1.fastq.gz -O clean_R2.fastq.gz

# Step 3: Dobaara Check
echo "Doctor saab, ab dekho..."
fastqc clean_*.fastq.gz

# Step 4: Final Report
echo "Shaddi di dawat tayyar hai ji! 🎉"
multiqc .
```

#### Quality Check Mnemonic (Yaad Rakhne di Trick)

**F.A.S.T.Q = Foran Achhi Safai Tayyar Q(uality)**

```
F - FastQC pehle chalao
A - Adapter hata do  
S - Score 30 se upar rako
T - Tail trim karo (3' end)
Q - Quality report banao
```

#### Lahori Wisdom 🌟

> *"Jithe biryani di quality nahi, othe mehman nahi aunde.*
> *Jithe data di quality nahi, othe paper nahi publish hunda!"*

#### Practice Exercise: Anarkali Bazaar Style

```bash
# Anarkali Bazaar mein shopping jaisa hai QC:

# 1. Pehle maal dekho (FastQC)
fastqc kapray.fastq.gz

# 2. Kharab wala hata do (fastp)
fastp -i kapray.fastq.gz -o sahi_kapray.fastq.gz

# 3. Fir se check karo (FastQC again)
fastqc sahi_kapray.fastq.gz

# 4. Sab ka hisaab (MultiQC)
multiqc .

# Ab shaddi mein jaane di tayyari ho gayi! 👔🎊
```

---

**Yaad Rakho:**
- Q30 = Lakshmi Chowk ki biryani 🔥
- Q20 = Street food, chalega
- Q10 = Mat khao, pet kharab ho jaega!

*"Jitni achi QC, utna acha result!"* 🧬✨

---
**Happy QC-ing! 🔬💻**

*Remember: Good quality data leads to reliable results!*

---

>*Last Updated: December 2025*\
>*Course: Bioinformatics Ka Chilla 2025-2026*\
>*Instructor: Dr. Muhammad Aammar Tufail*\
>*Website: [www.codanics.com/bioinformatics-ka-chilla](https://www.codanics.com/bioinformatics-ka-chilla)*