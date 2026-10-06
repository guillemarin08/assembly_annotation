#!/usr/bin/env bash
#SBATCH --job-name=merqury_fix
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/evaluation/merqury/output_fix_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/evaluation/merqury/error_fix_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/evaluation/merqury"
MERYL_DB="${OUTDIR}/read_kmers.meryl"

FLYE="${WORKDIR}/assemblies/flye/assembly.fasta"
HIFIASM="${WORKDIR}/assemblies/hifiasm/assembly.fa"
LJA="${WORKDIR}/assemblies/lja_K3001/assembly.fasta"

export MERQURY="/usr/local/share/merqury"

# 1. Hifiasm 
mkdir -p ${OUTDIR}/hifiasm_eval
cd ${OUTDIR}/hifiasm_eval
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh $MERYL_DB $HIFIASM hifiasm_merqury

# 2. LJA 
mkdir -p ${OUTDIR}/lja_eval
cd ${OUTDIR}/lja_eval
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh $MERYL_DB $LJA lja_merqury

# 3. Flye
mkdir -p ${OUTDIR}/flye_eval
cd ${OUTDIR}/flye_eval
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh $MERYL_DB $FLYE flye_merqury