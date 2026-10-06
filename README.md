# Arabidopsis thaliana (Nemrut-1) - Assembly and Annotation

**Author:** Guillermo Marín García
**Course:** Assembly and Annotation Course (Universities of Bern)
**Accession:** Nemrut-1

## Overview
This repository contains the bash/SLURM scripts and main evaluation results for the *de novo* genome assembly of the *Arabidopsis thaliana* Nemrut-1 accession using PacBio HiFi reads, as well as a transcriptome assembly using Illumina RNA-seq data.

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
