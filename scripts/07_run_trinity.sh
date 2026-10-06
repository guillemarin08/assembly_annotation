#!/usr/bin/env bash
#SBATCH --job-name=trinity
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/assemblies/Trinity/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/assemblies/Trinity/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
RNA1="${WORKDIR}/RNAseq_Sha/ERR754081_1.fastq.gz"
RNA2="${WORKDIR}/RNAseq_Sha/ERR754081_2.fastq.gz"
OUTDIR="${WORKDIR}/assemblies/Trinity"

module load Trinity
Trinity --seqType fq --left $RNA1 --right $RNA2 --max_memory 60G --CPU 16 --output $OUTDIR
