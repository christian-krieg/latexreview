#COMMIT=HEAD^
COMMIT := HEAD
MAIN := test.tex

.PHONY: pdf
pdf:
	latexmk -pdf ${MAIN}

.PHONY: help
help:
	@echo "make pdf [MAIN=<main>]"
	@echo "    Generate the PDF for the thesis. <main> defaults to '$(MAIN)'"
	@echo "    and refers to the main LaTeX file"
	@echo ""
	@echo "make diff [COMMIT=hash] [MAIN=<main>]"
	@echo "    Generate a PDF that shows the differences from the current"
	@echo "    HEAD to the commit identified by its hash given as COMMIT."
	@echo "    By default, COMMIT is '$(COMMIT)'"
	@echo ""

.PHONY: diff
diff:
	git latexdiff --run-biber --view --pdf-viewer evince --output diff.pdf --main ${MAIN} --ignore-latex-errors ${COMMIT} --
