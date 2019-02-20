DEPS := \
	iclr2019_conference.sty \
	iclr2019_conference.bst \
	paper.bib \
	abstract.tex


LATEX  := pdflatex
LATEXOPTS := -interaction nonstopmode
BIBTEX := bibtex
PANDOC := pandoc

# phony targets

all: paper.pdf abstract.txt

clean:
	rm -rf *.aux *.log *.blg *.bbl *.ent *.out *.dvi *.ps *.pdf *.tar.gz abstract.txt

arxiv: arxiv.tar.gz

.PHONY: all clean arxiv

# main targets

arxiv.tar.gz: paper.pdf # just build the paper because we want to build the .bbl
	tar czvf paper.tar.gz paper.tex paper.bbl $(DEPS)

%.txt: %.tex
	$(PANDOC) $< -o $@ -f latex -t plain --wrap=none

%.pdf: %.tex $(DEPS)
	$(eval SRC_$@ = $(patsubst %.tex, %, $<))
	sh version.sh version.tex
	$(LATEX) $(LATEXOPTS) $(SRC_$@)
	$(BIBTEX) $(SRC_$@)
	$(LATEX) $(LATEXOPTS) $(SRC_$@)
	$(LATEX) $(LATEXOPTS) $(SRC_$@)
