#!/usr/bin/env bash
#SBATCH --job-name=lja_K3001
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/assemblies/output_lja_K3001_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/assemblies/error_lja_K3001_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/assemblies/lja_K3001"
PACBIO=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)

# Ejecutamos LJA usando el contenedor del curso, pero forzando K=3001
apptainer exec --bind /data /containers/apptainer/lja-0.2.sif \
lja -o $OUTDIR --reads $PACBIO --threads 16 -K 3001
