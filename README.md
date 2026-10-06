# Arabidopsis thaliana (Nemrut-1) - Assembly and Annotation

**Author:** Guillermo Marín García
**Course:** Assembly and Annotation Course (University of Bern)
**Accession:** Nemrut-1

## Overview
This repository contains the bash/SLURM scripts and main evaluation results for the *de novo* genome assembly of the *Arabidopsis thaliana* Nemrut-1 accession using PacBio HiFi reads, as well as a transcriptome assembly using Illumina RNA-seq data.

## Project Structure

```text
assembly_annotation/
├── README.md
├── scripts/                  
│   ├── 01_run_fastqc.sh      # QC
│   ├── 02_run_fastp.sh       # Trimming
│   ├── 03_run_jellyfish.sh   # K-mers
│   ├── 04_run_flye.sh        # Assembly
│   ├── 05_run_hifiasm.sh     # Assembly
│   ├── 06_run_lja.sh         # Assembly
│   ├── 07_run_trinity.sh     # Transcriptome
│   ├── 08_run_quast.sh       # Evaluation
│   ├── 09_run_busco.sh       # Evaluation
│   ├── 10_run_merqury.sh     # Evaluation
│   └── 11_run_mummer.sh      # Evaluation
└── results/                  
    ├── qc/
    ├── busco/
    ├── merqury/
    ├── mummer/
    └── quast/
```

## Workflow Structure
The `scripts/` directory includes sequentially numbered SLURM job scripts covering the entire pipeline:
1. **Read QC & K-mer counting:** `fastqc`, `fastp` (RNA-seq trimming), `jellyfish` (k=21).
2. **De Novo Assembly:** 
   - `Flye` 
   - `Hifiasm` 
   - `LJA` (Required K=3001 rescue due to repeat tangles).
   - `Trinity` (RNA-seq transcriptome).
3. **Evaluation:** `QUAST` (with and without TAIR10 reference), `BUSCO` (brassicales_odb10), `Merqury`, and `Mummerplot` (Nucmer).

## Key Findings (Nemrut-1)
*   **Flye** performed best overall (Optimal size: 136.2 Mb, Highest QV: 69.52, and perfect structural collinearity).
*   **Hifiasm** failed to collapse the highly homozygous genome, resulting in artificial fragmentation (176.3 Mb, >1000 contigs).
*   **LJA** crashed with default parameters but was successfully completed using `-K 3001`.
*   **Transcriptome (Trinity)** successfully assembled, with BUSCO revealing 44.9% duplicated genes, accurately reflecting alternative splicing events.

Please check the `results/` folder for dotplots, spectra plots, and summary metrics.
