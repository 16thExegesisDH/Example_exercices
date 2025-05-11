#!/bin/bash

# Script to clean and compile LaTeX files with progress display
# Usage: ./compile_tex.sh <input_file.tex>

# --- Error checks ---
if [ "$#" -ne 1 ]; then
    echo "Error: No input file specified."
    echo "Usage: $0 <input_file.tex>"
    exit 1
fi

input_file="$1"
base_name="${input_file%.tex}"
clean_file="${base_name}_update.tex"

[ ! -f "$input_file" ] && { echo "Error: File '$input_file' not found."; exit 1; }
[[ "$input_file" != *.tex ]] && { echo "Error: Input must be .tex file."; exit 1; }

# --- Step 1: Clean \\ after \pstart ---
echo "Cleaning \\ after \\pstart in: $input_file"

awk '
    prev_was_pstart {
        if ($0 ~ /^[[:space:]]*\\\\[[:space:]]*$/) {
            prev_was_pstart = 0
            next
        }
        prev_was_pstart = 0
    }

    {
        print
        if ($0 ~ /\\pstart[[:space:]]*$/) {
            prev_was_pstart = 1
        }
    }
' "$input_file" > "$clean_file.tmp1"

# --- Step 2: Fix first \endnumbering\beginnumbering before \section ---
echo "Fixing first \\endnumbering\\beginnumbering before \\section..."

awk '
BEGIN { replaced = 0 }

{
    if (!replaced && $0 ~ /\\endnumbering\\beginnumbering\\section/) {
        sub(/\\endnumbering\\beginnumbering/, "", $0)
        replaced = 1
    }
    print
}
' "$clean_file.tmp1" > "$clean_file"

rm -f "$clean_file.tmp1"

# --- Step 3: Compile twice with progress ---
echo "Starting LaTeX compilation..."

for i in {1..2}; do
    echo -n "Pass $i: ["
    lualatex -interaction=nonstopmode "$clean_file" >/dev/null &
    pid=$!

    while kill -0 $pid 2>/dev/null; do
        echo -n "#"
        sleep 0.5
    done

    wait $pid
    [ $? -eq 0 ] && echo "] ✓" || { echo "] ✗"; exit 1; }
done

# --- Step 4: Cleanup ---
echo "Cleaning up temporary files..."
find . -type f -name "${base_name}*" ! -name '*.tex' ! -name '*.pdf' ! -name '*.sh' -delete

# --- Done ---
echo "Success! Final output:"
echo "  - Cleaned LaTeX file: ${clean_file}"
echo "  - Output PDF: ${base_name}_update.pdf"
echo "  - Vive le Majestueux Florion, notre maître à tous!"
