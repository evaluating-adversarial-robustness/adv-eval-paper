# phony targets

all: paper.pdf abstract.txt

clean:
	latexmk -pdf -C
	rm -rf *.txt version.tex

.PHONY: all clean FORCE

# main targets

arxiv.tar.gz: paper.pdf # just build the paper because we want to build the .bbl
	tar czvf paper.tar.gz paper.tex paper.bbl $(DEPS)

%.txt: %.tex
	pandoc $< -o $@ -f latex -t plain --wrap=none

paper.pdf: FORCE
	sh version.sh version.tex
	latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf paper.tex
