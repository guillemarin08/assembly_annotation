#!/usr/bin/env bash
#SBATCH --job-name=hifiasm
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/assemblies/hifiasm/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/assemblies/hifiasm/error_%j.e

WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
READS=$(ls ${WORKDIR}/Nemrut-1/*.fastq.gz)
OUTDIR="${WORKDIR}/assemblies/hifiasm"

apptainer exec --bind /data /containers/apptainer/hifiasm_0.25.0.sif \
hifiasm -o ${OUTDIR}/assembly -t 16 $READS

awk '/^S/{print ">"$2;print $3}' ${OUTDIR}/assembly.bp.p_ctg.gfa > ${OUTDIR}/assembly.fa
