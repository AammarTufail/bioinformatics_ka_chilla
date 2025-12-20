# 📝 Visual Studio Code (VSCode) for Bioinformatics

**Author:** Dr. Aammar Tufail  
**Course:** [Bioinformatics Ka Chilla](https://codanics.com/bioinformatics-ka-chilla/) by [Codanics.com](https://codanics.com/)  
**Date:** December 2025

---

## 📑 Table of Contents

1. [Introduction](#introduction)
2. [Why VSCode for Bioinformatics?](#why-vscode-for-bioinformatics)
3. [Installing VSCode](#installing-vscode)
4. [Syncing VSCode with GitHub Account](#syncing-vscode-with-github-account)
5. [Using VSCode with GitHub Repositories](#using-vscode-with-github-repositories)
6. [Essential VSCode Extensions for Bioinformatics](#essential-vscode-extensions-for-bioinformatics)
7. [Practical Tips for Bioinformaticians](#practical-tips-for-bioinformaticians)
8. [Conclusion](#conclusion)

---

## Introduction

Welcome to this comprehensive guide on using **Visual Studio Code (VSCode)** for bioinformatics! As part of the **Bioinformatics Ka Chilla** course at [codanics.com](https://codanics.com/bioinformatics-ka-chilla/), we'll learn how to leverage this powerful code editor to enhance your bioinformatics workflow.

VSCode is a **free, open-source, and lightweight** code editor developed by Microsoft. It has become the go-to choice for programmers, data scientists, and bioinformaticians worldwide due to its versatility and extensive extension ecosystem.

---

## Why VSCode for Bioinformatics?

### 🔬 Key Benefits for Bioinformatics Workflows

| Feature | Benefit for Bioinformatics |
|---------|---------------------------|
| **Multi-language Support** | Work with Python, R, Bash, Perl, and other bioinformatics languages in one place |
| **Integrated Terminal** | Run command-line bioinformatics tools directly within the editor |
| **Git Integration** | Track changes in your analysis pipelines and collaborate with others |
| **Jupyter Notebooks** | Analyze genomic data interactively with notebooks |
| **Remote Development** | Connect to HPC clusters and remote servers seamlessly |
| **Extensions Ecosystem** | Access specialized tools for data science and bioinformatics |
| **Cross-platform** | Works on Windows, macOS, and Linux |

### 🎯 Why Bioinformaticians Should Use VSCode

1. **All-in-One Environment**: Instead of switching between multiple applications, you can write code, run analyses, manage files, and use version control—all in one place.

2. **Reproducible Research**: With Git integration, you can track every change in your analysis, making your research reproducible and transparent.

3. **Remote Computing**: Connect to university servers, cloud instances, or High Performance Computing (HPC) clusters directly from VSCode to run computationally intensive analyses.

4. **Interactive Data Analysis**: Use Jupyter notebooks within VSCode for exploratory data analysis of genomic datasets.

5. **Collaboration**: Easily share code and collaborate with lab members through GitHub integration.

6. **Documentation**: Write documentation in Markdown alongside your code, keeping everything organized.

---

## Installing VSCode

### Step 1: Download VSCode

Visit the official VSCode website: [https://code.visualstudio.com/](https://code.visualstudio.com/)

### Step 2: Install on Your Operating System

#### 🐧 Linux (Ubuntu/Debian)

```bash
# Method 1: Using snap
sudo snap install --classic code

# Method 2: Using apt
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

# or directly run
sudo apt-get install code
```

#### 🍎 macOS

```bash
# Method 1: Download from website and drag to Applications folder

# Method 2: Using Homebrew
brew install --cask visual-studio-code
```

#### 🪟 Windows

1. Download the installer from [code.visualstudio.com](https://code.visualstudio.com/)
2. Run the `.exe` installer
3. Follow the installation wizard
4. ✅ Check "Add to PATH" during installation

### Step 3: Verify Installation

Open a terminal and run:

```bash
code --version
```

You should see the version number if installed correctly.

---

## Syncing VSCode with GitHub Account

Syncing VSCode with your GitHub account allows you to:
- 🔄 Sync your settings across multiple devices
- 📦 Backup your extensions and configurations
- 🔐 Authenticate for GitHub operations without repeated logins

### Step 1: Create a GitHub Account (if you don't have one)

1. Go to [https://github.com](https://github.com)
2. Click **Sign up**
3. Enter your email, create a password, and choose a username
4. Verify your email address

### Step 2: Enable Settings Sync in VSCode

1. Open VSCode
2. Click on the **Accounts** icon (person icon) at the bottom of the left sidebar
3. Click **"Turn on Settings Sync..."**

![Settings Sync Location](https://code.visualstudio.com/assets/docs/editor/settings-sync/turn-on-sync.png)

4. Select what you want to sync:
   - ✅ Settings
   - ✅ Keyboard Shortcuts
   - ✅ Extensions
   - ✅ User Snippets
   - ✅ UI State

5. Click **"Sign in & Turn on"**

### Step 3: Sign in with GitHub

1. Select **"Sign in with GitHub"**
2. A browser window will open
3. Authorize VSCode to access your GitHub account
4. You'll be redirected back to VSCode

### Step 4: Verify Sync is Active

- Look for the **cloud icon** at the bottom of VSCode
- A green checkmark indicates sync is active
- Your settings will now sync across all devices where you use this GitHub account

### 🔧 Managing Sync Settings

To customize what syncs:

1. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. Type **"Settings Sync: Configure"**
3. Select or deselect items to sync

---

## Using VSCode with GitHub Repositories

### Part A: Initial Setup - Git Configuration

#### Step 1: Install Git

**Linux:**
```bash
sudo apt install git
```

**macOS:**
```bash
brew install git
# Or install Xcode Command Line Tools
xcode-select --install
```

**Windows:**
Download from [https://git-scm.com/download/win](https://git-scm.com/download/win)

#### Step 2: Configure Git Identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

#### Step 3: Verify Git in VSCode

1. Open VSCode
2. Press `Ctrl+Shift+G` (Windows/Linux) or `Cmd+Shift+G` (macOS) to open Source Control
3. If Git is installed correctly, you'll see the Source Control panel

---

### Part B: Cloning a Repository

#### Method 1: Using VSCode Command Palette

1. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. Type **"Git: Clone"**
3. Enter the repository URL (e.g., `https://github.com/username/repo.git`)
4. Select a local folder to clone into
5. Open the cloned repository when prompted

#### Method 2: Using the Terminal

```bash
# Navigate to your projects folder
cd ~/Documents/Projects

# Clone the repository
git clone https://github.com/username/repository-name.git

# Open in VSCode
code repository-name
```

#### Method 3: Using the Welcome Page

1. Open VSCode
2. On the Welcome page, click **"Clone Git Repository..."**
3. Enter the repository URL
4. Select destination folder

---

### Part C: Creating a New Repository

#### Step 1: Create a New Folder for Your Project

```bash
mkdir my-bioinformatics-project
cd my-bioinformatics-project
code .
```

#### Step 2: Initialize Git Repository

**Option A: Using VSCode**
1. Open Source Control (`Ctrl+Shift+G`)
2. Click **"Initialize Repository"**

**Option B: Using Terminal**
```bash
git init
```

#### Step 3: Create Initial Files

Create a `README.md` file:

> Learn complete markdown from here:
>
> [![Markdown Tutorial](https://img.youtube.com/vi/qJqAXjz-Rh4/0.jpg)](https://youtu.be/qJqAXjz-Rh4)\
Here is the [link.] or click on the image above. (https://youtu.be/qJqAXjz-Rh4)

```markdown
# My Bioinformatics Project

## Description
A brief description of your project.

## Author
Your Name
```

Create a `.gitignore` file for bioinformatics:

> **What is `.gitignore`?**
> The `.gitignore` file tells Git which files and folders to ignore when tracking changes. This is essential in bioinformatics because:
> - **Large data files** (FASTQ, BAM, VCF) are too big for GitHub's 100MB file limit
> - **Temporary files** clutter your repository unnecessarily
> - **Environment-specific files** shouldn't be shared across systems


```gitignore
# Data files (usually too large for GitHub)
*.fastq
*.fastq.gz
*.fasta
*.fa
*.bam
*.sam
*.vcf

# Python
__pycache__/
*.py[cod]
.ipynb_checkpoints/
venv/
.env

# R
.Rhistory
.RData
.Rproj.user/

# OS files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
```

#### Step 4: Stage and Commit Changes

1. In Source Control panel, click **"+"** next to files to stage them
2. Enter a commit message (e.g., "Initial commit: project setup")
3. Click the **checkmark** ✓ to commit

#### Step 5: Push to GitHub

**Option A: Create Repository on GitHub First**

1. Go to [github.com](https://github.com) → Click **"+"** → **"New repository"**
2. Name your repository
3. **Don't** initialize with README (you already have one)
4. Copy the repository URL

**Option B: Connect Local to Remote**

```bash
# Add remote origin
git remote add origin https://github.com/your-username/your-repo.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Option C: Using VSCode**

1. Click **"Publish Branch"** in the Source Control panel
2. Choose **"Publish to GitHub public repository"** or **"private"**
3. Authorize VSCode to access GitHub if prompted
4. Select which files to include

---

### Part D: Daily Git Workflow in VSCode

#### 1. Pull Latest Changes

Before starting work:
- Click the **sync icon** 🔄 in the bottom status bar, or
- Press `Ctrl+Shift+P` → **"Git: Pull"**

#### 2. Make Changes

Edit your files as needed.

#### 3. Stage Changes

- Click **"+"** next to individual files, or
- Click **"+"** next to "Changes" to stage all

#### 4. Commit Changes

1. Write a meaningful commit message
2. Press `Ctrl+Enter` or click the **checkmark** ✓

#### 5. Push Changes

Click the **sync icon** 🔄 or:
- Press `Ctrl+Shift+P` → **"Git: Push"**

### 📝 Git Commit Message Best Practices

```
feat: add sequence alignment script
fix: correct BLAST output parsing error  
docs: update README with installation instructions
refactor: optimize FASTA file reading function
data: add sample genome sequences
```

---

## Essential VSCode Extensions for Bioinformatics

### 🐍 Python Development

#### 1. Python (by Microsoft)
**Extension ID:** `ms-python.python`

Essential for Python-based bioinformatics work.

**Features:**
- IntelliSense (code completion)
- Linting (error detection)
- Debugging
- Code formatting
- Jupyter notebook support

**Installation:**
1. Press `Ctrl+Shift+X` to open Extensions
2. Search for "Python"
3. Click **Install** on "Python" by Microsoft

#### 2. Pylance
**Extension ID:** `ms-python.vscode-pylance`

Advanced Python language server for better code intelligence.

#### 3. Jupyter
**Extension ID:** `ms-toolsai.jupyter`

Run Jupyter notebooks directly in VSCode.

**Features:**
- Create and edit `.ipynb` files
- Run cells interactively
- View outputs inline
- Variable explorer


---

### 📊 R Development

#### 4. R Extension for Visual Studio Code
**Extension ID:** `REditorSupport.r`

**Features:**
- R language support
- Code completion
- Integrated R terminal
- Plot viewer

**Setup:**
1. Install R on your system
2. Install the extension
3. Configure R path in settings if needed

---

### 📓 Data Science & Notebooks

#### 5. Data Wrangler
**Extension ID:** `ms-toolsai.datawrangler`

Explore and clean data with a visual interface.

#### 6. Rainbow CSV
**Extension ID:** `mechatroner.rainbow-csv`

Colorize CSV/TSV files for easier reading.

**Great for:**
- Viewing annotation files (GFF, GTF, BED)
- Reading tabular BLAST results
- Exploring metadata files

---

### 🧬 Bioinformatics-Specific Extensions

#### 7. Better TOML
**Extension ID:** `bungcip.better-toml`

For configuration files in bioinformatics pipelines (e.g., Nextflow, Snakemake).

#### 8. YAML
**Extension ID:** `redhat.vscode-yaml`

Essential for:
- Conda environment files (`environment.yml`)
- Snakemake configuration
- CI/CD pipelines

#### 9. Markdown All in One
**Extension ID:** `yzhang.markdown-all-in-one`

For documentation and lab notebooks.

**Features:**
- Table of contents generation
- Auto preview
- Keyboard shortcuts
- List editing

---

### 🔗 Remote Development

#### 10. Remote - SSH
**Extension ID:** `ms-vscode-remote.remote-ssh`

**Critical for bioinformatics!** Connect to:
- University HPC clusters
- Cloud servers (AWS, Google Cloud, Azure)
- Lab workstations

**Setup:**
1. Install the extension
2. Press `Ctrl+Shift+P` → **"Remote-SSH: Connect to Host..."**
3. Enter: `username@hostname`
4. Enter your password or use SSH key

#### 11. Remote - WSL (Windows only)
**Extension ID:** `ms-vscode-remote.remote-wsl`

Use Linux tools on Windows through WSL.

---

### 🎨 Productivity & Quality of Life

#### 12. GitLens
**Extension ID:** `eamodio.gitlens`

Supercharge Git capabilities:
- See who changed each line
- View file history
- Compare branches

#### 13. GitHub Copilot
**Extension ID:** `github.copilot`

AI-powered code completion (requires subscription or free for students).

**Great for:**
- Writing bioinformatics scripts faster
- Learning new libraries
- Generating boilerplate code

#### 14. indent-rainbow
**Extension ID:** `oderwat.indent-rainbow`

Colorize indentation levels - helpful for Python!

#### 15. Code Spell Checker
**Extension ID:** `streetsidesoftware.code-spell-checker`

Catch typos in your code and documentation.

---

### 📦 Installing All Recommended Extensions

You can install multiple extensions at once using the terminal:

```bash
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension REditorSupport.r
code --install-extension ms-toolsai.datawrangler
code --install-extension mechatroner.rainbow-csv
code --install-extension redhat.vscode-yaml
code --install-extension yzhang.markdown-all-in-one
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension eamodio.gitlens
code --install-extension oderwat.indent-rainbow
code --install-extension streetsidesoftware.code-spell-checker
```

---

## Practical Tips for Bioinformaticians

### 🖥️ Integrated Terminal Tips

Open terminal: `` Ctrl+` `` or `View → Terminal`

**Multiple terminals:**
- Click **"+"** to add new terminal
- Use dropdown to switch between terminals
- Split terminal for side-by-side view

### ⌨️ Essential Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+P` | Command Palette |
| `Ctrl+P` | Quick Open File |
| `Ctrl+Shift+F` | Search in All Files |
| `Ctrl+/` | Toggle Comment |
| `Alt+↑/↓` | Move Line Up/Down |
| `Ctrl+D` | Select Next Occurrence |
| `Ctrl+Shift+K` | Delete Line |
| `Ctrl+B` | Toggle Sidebar |
| `` Ctrl+` `` | Toggle Terminal |
| `F5` | Start Debugging |

### 📁 Workspace Organization

Create a workspace for your bioinformatics projects:

```
my-bioinformatics-workspace/
├── .vscode/
│   └── settings.json
├── project-1-rnaseq/
│   ├── data/
│   ├── scripts/
│   ├── results/
│   └── README.md
├── project-2-metagenomics/
│   ├── data/
│   ├── scripts/
│   ├── results/
│   └── README.md
└── shared-scripts/
    └── utils.py
```

## Conclusion

Visual Studio Code is an incredibly powerful tool for bioinformatics work. By mastering VSCode and its integration with GitHub, you'll be able to:

✅ Write and run bioinformatics code efficiently  
✅ Collaborate with other researchers seamlessly  
✅ Keep your analyses reproducible and version-controlled  
✅ Connect to remote servers and HPC clusters  
✅ Document your work alongside your code  

As you progress through the **Bioinformatics Ka Chilla** course, you'll use VSCode extensively for:

- 🐍 Python programming for data analysis
- 📊 R for statistical analysis and visualization
- 🐚 Bash scripting for pipeline automation
- 📓 Jupyter notebooks for interactive analysis
- 📝 Markdown for documentation

---

## 📚 Additional Resources

- [VSCode Official Documentation](https://code.visualstudio.com/docs)
- [GitHub Docs](https://docs.github.com)
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [Bioinformatics Ka Chilla Course](https://codanics.com/bioinformatics-ka-chilla/)
- [Codanics YouTube Channel](https://www.youtube.com/@Codanics)

---

## 🙋 Need Help?

If you have questions about this guide or the course:

- 📧 Email: [bioinfo@codanics.com](mailto:bioinfo@codanics.com)
- 🌐 Website: [codanics.com](https://codanics.com/)
- 📺 YouTube: [Codanics Channel](https://www.youtube.com/@Codanics)

---

**Happy Coding! 🧬💻**

*Dr. Aammar Tufail*  
*Bioinformatics Ka Chilla - Codanics.com*
