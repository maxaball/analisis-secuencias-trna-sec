#!/bin/bash
set -e  # Detener ejecución si hay algún error

# Crear carpeta de resultados si no existe
mkdir -p 3-Folding

echo "=== Ejecutando RNAalifold sobre las secuencias alineadas ==="
RNAalifold --color ./2-Alignments/rnacentral_aligned2.fasta > ./3-Folding/rnacentral_alifold.fasta

echo "=== Ejecutando RNAfold sobre las secuencias no alineadas ==="
RNAfold --noPS ./2-Alignments/rnacentral_unaligned.fasta > ./3-Folding/rnacentral_fold.fasta

echo "=== Eliminando los valores de MFE del output con sed ==="
sed 's/ ([-0-9.]\+)//' ./3-Folding/rnacentral_fold.fasta > ./3-Folding/rnacentral_fold_nomfe.fasta

echo "=== Pipeline de folding completado ==="

