#!/bin/bash
set -e

# Directorios
structure_dir="4-Structure"
results_dir="5-Results"
output_csv="$results_dir/analysis_results.csv"

mkdir -p "$results_dir"

# Encabezado CSV
echo "File,TotalPairs,WatsonCrick,Wobble,NonCanonical,AdjacentStackings,NonAdjacentStackings" > "$output_csv"

# Función de análisis
analyze() {
    local file="$1"

    total_pairs=$(grep -c "pairing" "$file")
    wc=$(grep -c "Ww/Ww pairing antiparallel cis" "$file")
    wobble=$(grep -E "G-U|U-G" "$file" | grep -c "pairing")
    noncanon=$((total_pairs - wc))
    adj_stack=$(grep -c "adjacent_5p" "$file")
    nonadj_stack=$(grep -E "non adjacent|outward" "$file" | wc -l)

    echo "$file"
    echo "Total pairs: $total_pairs"
    echo "Watson-Crick: $wc"
    echo "Wobble (G-U): $wobble"
    echo "Non-canonical: $noncanon"
    echo "Adjacent stackings: $adj_stack"
    echo "Non-adjacent stackings: $nonadj_stack"
    echo "----------------------------------------"

    echo "$(basename "$file"),$total_pairs,$wc,$wobble,$noncanon,$adj_stack,$nonadj_stack" >> "$output_csv"
}

echo "=== Procesando PDBs y generando CSV ==="

# Loop sobre todos los archivos PDB
for pdb_file in "$structure_dir"/*.pdb; do
    base_name=$(basename "$pdb_file" .pdb)
    annotate_file="$structure_dir/${base_name}.annotate.txt"

    echo "Generando $annotate_file a partir de $pdb_file..."

    # -----------------------------
    # 1. Generar el archivo .annotate.txt con MC-Annotate
    # -----------------------------
    MC-Annotate "$pdb_file" > "$annotate_file"

    # -----------------------------
    # 2. Analizar el archivo .annotate.txt
    # -----------------------------
    analyze "$annotate_file"
done

echo "=== Pipeline finalizado ==="
echo "Resultados guardados en: $output_csv"

