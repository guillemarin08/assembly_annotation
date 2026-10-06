#!/usr/bin/env bash
#SBATCH --job-name=jellyfish
#SBATCH --time=04:00:00
#SBATCH --mem=50G 
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/read_QC/kmer_counting/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/read_QC/kmer_counting/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
PACBIO=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
OUTDIR="${WORKDIR}/read_QC/kmer_counting"

# Load Jellyfish module
module load Jellyfish

# Count canonic k-mers (-C), use 5Gb (-s 5G) hash and 4 threads (-t 4)
jellyfish count -C -m 21 -s 5G -t 4 -o ${OUTDIR}/reads.jf <(zcat $PACBIO)

# Generate the histogram
jellyfish histo -t 4 ${OUTDIR}/reads.jf > ${OUTDIR}/reads.histo
