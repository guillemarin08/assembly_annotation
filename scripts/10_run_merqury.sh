#!/usr/bin/env bash
#SBATCH --job-name=merqury
#SBATCH --time=04:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/evaluation/merqury/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/evaluation/merqury/error_%j.e

# --- Variables ---
WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/evaluation/merqury"
PACBIO=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)

FLYE="${WORKDIR}/assemblies/flye/assembly.fasta"
HIFIASM="${WORKDIR}/assemblies/hifiasm/assembly.fa"
LJA="${WORKDIR}/assemblies/lja_K3001/assembly.fasta"

export MERQURY="/usr/local/share/merqury"
cd $OUTDIR

# 1. Create meryl database from raw reads (runs only if missing)
if [ ! -d "read_kmers.meryl" ]; then
    apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
    meryl count k=21 memory=32 threads=8 $PACBIO output read_kmers.meryl
fi

# 2. Evaluate Assemblies
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh read_kmers.meryl $FLYE flye_merqury
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh read_kmers.meryl $HIFIASM hifiasm_merqury
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh read_kmers.meryl $LJA lja_merqury
