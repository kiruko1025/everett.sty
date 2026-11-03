.PHONY: book book-light book-dark book-modes sync-template check-template clean

# Root styles are canonical; refresh the portable copies before building.
sync-template:
	cp everett.sty macro.sty book-template/

check-template:
	cmp everett.sty book-template/everett.sty
	cmp macro.sty book-template/macro.sty

book: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build main.tex

book-light: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/light main-light.tex

book-dark: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/dark main-dark.tex

book-modes: book-light book-dark

clean:
	cd book-template && latexmk -c -outdir=build main.tex
	cd book-template && latexmk -c -outdir=build/light main-light.tex
	cd book-template && latexmk -c -outdir=build/dark main-dark.tex
