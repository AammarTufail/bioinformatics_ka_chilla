
# Installing Software in Linux

---

## 📦 1. Installing Software with `apt-get`

APT (Advanced Package Tool) is the package manager for Debian-based systems like Linux Mint and Ubuntu.

### Basic Commands

```bash
# Update package list
sudo apt-get update

# Upgrade all packages
sudo apt-get upgrade

# Install a package
sudo apt-get install package_name

# Remove a package
sudo apt-get remove package_name

# Remove package and configuration files
sudo apt-get purge package_name

# Search for a package
apt-cache search keyword

# Show package information
apt-cache show package_name

# Clean up old packages
sudo apt-get autoremove
sudo apt-get autoclean
```

### 🧬 Bioinformatics Package Installation

#### Essential Development Tools

```bash
# Update package list first
sudo apt-get update

# Install build essentials
sudo apt-get install build-essential

# Install Python and package manager
sudo apt-get install python3-pip

# Install version control and downloaders
sudo apt-get install git wget curl
```

#### Common Bioinformatics Tools

```bash
# Sequence analysis tools
sudo apt-get install samtools
sudo apt-get install bcftools
sudo apt-get install bedtools
sudo apt-get install vcftools

# Quality control
sudo apt-get install fastqc

# Text editors
sudo apt-get install vim nano
```

#### Required Dependencies

```bash
# Compression libraries
sudo apt-get install zlib1g-dev
sudo apt-get install libbz2-dev
sudo apt-get install liblzma-dev

# R programming environment
sudo apt-get install r-base r-base-dev
```

### 💡 Practical Examples

**Updating the System:**

```bash
codanics@PC-codanics:~$ sudo apt-get update
[sudo] password for codanics: ****
Hit:1 http://packages.linuxmint.com vanessa InRelease
Get:2 http://archive.ubuntu.com/ubuntu jammy InRelease [270 kB]
Fetched 270 kB in 2s (135 kB/s)
Reading package lists... Done
```

**Installing a Single Package:**

```bash
codanics@PC-codanics:~$ sudo apt-get install samtools
Reading package lists... Done
Building dependency tree... Done
The following NEW packages will be installed:
    samtools
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Do you want to continue? [Y/n] y
Setting up samtools (1.13-4) ...
```

**Verifying Installation:**

```bash
codanics@PC-codanics:~$ samtools --version
samtools 1.13
```

**Searching for Packages:**

```bash
codanics@PC-codanics:~$ apt-cache search fastqc
fastqc - quality control for high throughput sequence data
```

**Installing Multiple Packages:**

```bash
codanics@PC-codanics:~$ sudo apt-get install bedtools bcftools vcftools
```

---

## 🔧 2. Installing Software from Shell Scripts

Many bioinformatics tools are distributed as shell scripts (`.sh` files) or compressed archives that require manual installation.

### Basic Installation Process

```bash
# Step 1: Download the installer
wget https://example.com/installer.sh

# Step 2: Make it executable
chmod +x installer.sh

# Step 3: Run the installer
./installer.sh
```

### Common Execution Methods

```bash
# Method 1: Direct execution (most common)
chmod +x install.sh
./install.sh

# Method 2: Using bash
bash install.sh

# Method 3: Using sh
sh install.sh

# Method 4: With sudo (if system-wide installation)
sudo bash install.sh

# Method 5: Source the script (for environment setup)
source install.sh
```

### Installation Options

```bash
# Install to specific directory
./installer.sh -d /home/codanics/biotools

# Silent/non-interactive installation
./installer.sh -y

# View available options
./installer.sh --help
```

---

## 🧬 Bioinformatics Installation Examples

### Example 1: Installing Miniconda

Miniconda is a minimal conda installer, essential for managing bioinformatics environments.

