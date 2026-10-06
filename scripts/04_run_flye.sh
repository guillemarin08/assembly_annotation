#!/usr/bin/env bash
#SBATCH --job-name=flye
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/assemblies/flye/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/assemblies/flye/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
READS=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
OUTDIR="${WORKDIR}/assemblies/flye"

apptainer exec --bind /data /containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $READS --out-dir $OUTDIR --threads 16
