#!/bin/bash
set -e  # Detener ejecución si hay algún error

echo "=== Generaciòn de logo con WebLogo ==="
weblogo -f ./2-Alignments/rnacentral_aligned_oneline.fasta -o ./5-Results/rnacentral_aligned_oneline.png -F png --sequence-type rna --title "" --units bits --resolution 300 --stacks-per-line 140

weblogo -f ./2-Alignments/rnacentral_unaligned_oneline_trimmed.fasta -o ./5-Results/rnacentral_unaligned_oneline_trimmed.png -F png --sequence-type rna --title "" --units bits --resolution 300 --stacks-per-line 140

echo "=== Pipeline completado ==="
