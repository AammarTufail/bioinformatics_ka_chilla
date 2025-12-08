# 🧬 DNA Sequencing Technologies: A Complete Guide

## Table of Contents

- [🧬 DNA Sequencing Technologies: A Complete Guide](#-dna-sequencing-technologies-a-complete-guide)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Why Learn About Sequencing Technologies?](#why-learn-about-sequencing-technologies)
  - [What is DNA Sequencing?](#what-is-dna-sequencing)
    - [Simple Analogy 📚](#simple-analogy-)
    - [The Central Dogma Connection](#the-central-dogma-connection)
  - [Generations of Sequencing](#generations-of-sequencing)
    - [🥇 First Generation: Sanger Sequencing (1977)](#-first-generation-sanger-sequencing-1977)
    - [🥈 Second Generation: Next-Generation Sequencing (NGS)](#-second-generation-next-generation-sequencing-ngs)
    - [🥉 Third Generation: Long-Read Sequencing](#-third-generation-long-read-sequencing)
  - [Illumina Sequencing (Short-Read)](#illumina-sequencing-short-read)
    - [📺 Watch This First!](#-watch-this-first)
    - [Overview](#overview)
    - [How It Works: Sequencing by Synthesis (SBS)](#how-it-works-sequencing-by-synthesis-sbs)
      - [Step 1: Library Preparation](#step-1-library-preparation)
      - [Step 2: Cluster Generation (Bridge Amplification)](#step-2-cluster-generation-bridge-amplification)
      - [Step 3: Sequencing by Synthesis](#step-3-sequencing-by-synthesis)
    - [Illumina Platforms](#illumina-platforms)
    - [Error Profile](#error-profile)
    - [Output Files](#output-files)
  - [Oxford Nanopore Sequencing (Long-Read)](#oxford-nanopore-sequencing-long-read)
    - [📺 Watch These Videos First!](#-watch-these-videos-first)
    - [Overview](#overview-1)
    - [How It Works: Nanopore Sequencing](#how-it-works-nanopore-sequencing)
      - [The Basic Principle](#the-basic-principle)
      - [Step-by-Step Process](#step-by-step-process)
    - [Nanopore Platforms](#nanopore-platforms)
    - [Key Features](#key-features)
      - [1. Ultra-Long Reads](#1-ultra-long-reads)
      - [2. Real-Time Sequencing](#2-real-time-sequencing)
      - [3. Direct RNA Sequencing](#3-direct-rna-sequencing)
    - [Error Profile](#error-profile-1)
    - [Output Files](#output-files-1)
  - [PacBio Sequencing (Long-Read)](#pacbio-sequencing-long-read)
    - [📺 Watch This Video First!](#-watch-this-video-first)
    - [Overview](#overview-2)
    - [How It Works: SMRT Sequencing](#how-it-works-smrt-sequencing)
      - [The ZMW (Zero-Mode Waveguide)](#the-zmw-zero-mode-waveguide)
      - [Step-by-Step Process](#step-by-step-process-1)
    - [PacBio Platforms](#pacbio-platforms)
    - [Read Types](#read-types)
      - [1. CLR (Continuous Long Reads)](#1-clr-continuous-long-reads)
      - [2. HiFi Reads (Circular Consensus Sequencing)](#2-hifi-reads-circular-consensus-sequencing)
    - [Error Profile](#error-profile-2)
    - [Output Files](#output-files-2)
  - [Single-End vs Paired-End Reads](#single-end-vs-paired-end-reads)
    - [What Are They?](#what-are-they)
      - [Single-End (SE) Reads](#single-end-se-reads)
      - [Paired-End (PE) Reads](#paired-end-pe-reads)
    - [Visual Comparison](#visual-comparison)
    - [Advantages of Paired-End](#advantages-of-paired-end)
    - [When to Use Each](#when-to-use-each)
      - [Use Single-End When:](#use-single-end-when)
      - [Use Paired-End When:](#use-paired-end-when)
    - [Insert Size](#insert-size)
    - [File Naming Convention](#file-naming-convention)
  - [Coverage Depth](#coverage-depth)
    - [What is Coverage?](#what-is-coverage)
    - [Why is Coverage Important?](#why-is-coverage-important)
  - [Comparison of Technologies](#comparison-of-technologies)
    - [Quick Comparison Table](#quick-comparison-table)
    - [Visual Comparison](#visual-comparison-1)
    - [Choosing Based on Application](#choosing-based-on-application)
  - [Choosing the Right Technology](#choosing-the-right-technology)
    - [Decision Flowchart](#decision-flowchart)
    - [Hybrid Approaches](#hybrid-approaches)
  - [Video Resources](#video-resources)
    - [📺 Must-Watch Videos](#-must-watch-videos)
      - [Illumina Sequencing](#illumina-sequencing)
      - [Oxford Nanopore Sequencing](#oxford-nanopore-sequencing)
      - [PacBio Sequencing](#pacbio-sequencing)
  - [Glossary](#glossary)
  - [Desi tarkay wali understanding about sequencing!](#desi-tarkay-wali-understanding-about-sequencing)
    - [🇵🇰 Pakistani Style Analogies for Sequencing Technologies](#-pakistani-style-analogies-for-sequencing-technologies)
      - [Illumina Sequencing = Paratha Rolls at a Dhaba 🥙](#illumina-sequencing--paratha-rolls-at-a-dhaba-)
      - [Nanopore Sequencing = Gol Gappay Wala 🍽️](#nanopore-sequencing--gol-gappay-wala-️)
      - [PacBio HiFi = Biryani Making 🍚](#pacbio-hifi--biryani-making-)
      - [Single-End vs Paired-End = Chappal vs Joota 👟](#single-end-vs-paired-end--chappal-vs-joota-)
      - [Coverage Depth = Chai Ki Patti 🍵](#coverage-depth--chai-ki-patti-)
    - [Technology Selection = Choosing the Right Khana for the Occasion](#technology-selection--choosing-the-right-khana-for-the-occasion)
    - [🎯 Desi Summary](#-desi-summary)
  - [Practice Questions](#practice-questions)
    - [Multiple Choice](#multiple-choice)
    - [Short Answer](#short-answer)
    - [Answers](#answers)
  - [Summary](#summary)
    - [Key Takeaways](#key-takeaways)


---

## Introduction

Welcome to the world of DNA sequencing! 🎉

Understanding sequencing technologies is fundamental for any bioinformatician. In this guide, we'll explore the three major sequencing platforms used today and understand when to use each one.

### Why Learn About Sequencing Technologies?

As a bioinformatician, you need to understand:
- **How data is generated** → Helps you understand data quality and limitations
- **What errors to expect** → Different technologies have different error profiles
- **Which technology to recommend** → For different research questions
- **How to analyze the data** → Different data requires different pipelines

---

## What is DNA Sequencing?

**DNA sequencing** is the process of determining the order of nucleotides (A, T, G, C) in a DNA molecule.

### Simple Analogy 📚

Think of DNA as a very long book written in a 4-letter alphabet (A, T, G, C):
- **Sequencing** = Reading the book
- **Short-read sequencing** = Reading small snippets (100-300 letters at a time)
- **Long-read sequencing** = Reading entire pages or chapters (10,000-100,000+ letters)

### The Central Dogma Connection

```
DNA → RNA → Protein
 ↑
 We sequence here!
```

Understanding the DNA sequence helps us understand:
- Gene structure and function
- Genetic variations (mutations, SNPs)
- Evolutionary relationships
- Disease mechanisms

---

## Generations of Sequencing

### 🥇 First Generation: Sanger Sequencing (1977)
- **Invented by**: Frederick Sanger
- **Read length**: Up to ~1000 bp
- **Throughput**: Low (one sequence at a time)
- **Still used for**: Validation, small-scale projects

### 🥈 Second Generation: Next-Generation Sequencing (NGS)
- **Examples**: Illumina, Ion Torrent
- **Read length**: 50-300 bp (short reads)
- **Throughput**: Very high (millions of reads)
- **Also called**: Short-read sequencing, High-throughput sequencing

### 🥉 Third Generation: Long-Read Sequencing
- **Examples**: Oxford Nanopore, PacBio
- **Read length**: 10,000 - 2,000,000+ bp
- **Throughput**: Moderate to high
- **Also called**: Single-molecule sequencing

---

## Illumina Sequencing (Short-Read)

### 📺 Watch This First!

Before reading further, watch this excellent video explaining Illumina sequencing:

🎬 **[Illumina Sequencing by Synthesis](https://www.youtube.com/watch?v=fCd6B5HRaZ8)**

---

### Overview

**Illumina** is the most widely used sequencing platform in the world. It's known for:
- ✅ Very high accuracy (>99.9%)
- ✅ Low cost per base
- ✅ High throughput (billions of reads)
- ❌ Short read lengths (75-300 bp)

### How It Works: Sequencing by Synthesis (SBS)

#### Step 1: Library Preparation
```
Original DNA
    ↓
Fragment into small pieces (200-500 bp)
    ↓
Add adapters to both ends
    ↓
    [Adapter]---[DNA Fragment]---[Adapter]
```

#### Step 2: Cluster Generation (Bridge Amplification)

```
1. DNA fragments bind to flow cell surface
   
   Flow Cell Surface
   |||||||||||||||||||
        🧬
   
2. Bridge amplification creates clusters
   
   |||||||||||||||||||
   🧬🧬🧬🧬🧬  🧬🧬🧬🧬🧬  🧬🧬🧬🧬🧬
   [Cluster 1] [Cluster 2] [Cluster 3]
   
   Each cluster = ~1000 identical copies of one DNA fragment
```

#### Step 3: Sequencing by Synthesis

```
For each cycle:

1. Add fluorescently labeled nucleotides (A, T, G, C)
   Each nucleotide has a different color:
   A = 🔴 Red
   T = 🟢 Green  
   G = 🔵 Blue
   C = 🟡 Yellow

2. Only ONE nucleotide incorporates (has a blocking group)

3. Take a picture! 📸
   Camera detects which color was added

4. Remove the blocking group

5. Repeat for next position

Cycle 1: T added → 🟢 detected
Cycle 2: A added → 🔴 detected
Cycle 3: C added → 🟡 detected
Cycle 4: G added → 🔵 detected
...

Result: TACG... (sequence determined!)
```

### Illumina Platforms

| Platform | Read Length | Output | Run Time | Best For |
|----------|-------------|--------|----------|----------|
| **iSeq 100** | 2×150 bp | 1.2 Gb | 9-17 hrs | Small projects, teaching |
| **MiniSeq** | 2×150 bp | 7.5 Gb | 4-24 hrs | Targeted sequencing |
| **MiSeq** | 2×300 bp | 15 Gb | 4-55 hrs | Amplicons, small genomes |
| **NextSeq 550** | 2×150 bp | 120 Gb | 12-30 hrs | Exomes, RNA-seq |
| **NextSeq 2000** | 2×150 bp | 360 Gb | 11-48 hrs | Mid-scale projects |
| **NovaSeq 6000** | 2×150 bp | 6000 Gb | 13-44 hrs | Large-scale projects |
| **NovaSeq X** | 2×150 bp | 16,000 Gb | 13-48 hrs | Population genomics |

### Error Profile

**Most common error**: Substitution errors (wrong base called)

```
True sequence:  ATCGATCGATCG
Illumina read:  ATCGATTGATCG
                      ↑
                  Substitution error (C→T)
```

**Error rate**: ~0.1% (1 error per 1000 bases)

**Common issues**:
- Quality decreases toward end of reads
- GC bias (regions with very high/low GC content may be underrepresented)
- Homopolymer issues (AAAAAAA sequences can be problematic)

### Output Files

Illumina produces **FASTQ** files:

```
@SEQ_ID_1
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
+
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
```

- Line 1: Sequence identifier (starts with @)
- Line 2: DNA sequence
- Line 3: Separator (+)
- Line 4: Quality scores (ASCII encoded)

---

## Oxford Nanopore Sequencing (Long-Read)

### 📺 Watch These Videos First!

🎬 **[Nanopore DNA Sequencing](https://www.youtube.com/watch?v=RcP85JHLmnI)**

🎬 **[How Nanopore Sequencing Works](https://www.youtube.com/watch?v=FYEWrUVJ2as)**

---

### Overview

**Oxford Nanopore Technologies (ONT)** revolutionized sequencing with:
- ✅ Very long reads (up to 2+ million bp!)
- ✅ Real-time sequencing
- ✅ Portable devices (MinION fits in your pocket!)
- ✅ Direct RNA sequencing (no cDNA conversion)
- ✅ Can detect DNA modifications (methylation)
- ❌ Higher error rate than Illumina (~5-15%)
- ❌ Higher cost per base

### How It Works: Nanopore Sequencing

#### The Basic Principle

```
                    ⚡ Electric Current
                         ↓
    ════════════════════════════════════
    ║                                  ║ ← Membrane
    ║    ╔══════╗                      ║
    ║    ║      ║ ← Nanopore (protein) ║
    ║    ║  🧬  ║ ← DNA passing through║
    ║    ║      ║                      ║
    ║    ╚══════╝                      ║
    ════════════════════════════════════
    
As DNA passes through the pore:
- Each nucleotide causes a unique change in current
- A = specific current level
- T = different current level
- G = different current level  
- C = different current level
```

#### Step-by-Step Process

```
1. LIBRARY PREPARATION
   
   Add adapters and motor protein
   
   [Motor Protein]🔧
         ↓
   ═══════════════════════
   [Adapter]--[DNA]--[Adapter]


2. LOADING ONTO FLOW CELL
   
   DNA-adapter complex finds a nanopore
   
        🔧 Motor protein controls speed
         ↓
   ══════════════════
        ╔════╗
        ║ 🧬 ║ ← DNA enters pore
        ╚════╝
   ══════════════════
         ↓
      ⚡ Current measured


3. TRANSLOCATION
   
   Motor protein feeds DNA through pore one base at a time
   
   Time →
   ┌────────────────────────────────────┐
   │  Current                           │
   │    ▄▄    ▃▃▃   ▅▅   ▂▂▂   ▄▄      │
   │   ████  ████  ████ ████  ████     │
   │   A      T     G    C     A       │
   └────────────────────────────────────┘


4. BASE CALLING
   
   AI/Neural network converts current signal to sequence
   
   Current pattern → Neural Network → ATGCATGCATGC...
```

### Nanopore Platforms

| Platform | Pores | Output | Portability | Best For |
|----------|-------|--------|-------------|----------|
| **Flongle** | 126 | 2.8 Gb | Very portable | Small samples, QC |
| **MinION** | 512 | 50 Gb | Portable (USB) | Field work, small labs |
| **GridION** | 5 × 512 | 250 Gb | Benchtop | Medium throughput |
| **PromethION** | 48 × 3000 | 14,000 Gb | Benchtop | Large-scale projects |

### Key Features

#### 1. Ultra-Long Reads

```
Illumina:     ════════ (300 bp max)

Nanopore:     ════════════════════════════════════════════════════════════════
              ════════════════════════════════════════════════════════════════
              ════════════════════════════════════════════════════════════════
              (Can exceed 2,000,000 bp!)
```

**Why long reads matter:**
- Span repetitive regions
- Complete genome assemblies
- Structural variant detection
- Full-length transcript sequencing

#### 2. Real-Time Sequencing

```
Traditional sequencing:
Run → Wait hours/days → Get data → Analyze

Nanopore:
Run → See data appearing in real-time! → Can stop when you have enough
```

#### 3. Direct RNA Sequencing

```
Traditional RNA-seq:
RNA → Reverse Transcription → cDNA → Sequencing
                ↑
        Can introduce errors/bias

Nanopore Direct RNA:
RNA → Sequencing (directly!)
        ↑
No conversion needed!
```

### Error Profile

**Most common error**: Insertion/Deletion errors (indels)

```
True sequence:  ATCGATCGATCG
Nanopore read:  ATCGAATCGATCG
                     ↑
                 Insertion error

True sequence:  ATCGATCGATCG
Nanopore read:  ATCGTCGATCG
                    ↑
                Deletion error
```

**Error rate**: ~5-15% (improving rapidly with new chemistry and base callers)

**Challenging sequences**:
- Homopolymers (AAAAAAA) - hard to count exact length
- Low complexity regions

### Output Files

Nanopore produces:

1. **FAST5 files** (raw signal data)
```
Contains: Raw electrical current measurements
Size: Large (can be several GB per run)
```

2. **FASTQ files** (after base calling)
```
@read_id runid=xxx sampleid=xxx
ATCGATCGATCGATCGATCGATCGATCGATCG...
+
%&'()*+,-./0123456789:;<=>?@ABC...
```

3. **POD5 files** (newer format, replacing FAST5)
```
More efficient storage of raw signal data
```

---

## PacBio Sequencing (Long-Read)

### 📺 Watch This Video First!

🎬 **[PacBio SMRT Sequencing Technology](https://www.youtube.com/watch?v=_lD8JyAbwEo)**

---

### Overview

**Pacific Biosciences (PacBio)** offers:
- ✅ Long reads (10-25 kb average, up to 100+ kb)
- ✅ Very high accuracy with HiFi reads (>99.9%)
- ✅ No GC bias
- ✅ Detects DNA modifications
- ❌ Lower throughput than Illumina
- ❌ Higher cost per sample

### How It Works: SMRT Sequencing

**SMRT** = Single Molecule Real-Time sequencing

#### The ZMW (Zero-Mode Waveguide)

```
Top View of SMRT Cell:
┌─────────────────────────────────────┐
│ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ │
│ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ │
│ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ │
│ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ │
│        Millions of tiny wells        │
│     Each ○ is a ZMW (100nm wide)    │
└─────────────────────────────────────┘

Side View of ONE ZMW:
         ║     ║
         ║     ║ ← Metal cladding
         ║     ║
      ───╨─────╨───
         │     │
         │ 🔬  │ ← DNA polymerase + template
         │     │    at the bottom
         ╰─────╯
            ↑
    Light only illuminates
    the very bottom (10nm)
```

#### Step-by-Step Process

```
1. LIBRARY PREPARATION (SMRTbell)
   
   Circular DNA template with adapters:
   
       ╭──────────────────╮
       │                  │
   ════╯  DNA Insert      ╰════
       │                  │
       ╰──────────────────╯
       
   SMRTbell = DNA with hairpin adapters on both ends


2. POLYMERASE BINDING
   
   DNA polymerase attaches to the template
   
       ╭──────────────────╮
       │    🔵 ← Polymerase
   ════╯  DNA Insert      ╰════
       │                  │
       ╰──────────────────╯


3. SEQUENCING IN ZMW
   
   Each nucleotide has a different fluorescent label:
   A = 🔴  T = 🟢  G = 🔵  C = 🟡
   
   ║       ║
   ║   📸  ║ ← Camera above
   ║       ║
   ─────────
   │  💫   │ ← Flash of light when nucleotide incorporated
   │  🔵   │ ← Polymerase
   ╰───────╯
   
   As polymerase adds each base:
   1. Fluorescent nucleotide enters
   2. Flash of color detected
   3. Phosphate + dye released
   4. Next nucleotide enters


4. CIRCULAR CONSENSUS SEQUENCING (CCS) → HiFi READS
   
   The polymerase goes around the circle multiple times!
   
   Pass 1: ATCGATCGATCG... (some errors)
   Pass 2: ATCGATCGATCG... (some errors)
   Pass 3: ATCGATCGATCG... (some errors)
   Pass 4: ATCGATCGATCG... (some errors)
          ↓
   Consensus: ATCGATCGATCG (errors corrected!)
   
   Multiple passes = Higher accuracy
   This creates HiFi (High-Fidelity) reads
```

### PacBio Platforms

| Platform | ZMWs | HiFi Output | Best For |
|----------|------|-------------|----------|
| **Sequel II** | 8 million | 15-30 Gb | Medium projects |
| **Sequel IIe** | 8 million | 30 Gb | Medium-large projects |
| **Revio** | 25 million | 90 Gb | Large-scale, population studies |

### Read Types

#### 1. CLR (Continuous Long Reads)
```
- Single pass through the template
- Very long (up to 100+ kb)
- Higher error rate (~10-15%)
- Good for: Structural variants, scaffolding
```

#### 2. HiFi Reads (Circular Consensus Sequencing)
```
- Multiple passes, consensus called
- Shorter than CLR (10-25 kb average)
- Very high accuracy (>99.9%, Q30+)
- Good for: Variant calling, assembly
```

```
CLR vs HiFi:

CLR:  ═══════════════════════════════════════════════ (longer, less accurate)
      Single read, up to 100+ kb

HiFi: ════════════════════ (shorter, very accurate)
      Consensus of multiple passes, 10-25 kb
      Accuracy: >99.9%
```

### Error Profile

**CLR errors**: Insertions and deletions (similar to Nanopore)
**HiFi errors**: Very rare, mostly random

```
CLR:
True sequence:  ATCGATCGATCG
CLR read:       ATCGAATCGATTCG  (insertions/deletions)

HiFi:
True sequence:  ATCGATCGATCG
HiFi read:      ATCGATCGATCG    (almost perfect!)
```

### Output Files

PacBio produces:

1. **BAM files** (aligned or unaligned)
```
Contains: Sequence, quality, and additional metadata
Format: Binary (compressed)
```

2. **FASTQ files** (optional export)
```
Standard format, can be generated from BAM
```

---

## Single-End vs Paired-End Reads

### What Are They?

When sequencing with Illumina, you can choose:

#### Single-End (SE) Reads

```
DNA Fragment:
═══════════════════════════════════════════
[Adapter]                          [Adapter]
    ↓
Sequence from ONE end only:
    →→→→→→→→→→
    
Result: One read per fragment
Read 1: ATCGATCGATCG... (100-300 bp)
```

#### Paired-End (PE) Reads

```
DNA Fragment:
═══════════════════════════════════════════
[Adapter]                          [Adapter]
    ↓
Sequence from BOTH ends:
    →→→→→→→→→→           ←←←←←←←←←←
    Read 1 (forward)     Read 2 (reverse)
    
Result: Two reads per fragment, known distance apart
Read 1: ATCGATCGATCG... (forward)
Read 2: GCTAGCTAGCTA... (reverse complement)
```

### Visual Comparison

```
SINGLE-END:
                Fragment
         ════════════════════════
              →→→→→→→
              [Read]
              
         Output: 1 read per fragment


PAIRED-END:
                Fragment (insert size: 300-500 bp)
         ════════════════════════════════════════
              →→→→→→→              ←←←←←←←
              [Read 1]             [Read 2]
              
         Output: 2 reads per fragment
         Known orientation: →    ←
         Known distance apart: insert size
```

### Advantages of Paired-End

| Feature | Single-End | Paired-End |
|---------|------------|------------|
| **Mapping confidence** | Lower | Higher |
| **Spanning gaps** | No | Yes |
| **Detecting structural variants** | Limited | Good |
| **De novo assembly** | Harder | Easier |
| **Cost** | Lower | Higher |
| **Data volume** | Less | 2× more |

### When to Use Each

#### Use Single-End When:
- 📊 Simple RNA-seq for gene expression
- 💰 Budget is limited
- 🧬 Working with small, non-repetitive genomes
- 📈 Quantification is the main goal

#### Use Paired-End When:
- 🔬 De novo genome assembly
- 🧬 Detecting structural variants (insertions, deletions, inversions)
- 📍 Accurate mapping to repetitive regions
- 🔗 Transcript assembly (RNA-seq)
- 🦠 Metagenomics

### Insert Size

The **insert size** is the total length of the original DNA fragment:

```
Insert Size = 400 bp

════════════════════════════════════════
[Adapter]                        [Adapter]
    ├─────────────────────────────────┤
              Insert Size
    
    →→→→→→→→                ←←←←←←←←
    Read 1                  Read 2
    (150 bp)               (150 bp)
    
    ├────────┤    gap      ├────────┤
    
    Gap = Insert Size - (Read1 + Read2)
    Gap = 400 - (150 + 150) = 100 bp
```

### File Naming Convention

```
Sample_R1.fastq.gz  → Forward reads (Read 1)
Sample_R2.fastq.gz  → Reverse reads (Read 2)

or

Sample_1.fastq.gz   → Forward reads
Sample_2.fastq.gz   → Reverse reads
```

## Coverage Depth

### What is Coverage?
**Coverage (Depth)** = Average number of times each base in the genome is sequenced.

```
Coverage (X) = (Number of Reads × Read Length) / Genome Size
```
For Example:
```
- Genome Size: 3 Gb (human)
- Number of Reads: 600 million
- Read Length: 150 bp
Coverage = (600,000,000 × 150) / 3,000,000,000 = 30X
```
### Why is Coverage Important?
- Higher coverage = More confidence in variant calls
- Low coverage may miss variants or lead to false calls
- Typical coverage recommendations:
  - Whole genome sequencing: 30X
  - Exome sequencing: 100X
  - RNA-seq: Varies (10-50 million reads/sample)
  - Metagenomics: Varies widely based on complexity

> Coverage depth is crucial for accurate data interpretation! especially for short-read sequencing technologies like Illumina.


---

## Comparison of Technologies

### Quick Comparison Table

| Feature | Illumina | Nanopore | PacBio HiFi |
|---------|----------|----------|-------------|
| **Read Length** | 50-300 bp | 10 kb - 2 Mb | 10-25 kb |
| **Accuracy** | >99.9% | 85-99% | >99.9% |
| **Throughput** | Very High | Medium-High | Medium |
| **Cost per Gb** | Low | Medium | High |
| **Cost per Sample** | Low-Medium | Low-Medium | High |
| **Run Time** | Hours-Days | Minutes-Days | Hours |
| **Real-time Data** | No | Yes | No |
| **Portability** | No | Yes (MinION) | No |
| **DNA Mods** | Indirect | Yes | Yes |
| **Error Type** | Substitutions | Indels | Random |

### Visual Comparison

```
READ LENGTH:
Illumina:  ══════ (300 bp max)
Nanopore:  ══════════════════════════════════════════════════════ (Mbp possible)
PacBio:    ════════════════════════════ (25 kb average HiFi)


ACCURACY:
Illumina:  ████████████████████ 99.9%
PacBio:    ████████████████████ 99.9% (HiFi)
Nanopore:  █████████████████░░░ 85-99%


THROUGHPUT (per run):
Illumina:  ████████████████████ Up to 16 Tb (NovaSeq X)
Nanopore:  █████████████████░░░ Up to 14 Tb (PromethION)
PacBio:    ████████░░░░░░░░░░░░ Up to 90 Gb (Revio)


COST PER GIGABASE:
Illumina:  $ (cheapest)
Nanopore:  $$ 
PacBio:    $$$ (most expensive)
```

### Choosing Based on Application

| Application | Best Technology | Why? |
|-------------|-----------------|------|
| **Whole Genome Sequencing (human)** | Illumina or Illumina + Long-read | Balance of cost and coverage |
| **De novo Assembly** | PacBio HiFi or Nanopore | Long reads span repeats |
| **Structural Variants** | PacBio or Nanopore | Long reads see large changes |
| **RNA-seq (expression)** | Illumina | High accuracy, low cost |
| **Full-length Transcripts** | Nanopore or PacBio | Read entire transcripts |
| **Metagenomics** | Illumina + Nanopore | Coverage + resolution |
| **Clinical Diagnostics** | Illumina | Established, accurate |
| **Field Work** | Nanopore MinION | Portable |
| **Methylation** | Nanopore or PacBio | Direct detection |
| **Rapid Pathogen ID** | Nanopore | Real-time results |

---

## Choosing the Right Technology

### Decision Flowchart

```
                    START
                      │
                      ▼
            ┌─────────────────┐
            │ What's your     │
            │ main goal?      │
            └────────┬────────┘
                     │
        ┌────────────┼────────────┬─────────────┐
        ▼            ▼            ▼             ▼
   ┌─────────┐ ┌──────────┐ ┌──────────┐ ┌───────────┐
   │High     │ │Structural│ │De novo   │ │Real-time/ │
   │accuracy │ │variants  │ │assembly  │ │Field work │
   │counts   │ │          │ │          │ │           │
   └────┬────┘ └────┬─────┘ └────┬─────┘ └─────┬─────┘
        │           │            │             │
        ▼           ▼            ▼             ▼
   ┌─────────┐ ┌──────────┐ ┌──────────┐ ┌───────────┐
   │Illumina │ │PacBio or │ │PacBio    │ │Nanopore   │
   │         │ │Nanopore  │ │HiFi      │ │MinION     │
   └─────────┘ └──────────┘ └──────────┘ └───────────┘
```

### Hybrid Approaches

Many projects combine technologies:

```
HYBRID ASSEMBLY STRATEGY:

Illumina (short reads)     +     Nanopore/PacBio (long reads)
━━━━━━━━━━━━━━━━━━━━━━━          ━━━━━━━━━━━━━━━━━━━━━━━━━━
High accuracy                    Span repetitive regions
High coverage                    Structural information
Low cost                         Gap filling
        ↓                               ↓
        └───────────┬───────────────────┘
                    ▼
            ┌───────────────┐
            │ BEST OF BOTH! │
            │ Accurate AND  │
            │ Complete      │
            └───────────────┘
```

---

## Video Resources

### 📺 Must-Watch Videos

#### Illumina Sequencing
🎬 **[Illumina Sequencing by Synthesis (SBS)](https://www.youtube.com/watch?v=fCd6B5HRaZ8)**
- Official Illumina explanation
- Beautiful animation of the SBS process
- ~5 minutes

#### Oxford Nanopore Sequencing
🎬 **[Nanopore DNA Sequencing Explained](https://www.youtube.com/watch?v=RcP85JHLmnI)**
- How nanopore technology works
- From Oxford Nanopore Technologies

🎬 **[How Nanopore Sequencing Works](https://www.youtube.com/watch?v=FYEWrUVJ2as)**
- Detailed explanation of the process
- Great for understanding the principles

#### PacBio Sequencing
🎬 **[PacBio SMRT Sequencing](https://www.youtube.com/watch?v=_lD8JyAbwEo)**
- Single Molecule Real-Time sequencing
- ZMW technology explained

---

## Glossary

| Term | Definition |
|------|------------|
| **Base calling** | Converting raw signals to DNA sequence (A, T, G, C) |
| **Coverage/Depth** | How many times each base is sequenced (e.g., 30× coverage) |
| **Flow cell** | The chip/surface where sequencing reactions occur |
| **FASTQ** | Standard file format for sequence + quality data |
| **HiFi reads** | PacBio high-fidelity reads from circular consensus |
| **Homopolymer** | Stretch of identical bases (e.g., AAAAAAA) |
| **Insert size** | Length of DNA fragment between adapters |
| **Library** | Collection of DNA fragments prepared for sequencing |
| **Multiplexing** | Sequencing multiple samples together using barcodes |
| **Paired-end** | Sequencing both ends of a DNA fragment |
| **Read** | A single sequence determined from one DNA fragment |
| **Read length** | Number of bases sequenced in one read |
| **SMRT** | Single Molecule Real-Time (PacBio technology) |
| **SNP** | Single Nucleotide Polymorphism (single base change) |
| **Structural variant** | Large DNA changes (insertions, deletions, inversions) |
| **Throughput** | Total amount of sequence data produced |
| **ZMW** | Zero-Mode Waveguide (tiny wells in PacBio SMRT cells) |

---
## Desi tarkay wali understanding about sequencing!

### 🇵🇰 Pakistani Style Analogies for Sequencing Technologies

#### Illumina Sequencing = Paratha Rolls at a Dhaba 🥙

Think of Illumina like a busy Lahori dhaba making paratha rolls:
- **Short reads** = Small bite-sized pieces (like cutting a paratha roll into small pieces)
- **High accuracy** = Every piece tastes exactly the same (consistent quality)
- **High throughput** = Making thousands of rolls per hour during rush hour
- **Low cost per piece** = Affordable for everyone, just like Rs. 100 paratha roll

```
Illumina = Dhaba Production Line
════════════════════════════════════════
🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙🥙
Fast, consistent, affordable, but small pieces!
```

#### Nanopore Sequencing = Gol Gappay Wala 🍽️

Imagine Nanopore as the street vendor making gol gappay:
- **Long reads** = Like the continuous stream of pani going through the puri
- **Portable** = The vendor moves around with his cart (MinION fits in pocket!)
- **Real-time** = You eat and enjoy as soon as it's made
- **Some errors** = Sometimes the puri breaks, but you still enjoy it!

```
           Pani (DNA) flowing through Puri (Nanopore)
               💧💧💧
                 ↓
              ╔═══╗
              ║ ○ ║ ← Puri (Nanopore)
              ╚═══╝
                ↓
              💧💧💧
         Reading sequence in real-time!
```

#### PacBio HiFi = Biryani Making 🍚

PacBio is like making the perfect Karachi biryani:
- **Multiple passes (dum)** = Just like giving multiple "dum" to biryani for perfect taste
- **High accuracy** = Every bite is perfectly flavored
- **Takes time** = Good biryani needs patience, just like HiFi reads
- **Expensive** = Premium quality, premium price (like Kolachi biryani!)

```
Round 1 (First dum):  🍚 Some flavors absorbed
Round 2 (Second dum): 🍚 More flavor absorbed  
Round 3 (Third dum):  🍚 Even more flavor
Round 4 (Fourth dum): 🍚 Perfect biryani!
         ↓
Result: PERFECT HiFi READS (like perfect biryani layers!)
```

#### Single-End vs Paired-End = Chappal vs Joota 👟

**Single-End** = Like wearing one chappal (you can walk but not ideal):
```
🩴 → Just one read, simpler, cheaper
Good for: Quick trips to corner shop
```

**Paired-End** = Like wearing proper jootay (complete pair):
```
👟👟 → Both reads, complete information
Good for: Long walks, running, proper coverage!
```

#### Coverage Depth = Chai Ki Patti 🍵

Think of coverage like making chai:
- **30X coverage** = Using proper amount of patti (perfect strength)
- **Low coverage** = Too little patti (pheeki chai, can't taste mutations!)
- **High coverage** = Extra patti (mazboot chai, can detect everything!)

```
5X coverage:   🫖 Pheeki chai - might miss important variants
30X coverage:  🫖 Perfect chai - standard for whole genome
100X coverage: 🫖 Kadak chai - for clinical diagnostics
```

### Technology Selection = Choosing the Right Khana for the Occasion

| Occasion (Research Goal) | Best Food (Technology) | Why? |
|--------------------------|------------------------|------|
| **Daily meal (Expression analysis)** | Daal Chawal (Illumina) | Reliable, affordable, routine |
| **Wedding feast (Genome assembly)** | Biryani (PacBio HiFi) | Premium quality needed |
| **Street food adventure (Field work)** | Gol Gappay (Nanopore) | Portable, quick, on-the-go |
| **Complete dawat (Hybrid assembly)** | Full menu! | Daal + Biryani + Chaat = Best results |

### 🎯 Desi Summary

```
╔══════════════════════════════════════════════════════════════╗
║  "Jis tarah alag alag khana alag occasion ke liye hai,      ║
║   usi tarah alag sequencing technology alag kaam ke liye!"  ║
║                                                              ║
║  🥙 Illumina = Fast food, reliable, affordable              ║
║  🍽️ Nanopore = Street food, portable, real-time             ║
║  🍚 PacBio = Fine dining, premium quality                   ║
╚══════════════════════════════════════════════════════════════╝
```

---

## Practice Questions

### Multiple Choice

1. **Which sequencing technology produces the longest reads?**
   - A) Illumina
   - B) Sanger
   - C) Oxford Nanopore
   - D) Ion Torrent

2. **What is the main error type in Illumina sequencing?**
   - A) Insertions
   - B) Deletions
   - C) Substitutions
   - D) Inversions

3. **What does "paired-end" sequencing mean?**
   - A) Sequencing two different samples
   - B) Sequencing both ends of a DNA fragment
   - C) Using two different technologies
   - D) Reading the sequence twice

4. **Which technology allows real-time sequencing?**
   - A) Illumina
   - B) PacBio
   - C) Oxford Nanopore
   - D) Sanger

5. **What creates HiFi reads in PacBio sequencing?**
   - A) Longer DNA fragments
   - B) Multiple passes around circular template
   - C) Better cameras
   - D) Special enzymes

### Short Answer

1. Explain why long-read sequencing is important for genome assembly.

2. Compare the error profiles of Illumina and Nanopore sequencing.

3. When would you choose single-end over paired-end sequencing?

4. What is the advantage of hybrid assembly (combining short and long reads)?

5. Explain how Nanopore sequencing detects DNA bases.

### Answers

<details>
<summary>Click to see answers</summary>

**Multiple Choice:**
1. C) Oxford Nanopore
2. C) Substitutions
3. B) Sequencing both ends of a DNA fragment
4. C) Oxford Nanopore
5. B) Multiple passes around circular template

**Short Answer:**
1. Long reads can span repetitive regions that short reads cannot resolve, leading to more complete and contiguous assemblies.

2. Illumina: Mostly substitution errors (~0.1%). Nanopore: Mostly insertion/deletion errors, especially in homopolymers (~5-15%).

3. When doing simple expression quantification, when budget is limited, or when working with small non-repetitive genomes.

4. Short reads provide high accuracy, long reads provide structural information. Together they create accurate AND complete assemblies.

5. DNA passes through a protein pore. Each base causes a characteristic change in electrical current. A neural network interprets these current changes to determine the sequence.

</details>

---

## Summary

### Key Takeaways

1. **Illumina** = Short reads, very accurate, high throughput, low cost
   - Best for: RNA-seq, variant calling, clinical diagnostics

2. **Nanopore** = Ultra-long reads, portable, real-time
   - Best for: Field work, structural variants, full-length transcripts

3. **PacBio HiFi** = Long reads with high accuracy
   - Best for: De novo assembly, structural variants, difficult genomes

4. **Single-end** = One read per fragment, simpler, cheaper
   - Best for: Expression quantification

5. **Paired-end** = Two reads per fragment, more informative
   - Best for: Assembly, structural variants, mapping to repeats

---

**Happy Sequencing! 🧬💻**

*Remember: The best technology depends on your specific research question!*

---

*Last Updated: 08.12.2025*\
*Course: Bioinformatics Ka Chilla 2025-2026*\
*Instructor: M Aammar Tufail*\
Website: [www.codanics.com/bioinformatics-ka-chilla](www.codanics.com/bioinformatics-ka-chilla)
