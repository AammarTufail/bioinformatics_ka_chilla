# Conda/Miniconda/Mamba for Package Management

> Modern package management systems specifically designed for bioinformatics and data science workflows.

---

## 📦 What are they?

| Tool | Description | Size |
|------|-------------|------|
| **Anaconda** | Full distribution with 1,500+ pre-installed packages | ~3GB |
| **Miniconda** | Minimal installer with just conda and Python | ~400MB |
| **Mamba** | Drop-in replacement for conda with faster dependency resolution | Lightweight |
| **Conda** | Cross-platform package and environment manager | Core tool |

---

## 🚀 Installation

### Installing Miniconda

```bash
# Download Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Run installer
bash Miniconda3-latest-Linux-x86_64.sh

# Reload shell configuration
source ~/.bashrc

# Verify installation
conda --version
```

### Installing Mamba (Recommended for Speed)

```bash
# Install mamba in base environment
conda install -n base -c conda-forge mamba

# Use mamba for faster package installations
```

---

## 🔧 Basic Commands

### Package Management

```bash
# Update conda
conda update conda

# Search for packages
conda search package_name

# Install package
conda install package_name

# Install from specific channel
conda install -c bioconda samtools

# Install specific version
conda install samtools=1.15

# Update package
conda update package_name

# Remove package
conda remove package_name

# List installed packages
conda list

# Clean up unused files
conda clean --all
```

---

## 🌍 Working with Environments

### Creating Environments

```bash
# Create empty environment
conda create -n myenv

# Create with specific Python version
conda create -n myenv python=3.9

# Create with multiple packages
conda create -n bioenv python=3.9 biopython pandas numpy
```

### Managing Environments

```bash
# Activate environment
conda activate bioenv

# Deactivate environment
conda deactivate

# List all environments
conda env list

# Remove environment
conda env remove -n myenv

# Clone environment
conda create --name newenv --clone oldenv
```

### Environment Files

```bash
# Export current environment
conda env export > environment.yml

# Create environment from file
conda env create -f environment.yml
```

---

## 🧬 Bioinformatics Setup

### Configure Bioconda Channels

```bash
# Add essential channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Set strict channel priority
conda config --set channel_priority strict
```

---

## 💡 Practical Examples

### Example 1: RNA-seq Analysis Environment

```bash
# Create environment
codanics@PC-codanics:~$ conda create -n rnaseq python=3.9
codanics@PC-codanics:~$ conda activate rnaseq

# Install RNA-seq tools
(rnaseq) codanics@PC-codanics:~$ mamba install -c bioconda \
    fastqc \
    trim-galore \
    star \
    samtools \
    htseq \
    deseq2

# Verify installations
(rnaseq) codanics@PC-codanics:~$ fastqc --version
FastQC v0.11.9

(rnaseq) codanics@PC-codanics:~$ samtools --version
samtools 1.16

# Export for reproducibility
(rnaseq) codanics@PC-codanics:~$ conda env export > rnaseq_environment.yml
```

### Example 2: Genome Assembly Environment

```bash
# Create and activate environment
codanics@PC-codanics:~$ mamba create -n assembly python=3.9
codanics@PC-codanics:~$ conda activate assembly

# Install assembly tools
(assembly) codanics@PC-codanics:~$ mamba install -c bioconda \
    spades \
    quast \
    busco \
    bandage

# Verify installations
(assembly) codanics@PC-codanics:~$ spades.py --version
SPAdes v3.15.5

(assembly) codanics@PC-codanics:~$ quast --version
QUAST v5.2.0
```

### Example 3: Variant Calling Pipeline

```bash
# Setup environment
codanics@PC-codanics:~$ mamba create -n variants python=3.9
codanics@PC-codanics:~$ conda activate variants

# Install variant calling tools
(variants) codanics@PC-codanics:~$ mamba install -c bioconda \
    bwa \
    samtools \
    bcftools \
    gatk4 \
    picard \
    vcftools

# Verify tools
(variants) codanics@PC-codanics:~$ bwa
[bwa] Version: 0.7.17-r1188

(variants) codanics@PC-codanics:~$ bcftools --version
bcftools 1.16
```

