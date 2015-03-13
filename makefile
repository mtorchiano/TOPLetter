
default: all

all: docs class examples

EXAMPLES=EsempioLettera.pdf ExampleLetter.tex
TEMPS=*.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind

docs: TOPletter.dtx
	pdflatex TOPletter.dtx
	makeindex -s gglo.ist -o TOPletter.gls TOPletter.glo
	makeindex -s gind.ist -o TOPletter.ind TOPletter.idx
	pdflatex TOPletter.dtx
	rm -f $(TEMPS)

class: TOPletter.ins TOPletter.dtx
	pdflatex TOPLetter.ins
	rm -rf $(TEMPS)

examples: EsempioLettera.pdf ExampleLetter.pdf

%.pdf : %.tex
	pdflatex $<
	rm -rf $(TEMPS)

clean:
	rm -f *.cls *.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind
