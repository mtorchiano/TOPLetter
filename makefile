
default: all

all: docs class examples

EXAMPLES=EsempioLettera.pdf ExampleLetter.tex
TEMPS=*.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind
TS=$(shell date +'%Y%m%d%H%M')
VLINE:=$(shell grep " \[" *.dtx)
VERSION=$(filter v%,$(VLINE))
DEPLOYED=TOPletter.pdf Walt_Disney_1942_signature.pdf *.dtx *.ins *.tex LICENSE README.md
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

%.pdf : %.tex
	pdflatex $<
	rm -rf $(TEMPS)

release: docs examples
	mkdir topletter
	cp $(DEPLOYED) topletter
	zip -r releases/$(RELFILE) topletter
	rm -rf topletter

clean:
	rm -f *.cls *.aux *.log *.glo *.idx *.ilg *.gls *.out *.ind
