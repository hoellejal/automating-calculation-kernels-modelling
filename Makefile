include LaTeX.mk

LU_FLAVORS=LUALATEX
LUALATEX_OPTIONS=-shell-escape

all:
	export PYTHONIOENCODING=utf-8
	make bayesian_statistics_introduction.tex
	make bayesian_statistics_introduction.pdf
#	make fix_figures
#	make bayesian_statistics_introduction.pdf

%.tex: %.org
	emacs -batch --eval "(setq enable-local-eval t)" --eval "(setq enable-local-variables t)" $<  --funcall org-beamer-export-to-latex
	mv $@ $@.bak
	echo '\\def\\raggedright{}' > $@
	cat $@.bak >> $@
	rm $@.bak
	sed -i -e 's/usepackage{graphicx}/usepackage{figlatex}/' -e 's/\\usepackage{grffile}//' $@


include LaTeX.mk

clean::
	$(RM) $(BIB_SLAVES) *.tex *.vrb

