#!/bin/bash
set -e  # Detener ejecución si hay algún error

# Crear carpetas necesarias
mkdir -p 1-Data
mkdir -p 2-Alignments

echo "=== Calculando estadísticas de archivos FASTA ==="
seqkit stats ./1-Data/RF01852.afa > ./1-Data/RF01852.stats
seqkit stats ./1-Data/rnacentral.fasta > ./1-Data/rnacentral.stats

echo "=== Realizando alineamiento con MAFFT ==="
mafft --thread 4 --seed ./1-Data/RF01852.afa ./1-Data/rnacentral.fasta > ./2-Alignments/rnacentral_aligned.fasta

echo "=== Reemplazando U por T en las secuencias alineadas ==="
seqkit replace -s -p u -r t ./2-Alignments/rnacentral_aligned.fasta > ./2-Alignments/rnacentral_aligned2.fasta

echo "=== Poniendo las secuencias en una sola línea ==="
seqkit seq -w 0 ./2-Alignments/rnacentral_aligned2.fasta > ./2-Alignments/rnacentral_aligned_oneline.fasta

echo "=== Extrayendo secuencias sin alineamiento ==="
seqkit seq -g ./2-Alignments/rnacentral_aligned2.fasta > ./2-Alignments/rnacentral_unaligned.fasta
seqkit seq -g -w 0 ./2-Alignments/rnacentral_aligned2.fasta > ./2-Alignments/rnacentral_unaligned_oneline.fasta

echo "=== Recortando las secuencias a 80 nucleótidos ==="
seqkit subseq -r 1:80 ./2-Alignments/rnacentral_unaligned.fasta | seqkit seq -w 0 > ./2-Alignments/rnacentral_unaligned_oneline_trimmed.fasta

echo "=== Pipeline completado ==="
