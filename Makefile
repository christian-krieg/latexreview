#COMMIT=HEAD^
COMMIT=HEAD
MAIN=test

.PHONY: pdf
pdf:
	pdflatex -interaction nonstopmode ${MAIN}
	biber ${MAIN}
	pdflatex -interaction nonstopmode ${MAIN}
	makeglossaries ${MAIN}
	pdflatex -interaction nonstopmode ${MAIN}
	pdflatex -interaction nonstopmode ${MAIN}

.PHONY: help
help:
	@echo "make pdf [MAIN=<main>]"
	@echo "    Generate the PDF for the thesis. <main> defaults to 'main' and"
	@echo "    refers to the base name of the main LaTeX file also called the"
	@echo "    'jobname' in pdflatex)"
	@echo ""
	@echo "make diff [COMMIT=hash] [MAIN=<main>]"
	@echo "    Generate a PDF that shows the differences from the current"
	@echo "    HEAD to the commit identified by its hash given as COMMIT."
	@echo "    By default, COMMIT is 'HEAD^'"
	@echo ""

.PHONY: diff
diff:
	git latexdiff --run-biber --view --pdf-viewer evince --output diff.pdf --main ${MAIN}.tex --ignore-makefile --ignore-latex-errors ${COMMIT} --
