.PHONY: book book-light book-dark book-modes handout handout-light handout-dark handout-modes sync-template check-template clean

# Root styles are canonical; refresh the portable copies before building.
sync-template:
	cp everett.sty macro.sty book-template/
	cp everett.sty macro.sty handout-template/

check-template:
	cmp everett.sty book-template/everett.sty
	cmp macro.sty book-template/macro.sty
	cmp everett.sty handout-template/everett.sty
	cmp macro.sty handout-template/macro.sty

book: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build main.tex

book-light: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/light main-light.tex

book-dark: sync-template
	cd book-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/dark main-dark.tex

book-modes: book-light book-dark

handout: sync-template
	cd handout-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build main.tex

handout-light: sync-template
	cd handout-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/light main-light.tex

handout-dark: sync-template
	cd handout-template && latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/dark main-dark.tex

handout-modes: handout-light handout-dark

clean:
	cd book-template && latexmk -c -outdir=build main.tex
	cd book-template && latexmk -c -outdir=build/light main-light.tex
	cd book-template && latexmk -c -outdir=build/dark main-dark.tex
	cd handout-template && latexmk -c -outdir=build main.tex
	cd handout-template && latexmk -c -outdir=build/light main-light.tex
	cd handout-template && latexmk -c -outdir=build/dark main-dark.tex
