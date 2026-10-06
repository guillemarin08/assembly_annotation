#!/usr/bin/env bash
#SBATCH --job-name=mummer
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/gmaringarcia/assembly_annotation_course/evaluation/mummer/output_%j.o
#SBATCH --error=/data/users/gmaringarcia/assembly_annotation_course/evaluation/mummer/error_%j.e

# --- Variables ---
WORKDIR="/data/users/gmaringarcia/assembly_annotation_course"
OUTDIR="${WORKDIR}/evaluation/mummer"
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

FLYE="${WORKDIR}/assemblies/flye/assembly.fasta"
HIFIASM="${WORKDIR}/assemblies/hifiasm/assembly.fa"
LJA="${WORKDIR}/assemblies/lja_K3001/assembly.fasta"

cd $OUTDIR

# --- PART 1: Assemblies vs Reference ---
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=flye_vs_ref --breaklen 1000 --mincluster 1000 $REF $FLYE && \
mummerplot -R $REF -Q $FLYE --filter -t png --large --layout --fat -p flye_dotplot flye_vs_ref.delta"

apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=hifiasm_vs_ref --breaklen 1000 --mincluster 1000 $REF $HIFIASM && \
mummerplot -R $REF -Q $HIFIASM --filter -t png --large --layout --fat -p hifiasm_dotplot hifiasm_vs_ref.delta"

apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=lja_vs_ref --breaklen 1000 --mincluster 1000 $REF $LJA && \
mummerplot -R $REF -Q $LJA --filter -t png --large --layout --fat -p lja_dotplot lja_vs_ref.delta"

# --- PART 2: Inter-assembly Comparisons ---
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=flye_vs_hifiasm --breaklen 1000 --mincluster 1000 $FLYE $HIFIASM && \
mummerplot -R $FLYE -Q $HIFIASM --filter -t png --large --layout --fat -p flye_vs_hifiasm_dotplot flye_vs_hifiasm.delta"

apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=lja_vs_flye --breaklen 1000 --mincluster 1000 $LJA $FLYE && \
mummerplot -R $LJA -Q $FLYE --filter -t png --large --layout --fat -p lja_vs_flye_dotplot lja_vs_flye.delta"

apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif bash -c "\
nucmer --prefix=lja_vs_hifiasm --breaklen 1000 --mincluster 1000 $LJA $HIFIASM && \
mummerplot -R $LJA -Q $HIFIASM --filter -t png --large --layout --fat -p lja_vs_hifiasm_dotplot lja_vs_hifiasm.delta"
