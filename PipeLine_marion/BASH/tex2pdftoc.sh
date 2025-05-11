#!/bin/bash

# Script to process LaTeX files with clean progress display
# Usage: ./compile_tex.sh <input_file.tex>

# --- Error checks (unchanged) ---
if [ "$#" -ne 1 ]; then
    echo "Error: No input file specified."
    echo "Usage: $0 <input_file.tex>"
    exit 1
fi

input_file="$1"
base_name="${input_file%.tex}"

[ ! -f "$input_file" ] && { echo "Error: File '$input_file' not found."; exit 1; }
[[ "$input_file" != *.tex ]] && { echo "Error: Input must be .tex file."; exit 1; }

# --- Processing ---
output_file="${base_name}_update.tex"
echo "Processing LaTeX file: $input_file"

# Process with sed
sed -E '
    s/([A-Za-zΆ-Ωά-ω])- +/\1/g;
    s/(\\[a-zA-Z]+\{[^}]+)-/\1/g
' "$input_file" > "$output_file" || { echo "Error: sed failed"; exit 1; }

echo "Created processed file: $output_file"
echo "Starting LaTeX compilation..."

# --- Compilation with progress ---
# you have to compile twince : the first for latex, the second for the TOC (table of content)
for i in {1..2}; do
    echo -n "Pass $i: ["
    lualatex -interaction=nonstopmode "$output_file" >/dev/null &
    pid=$!
    
    # Progress animation
    while kill -0 $pid 2>/dev/null; do
        echo -n "#"
        sleep 0.5
    done
    
    wait $pid
    [ $? -eq 0 ] && echo "] ✓" || { echo "] ✗"; exit 1; }
done

# --- Cleanup ---
# if you want the  other files commente the two next lines
echo "Cleaning up temporary files..."
find . -type f -name "${base_name}*" ! -name '*.tex' ! -name '*.pdf' ! -name '*.sh' -delete

echo "Success! Final output:"
echo "  - Processed LaTeX file: ${output_file}"
echo "  - Output PDF: ${base_name}_update.pdf"
echo "  - Vive le Majestueux Florion, notre maître à tous!"
