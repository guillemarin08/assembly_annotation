#!/usr/bin/env bash
#SBATCH --job-name=quast
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/evaluation/quast/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/evaluation/quast/error_%j.e

# --- Variables ---
WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/evaluation/quast"
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
FEAT="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.57.gff3"

FLYE="${WORKDIR}/assemblies/flye/assembly.fasta"
HIFIASM="${WORKDIR}/assemblies/hifiasm/assembly.fa"
LJA="${WORKDIR}/assemblies/lja_K3001/assembly.fasta"

# 1. Run QUAST with reference genome
apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif \
quast.py -o ${OUTDIR}/with_ref -r $REF -g $FEAT --threads 4 \
--labels flye,hifiasm,lja --eukaryote --large \
$FLYE $HIFIASM $LJA

# 2. Run QUAST without reference (includes est-ref-size to calculate NG50)
apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif \
quast.py -o ${OUTDIR}/without_ref --threads 4 \
--labels flye,hifiasm,lja --eukaryote --large --est-ref-size 135000000 \
$FLYE $HIFIASM $LJA