```bash
# Download the installer
codanics@PC-codanics:~$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Make it executable
codanics@PC-codanics:~$ chmod +x Miniconda3-latest-Linux-x86_64.sh

# Run the installer
codanics@PC-codanics:~$ bash Miniconda3-latest-Linux-x86_64.sh
```

**Installation Prompts:**

```
Welcome to Miniconda3 py311_23.11.0-2

In order to continue the installation process, please review the license
agreement.
Please, press ENTER to continue
>>>
```

**Follow these steps:**
- Press **ENTER** to view the license
- Type **yes** to accept
- Confirm installation location (default: `/home/codanics/miniconda3`)
- Type **yes** to initialize Miniconda3

**Activate the installation:**

```bash
# Restart terminal or run:
codanics@PC-codanics:~$ source ~/.bashrc

# Verify installation
codanics@PC-codanics:~$ conda --version
conda 23.11.0
```

---

### Example 2: Installing SPAdes Genome Assembler

SPAdes is a widely-used genome assembly toolkit.

```bash
# Download SPAdes
codanics@PC-codanics:~/tools$ wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz

# Extract the archive
codanics@PC-codanics:~/tools$ tar -xzf SPAdes-3.15.5-Linux.tar.gz

# Navigate to binary directory
codanics@PC-codanics:~/tools$ cd SPAdes-3.15.5-Linux/bin/

# Test the installation
codanics@PC-codanics:~/tools/SPAdes-3.15.5-Linux/bin$ ./spades.py --version
SPAdes v3.15.5
```

**Add to PATH for system-wide access:**

```bash
# Add to ~/.bashrc
codanics@PC-codanics:~$ echo 'export PATH="/home/codanics/tools/SPAdes-3.15.5-Linux/bin:$PATH"' >> ~/.bashrc

# Reload configuration
codanics@PC-codanics:~$ source ~/.bashrc

# Verify system-wide access
codanics@PC-codanics:~$ spades.py --version
SPAdes v3.15.5
```

---

### Example 3: Installing BLAST+

BLAST+ is the essential tool for sequence similarity searches.

```bash
# Download BLAST+ archive
codanics@PC-codanics:~/tools$ wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.14.0+-x64-linux.tar.gz

# Extract the archive
codanics@PC-codanics:~/tools$ tar -xzf ncbi-blast-2.14.0+-x64-linux.tar.gz

# Add to PATH
codanics@PC-codanics:~/tools$ echo 'export PATH="/home/codanics/tools/ncbi-blast-2.14.0+/bin:$PATH"' >> ~/.bashrc

# Reload configuration
codanics@PC-codanics:~/tools$ source ~/.bashrc

# Verify installation
codanics@PC-codanics:~$ blastn -version
blastn: 2.14.0+
 Package: blast 2.14.0, build Jan 12 2023 12:34:56
```

---

## 📝 Best Practices for Script Installation

### ✅ Pre-Installation Checklist

1. **Read documentation first** - Check README and INSTALL files
2. **Verify system requirements** - Ensure compatibility
3. **Review the script** - Understand what it does (if possible)
4. **Use user directories** - Avoid `sudo` when possible
5. **Backup important data** - Before major installations

### 📋 Documentation Template

Keep track of your installations with a log file:

```bash
codanics@PC-codanics:~/tools$ cat > installation_log.txt << EOF
Date: $(date)
Tool: SPAdes v3.15.5
URL: http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz
Installation Path: /home/codanics/tools/SPAdes-3.15.5-Linux
PATH Addition: Added to ~/.bashrc
Notes: Successfully installed and tested
EOF
```

### 🔍 Troubleshooting Tips

- **Permission denied?** → Use `chmod +x` to make the script executable
- **Command not found?** → Check if the tool's directory is in your PATH
- **Missing dependencies?** → Install required libraries with `apt-get`
- **Installation fails?** → Check the log files in the installation directory

---

**🎯 Key Takeaway:** Master both `apt-get` for system packages and manual script installations for specialized bioinformatics tools. Always document your installations for reproducibility!
