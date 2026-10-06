#!/usr/bin/env bash
#SBATCH --job-name=busco
#SBATCH --time=06:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/evaluation/busco/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/evaluation/busco/error_%j.e

# --- Variables ---
WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/evaluation/busco"
LINEAGE="brassicales_odb10"

# 1. Evaluate Flye
apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i ${WORKDIR}/assemblies/flye/assembly.fasta -l $LINEAGE -o busco_flye -m genome -c 8 --out_path $OUTDIR

# 2. Evaluate Hifiasm
apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i ${WORKDIR}/assemblies/hifiasm/assembly.fa -l $LINEAGE -o busco_hifiasm -m genome -c 8 --out_path $OUTDIR

# 3. Evaluate LJA (rescued assembly with K=3001)
apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i ${WORKDIR}/assemblies/lja_K3001/assembly.fasta -l $LINEAGE -o busco_lja -m genome -c 8 --out_path $OUTDIR

# 4. Evaluate Trinity (Transcriptome)
apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i ${WORKDIR}/assemblies/Trinity/Trinity.tmp.fasta -l $LINEAGE -o busco_trinity -m transcriptome -c 8 --out_path $OUTDIR
