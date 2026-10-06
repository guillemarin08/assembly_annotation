#!/usr/bin/env bash
#SBATCH --job-name=fastqc
#SBATCH --time=01:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/read_QC/fastqc/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/read_QC/fastqc/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
PACBIO=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
RNA1="${WORKDIR}/RNAseq_Sha/ERR754081_1.fastq.gz"
RNA2="${WORKDIR}/RNAseq_Sha/ERR754081_2.fastq.gz"
OUTDIR="${WORKDIR}/read_QC/fastqc"

apptainer exec --bind /data /containers/apptainer/fastqc-0.12.1.sif \
fastqc -t 4 -o $OUTDIR $PACBIO $RNA1 $RNA2
