.REPORT:
	./knitr main.Rtex && latexmk -pdflatex -shell-escape main.tex

.DATA:
	julia gen.jl

DEFAULT: .REPORT
