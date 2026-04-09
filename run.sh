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

echo "--- Compiling LaTeX to PDF ---"
pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex" > /dev/null
if [ $? -ne 0 ]; then
    echo "Error: First pdflatex pass failed. Check build/$FILENAME.log"
    exit 1
fi

bibtex build/"$FILENAME".aux

pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex" > /dev/null
pdflatex -interaction=nonstopmode -output-directory=build "$FILENAME.tex"
if [ $? -ne 0 ]; then
    echo "Error: PDF compilation failed. Check build/$FILENAME.log"
    exit 1
fi

PDF_SRC="build/$FILENAME.pdf"
if [ ! -f "$PDF_SRC" ]; then
    echo "Error: PDF not found after compilation."
    exit 1
fi

# --- Handle PDF output ---
if [ "$MODE" = "--pdf-only" ] || [ "$MODE" = "--both" ]; then
    mv "$PDF_SRC" "pdfs/"
    echo "PDF saved to pdfs/$FILENAME.pdf"
fi

# --- Handle Word output ---
if [ "$MODE" = "--word-only" ] || [ "$MODE" = "--both" ]; then
    # Check for pdf2docx
    if ! command -v pdf2docx &> /dev/null && ! python3 -c "import pdf2docx" &> /dev/null; then
        echo "Error: pdf2docx not installed. Install with: pip install pdf2docx"
        exit 1
    fi

    echo "--- Converting PDF to Word (DOCX) using pdf2docx ---"
    if [ "$MODE" = "--both" ]; then
        PDF_FOR_WORD="pdfs/$FILENAME.pdf"
    else
        PDF_FOR_WORD="$PDF_SRC"
    fi

    DOCX_OUT="words/$FILENAME.docx"
    # Use python -m pdf2docx convert
    python3 -m pdf2docx convert "$PDF_FOR_WORD" "$DOCX_OUT"

    if [ $? -eq 0 ] && [ -f "$DOCX_OUT" ]; then
        echo "Word document saved to $DOCX_OUT"
    else
        echo "Error: PDF to DOCX conversion failed. Check that the PDF is valid."
        exit 1
    fi

    # Clean up temporary PDF if --word-only
    if [ "$MODE" = "--word-only" ]; then
        rm -f "$PDF_SRC"
    fi
fi

echo "---------------------------------------"
echo "Success! Output(s) generated as requested."