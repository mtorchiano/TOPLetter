# Makefile for the TOPLetter LaTeX class

default: all

all:examples docs class 

EXAMPLES=EsempioLettera.pdf ExampleLetter.pdf
TEMPS=*.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind
TS=$(shell date +'%Y%m%d%H%M')
VLINE:=$(shell grep " \[" *.dtx)
VERSION=$(filter v%,$(VLINE))
DEPLOYED=*.dtx *.ins *.pdf *.tex LICENSE README.md
RELFILE=TOPletter_$(VERSION)_$(TS).zip

docs: TOPletter.dtx
	pdflatex '\UseRawInputEncoding \input{TOPletter.dtx}'
#	pdflatex TOPletter.dtx
	makeindex -s gglo.ist -o TOPletter.gls TOPletter.glo
	makeindex -s gind.ist -o TOPletter.ind TOPletter.idx
	pdflatex TOPletter.dtx
	rm -f $(TEMPS)

class: TOPletter.ins TOPletter.dtx
	pdflatex TOPLetter.ins
	rm -rf $(TEMPS)

examples: EsempioLettera.pdf ExampleLetter.pdf

EsempioLettera.tex: class
ExampleLetter.tex: class

%.pdf : %.tex
	pdflatex $<
	rm -rf $(TEMPS)

release: docs examples
	mkdir topletter
	cp $(DEPLOYED) topletter
	zip -r releases/$(RELFILE) topletter
	rm -rf topletter

clean:
	rm -f *.cls *.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind *.tex $(EXAMPLES)
