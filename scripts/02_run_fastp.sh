#!/usr/bin/env bash
#SBATCH --job-name=fastp
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/read_QC/fastp/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/read_QC/fastp/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
PACBIO=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
RNA1="${WORKDIR}/RNAseq_Sha/ERR754081_1.fastq.gz"
RNA2="${WORKDIR}/RNAseq_Sha/ERR754081_2.fastq.gz"
OUTDIR="${WORKDIR}/read_QC/fastp"

# Load fastp module
module load fastp

# Filter and trimm RNA-seq reads from Illumina
fastp -i $RNA1 -I $RNA2 \
      -o ${OUTDIR}/RNAseq_trimmed_1.fastq.gz -O ${OUTDIR}/RNAseq_trimmed_2.fastq.gz \
      --thread 4 \
      --html ${OUTDIR}/RNAseq_fastp.html \
      --json ${OUTDIR}/RNAseq_fastp.json

# Obtain statistics from PacBio without filter
fastp -i $PACBIO \
      -o ${OUTDIR}/PacBio_unfiltered.fastq.gz \
      --disable_quality_filtering --disable_length_filtering \
      --thread 4 \
      --html ${OUTDIR}/PacBio_fastp.html \
      --json ${OUTDIR}/PacBio_fastp.json
