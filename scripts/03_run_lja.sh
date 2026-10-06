#!/usr/bin/env bash
#SBATCH --job-name=lja
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/assemblies/lja/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/assemblies/lja/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
READS=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
OUTDIR="${WORKDIR}/assemblies/lja"

apptainer exec --bind /data /containers/apptainer/lja-0.2.sif \
lja -o $OUTDIR --reads $READS --threads 16
