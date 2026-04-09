#!/bin/bash

# Usage: ./run.sh filename.tex [--pdf-only|--word-only|--both]

if [ -z "$1" ]; then
    echo "Usage: ./run.sh filename.tex [--pdf-only|--word-only|--both]"
    echo "  --pdf-only  : generate PDF only (default)"
    echo "  --word-only : generate Word (DOCX) only"
    echo "  --both      : generate both PDF and Word"
    exit 1
fi

FILENAME=$(basename "$1" .tex)
MODE="${2:---pdf-only}"

case "$MODE" in
    --pdf-only|--word-only|--both) ;;
    *)
        echo "Error: Unknown option '$MODE'. Use --pdf-only, --word-only, or --both"
        exit 1
        ;;
esac

if [ ! -f "$FILENAME.tex" ]; then
    echo "Error: $FILENAME.tex not found."
    exit 1
fi

mkdir -p build pdfs words
rm -f build/"$FILENAME".{aux,bbl,blg,log,out,toc,lof,lot}

# --- PDF generation (if needed) ---
if [ "$MODE" = "--pdf-only" ] || [ "$MODE" = "--both" ]; then
    echo "--- Compiling LaTeX to PDF (with bibliography) ---"

    # First pass
    pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex" > /dev/null
    # BibTeX (ignore errors if no citations)
    bibtex build/"$FILENAME".aux 2>/dev/null

    # Second pass
    pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex" > /dev/null
    # Third pass (final) – we check existence of PDF, not exit code
    pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex"

    PDF_SRC="build/$FILENAME.pdf"
    if [ -f "$PDF_SRC" ]; then
        mv "$PDF_SRC" "pdfs/"
        echo "PDF saved to pdfs/$FILENAME.pdf"
    else
        echo "Error: PDF compilation failed. Check build/$FILENAME.log"
        exit 1
    fi
fi

# --- Word generation (if needed) ---
if [ "$MODE" = "--word-only" ] || [ "$MODE" = "--both" ]; then
    echo "--- Converting LaTeX to Word (DOCX) using pandoc ---"
    mkdir -p words

    if ! command -v pandoc &> /dev/null; then
        echo "Error: pandoc not installed. Install with: sudo apt install pandoc"
        exit 1
    fi

    # Download a standard CSL if not present
    CSL_FILE="chicago-author-date.csl"
    if [ ! -f "$CSL_FILE" ]; then
        echo "Downloading CSL style..."
        curl -s -L -o "$CSL_FILE" "https://raw.githubusercontent.com/citation-style-language/styles/master/chicago-author-date.csl"
    fi

    # Run pandoc (without crossref filter to avoid conflicts)
    pandoc "$FILENAME.tex" \
        --from latex \
        --to docx \
        --output "words/$FILENAME.docx" \
        --natbib \
        --citeproc \
        --bibliography="bibliography.bib" \
        --csl="$CSL_FILE" \
        --resource-path=".:./figs:./figures" \
        --wrap=preserve \
        --highlight-style=tango

    if [ $? -eq 0 ] && [ -f "words/$FILENAME.docx" ]; then
        echo "Word document saved to words/$FILENAME.docx"
        echo "Note: Cross-references (\\ref{}) are not automatically resolved in Word."
    else
        echo "Error: pandoc conversion failed."
        exit 1
    fi
fi

echo "---------------------------------------"
echo "Success! Output(s) generated as requested."