### Example 4: Using Environment Files

```bash
# Create environment.yml
codanics@PC-codanics:~/project$ cat > environment.yml << EOF
name: bioinfo_analysis
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - python=3.9
  - biopython
  - pandas
  - numpy
  - matplotlib
  - seaborn
  - jupyter
  - samtools
  - bcftools
  - bedtools
EOF

# Create environment from file
codanics@PC-codanics:~/project$ conda env create -f environment.yml

# Activate
codanics@PC-codanics:~/project$ conda activate bioinfo_analysis

# Share with colleagues
codanics@PC-codanics:~/project$ conda env export > complete_environment.yml
```

### Example 5: Version Pinning for Reproducibility

```bash
# Install specific versions
codanics@PC-codanics:~$ conda activate myenv

(myenv) codanics@PC-codanics:~$ mamba install \
    python=3.9.7 \
    samtools=1.15 \
    bcftools=1.15 \
    bwa=0.7.17

# List installed versions
(myenv) codanics@PC-codanics:~$ conda list
# packages in environment at /home/codanics/miniconda3/envs/myenv:
#
# Name                    Version                   Build  Channel
bcftools                  1.15               h0c0f85b_0    bioconda
bwa                       0.7.17               h5bf99c6_8    bioconda
python                    3.9.7           h12debd9_1    
samtools                  1.15               h3843a85_0    bioconda
```

---

## 🔄 Managing Multiple Projects

```bash
# Project 1: RNA-seq analysis
codanics@PC-codanics:~/project1$ conda activate rnaseq
(rnaseq) codanics@PC-codanics:~/project1$ # RNA-seq work here
(rnaseq) codanics@PC-codanics:~/project1$ conda deactivate

# Project 2: Genome assembly
codanics@PC-codanics:~/project2$ conda activate assembly
(assembly) codanics@PC-codanics:~/project2$ # Assembly work here
(assembly) codanics@PC-codanics:~/project2$ conda deactivate

# Project 3: Variant calling
codanics@PC-codanics:~/project3$ conda activate variants
(variants) codanics@PC-codanics:~/project3$ # Variant calling work here
```

---

## ⚡ Performance: Conda vs Mamba

```bash
# Conda (slower)
codanics@PC-codanics:~$ time conda install -c bioconda blast
# ⏱️ Takes: 5-10 minutes

# Mamba (faster) ⭐
codanics@PC-codanics:~$ time mamba install -c bioconda blast
# ⏱️ Takes: 30 seconds to 2 minutes
```

**Recommendation:** Use `mamba` for significantly faster dependency resolution and installations!

---

## ✅ Best Practices

1. **⚡ Use mamba** instead of conda for faster installations
2. **🔒 Create separate environments** for different projects
3. **📄 Export environment files** for reproducibility
4. **📌 Pin versions** for critical analyses
5. **🧬 Use bioconda channel** for bioinformatics tools
6. **🔄 Regularly update** conda: `conda update conda`
7. **🧹 Clean up regularly**: `conda clean --all`
8. **📝 Document environments** in project README files

---

## 🔧 Troubleshooting

### Conda is Slow
```bash
# Solution: Install and use mamba
conda install -n base -c conda-forge mamba
```

### Conflicting Dependencies
```bash
# Solution: Create fresh environment
conda create -n newenv python=3.9
conda activate newenv
mamba install package_name
```

### Environment Not Activating
```bash
# Solution: Initialize conda for your shell
conda init bash
source ~/.bashrc
```

### Out of Disk Space
```bash
# Solution: Clean up cached files
conda clean --all
```

### Can't Find Package
```bash
# Solution: Add required channels
conda config --add channels conda-forge
conda config --add channels bioconda
```

---

## 📚 Quick Reference

| Command | Description |
|---------|-------------|
| `conda create -n NAME` | Create new environment |
| `conda activate NAME` | Activate environment |
| `conda deactivate` | Deactivate current environment |
| `mamba install PACKAGE` | Install package (fast) |
| `conda list` | List installed packages |
| `conda env list` | List all environments |
| `conda env export > file.yml` | Export environment |
| `conda clean --all` | Clean up cache |

---