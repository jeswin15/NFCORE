# IsoSeqAnnotate


A modular, reproducible Nextflow pipeline for PacBio Iso-Seq transcriptome processing, alignment, and transcript annotation.

[![Nextflow](https://img.shields.io/badge/Nextflow-DSL2-brightgreen.svg)](https://www.nextflow.io/)
[![Conda](https://img.shields.io/badge/Conda-supported-blue.svg)](https://conda.io/)
[![Python](https://img.shields.io/badge/Python-3.10+-yellow.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)


---

# Overview

IsoSeqAnnotate is a **Nextflow DSL2** pipeline designed for processing **PacBio Iso-Seq long-read transcriptome sequencing data**.

The pipeline performs complete transcript preprocessing, genome alignment, and transcript collapsing using either the official **PacBio IsoSeq3 Collapse** algorithm or the **TAMA Collapse** framework.

Designed with reproducibility and modularity in mind, IsoSeqAnnotate provides an easy-to-use workflow suitable for research laboratories, academic institutions, and high-performance computing environments.

---

# Features

✔ PacBio LIMA demultiplexing

✔ IsoSeq3 Refine

✔ IsoSeq3 Cluster2

✔ TAMA Poly(A) Cleanup

✔ PBMM2 Genome Alignment

✔ Dual Transcript Collapse

- IsoSeq3 Collapse
- TAMA Collapse

✔ Nextflow DSL2 Modular Architecture

✔ Conda Environment Support

✔ Automatic Pipeline Reports

✔ Professional Logging

✔ Public Test Dataset

✔ Reproducible Execution

---

# Workflow

```
    PacBio CCS BAM
        │
        ▼
──────────────────────────────
       LIMA
──────────────────────────────
        │
        ▼
──────────────────────────────
      REFINE
──────────────────────────────
        │
        ▼
──────────────────────────────
     CLUSTER2
──────────────────────────────
        │
        ▼
──────────────────────────────
    TAMA Cleanup
──────────────────────────────
        │
        ▼
──────────────────────────────
    PBMM2 Alignment
──────────────────────────────
        │
        ▼
──────────────────────────────
   Transcript Collapse
──────────────────────────────
            │
            ▼
      ┌───────────────┐
      │               │
      ▼               ▼

    IsoSeq3          TAMA

      │               │
      └──────┬────────┘
             ▼

Final Transcript Annotation

```

---

# Pipeline Structure

```
IsoSeqAnnotate/

├── assets/
│
├── conf/
│
├── docs/
│
├── envs/
│
├── modules/
│
├── workflows/
│
├── third_party/
│   └── tama/
│
├── results/
│
├── main.nf
├── nextflow.config
└── README.md

```

---

# Installation

IsoSeqAnnotate requires **Java**, **Git**, **Miniforge (Conda)**, and **Nextflow**. Follow the steps below to install all required software on a fresh Linux (Ubuntu) system.

---

## 1. Install Java (JDK 17)

Nextflow requires **Java 17 or later**.

### Check if Java is already installed

```bash
java -version
```

Expected output:

```text
openjdk version "17.x.x"
```

If Java is already installed, proceed to the next step.

### Install Java (Ubuntu)

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
```

### Verify Installation

```bash
java -version
```

Example:

```text
openjdk version "17.0.19"
OpenJDK Runtime Environment
OpenJDK 64-Bit Server VM
```

---

## 2. Install Git

Git is required to clone and update the pipeline repository.

### Check if Git is installed

```bash
git --version
```

Example:

```text
git version 2.43.0
```

If Git is already installed, proceed to the next step.

### Install Git

```bash
sudo apt update
sudo apt install git -y
```

### Verify Installation

```bash
git --version
```

---

## 3. Install Miniforge (Conda)

IsoSeqAnnotate uses **Conda** to install and manage all required software dependencies.

### Download Miniforge

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

### Install Miniforge

```bash
bash Miniforge3-Linux-x86_64.sh
```

During installation:

- Press **Enter** to use the default installation location.
- Type **yes** to accept the license agreement.
- Type **yes** when prompted to initialize Conda.

### Reload the Shell

```bash
source ~/.bashrc
```

Alternatively, close and reopen your terminal.

### Verify Installation

```bash
conda --version
```

Example:

```text
conda 25.x.x
```

---

## 4. Install Nextflow

Nextflow is the workflow management system used to execute the pipeline.

### Download Nextflow

```bash
curl -s https://get.nextflow.io | bash
```

### Move Nextflow to Your PATH

```bash
sudo mv nextflow /usr/local/bin/
```

### Verify Installation

```bash
nextflow -version
```

Example:

```text
N E X T F L O W
version 26.04.4
```

---

## Requirements

- Linux
- Nextflow ≥ 24.x
- Conda / Mamba
- Java 17+

---

## Clone Repository

```bash
git clone https://github.com/<jeswin15>/NFCORE.git

cd IsoSeqAnnotate
```

---

## Create Conda Environment

```bash
conda env create -f envs/environment.yml

conda activate isoseqannotate
```

---

# Quick Start

## IsoSeq3 Collapse

```bash
nextflow run main.nf \
    --input sample.ccs.bam \
    --primers primers.fasta \
    --genome genome.fa \
    --collapse_method isoseq3
```

---

## TAMA Collapse

```bash
nextflow run main.nf \
    --input sample.ccs.bam \
    --primers primers.fasta \
    --genome genome.fa \
    --collapse_method tama
```

---

# Test Pipeline

IsoSeqAnnotate includes a small public PacBio test dataset.

Run:

```bash
nextflow run main.nf -profile test
```

or

```bash
nextflow run main.nf \
    --input modules/local/test_data/alz.ccs.bam \
    --primers modules/local/test_data/isoseq_primers.fasta \
    --genome modules/local/test_data/genome.fa
```

---

# Parameters

|      Parameter      |       Description      | Required |
|---------------------|------------------------|----------|
| `--input`           | PacBio CCS BAM         | Yes      |
| `--primers`         | Primer FASTA           | Yes      |
| `--genome`          | Reference Genome FASTA | Yes      |
| `--collapse_method` | isoseq3 , tama         | No       |
| `--outdir`          | Output directory       | No       |

---

# Output Structure

```
results/

├── 01_preprocessing/
│   ├── lima/
│   ├── refine/
│   └── cluster2/
│
├── 02_cleanup/
│   └── tama_cleanup/
│
├── 03_alignment/
│   └── pbmm2/
│
├── 04_annotation/
│   ├── isoseq3/
│   └── tama/
│
├── pipeline_info/
│
├── logs/
│
└── summary/

```

---

# Generated Reports

IsoSeqAnnotate automatically generates

- Execution Report
- Timeline
- Trace File
- Directed Acyclic Graph (DAG)
- Software Versions

located in

```
results/pipeline_info/
```

---

# Third-party Software

IsoSeqAnnotate integrates several established bioinformatics tools.

|         Tool       |             Purpose               |
|--------------------|-----------------------------------|
| LIMA               | Adapter Removal                   |
| IsoSeq3 Refine     | Full-length Refinement            |
| IsoSeq3 Cluster2   | Transcript Clustering             |
| PBMM2              | Genome Alignment                  |
| TAMA Cleanup       | Poly(A) Cleanup                   |
| IsoSeq3 Collapse   | Transcript Collapsing             |
| TAMA Collapse      | Alternative Transcript Collapsing |

---

# Reproducibility

IsoSeqAnnotate supports

- Conda
- Local Execution
- Nextflow DSL2

Future releases will include

- Docker
- Singularity / Apptainer
- nf-core compatibility
- GitHub CI

---

# Documentation

Detailed documentation is available in

```
docs/

installation.md

usage.md

parameters.md

outputs.md

```

---

# License

IsoSeqAnnotate is distributed under the MIT License.

Bundled third-party software retains its original license.

See

```
LICENSE

LICENSES/
```

for details.

---

# Acknowledgements

IsoSeqAnnotate builds upon the outstanding work of

- Pacific Biosciences
- TAMA Development Team
- Nextflow
- Bioconda
- nf-core Community

---

# Roadmap

## v0.95

- Dual Collapse Support
- Bundled TAMA
- Conda Environment
- Parameter Validation
- Startup Banner
- Professional Output Structure

---

## v1.0

- Docker Support
- Singularity Support
- CI/CD
- Multi-profile Execution
- Complete Documentation
- Software Version Tracking

---

## v2.0

- nf-core Compatible Release
- SQANTI3 Integration
- Multi-sample Support
- Differential Isoform Analysis
- Cloud Execution Support

---

<div align="center">

Developed with ❤️ using Nextflow DSL2

</div>
