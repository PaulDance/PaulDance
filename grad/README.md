# Grad directory

This is where you will find what is necessary in order to build the PDFs of the
report and the presentation for my graduation internship, made with LaTeX.


## Requirements

The LaTeX document expects a full XeLaTeX installation, with many packages used
such as:

 * url
 * hyperref
 * nameref
 * fancyvrb
 * glossaries
 * adjustbox
 * booktabs
 * longtable
 * tabularx
 * pbox
 * babel
 * moresize
 * xcolor
 * inputenc
 * csquotes
 * graphicx
 * placeins
 * calc
 * geometry
 * biblatex

In particular, some packages rely on external programs in order to deliver
their full functionality: biblatex uses `biber` part of the `biber` system
package  and glossaries `makeglossaries` part of the `texlive-latex-extra`
system package.


## Building

The project uses `latexmk`, so:

 * Build:
   * `latexmk -pdfxe report.tex` for the report.
   * `latexmk -pdfxe presentation.tex` for the presentation.
 * Clean:
   * `latexmk -c report.tex` to remove artifacts of the report.
   * `latexmk -C report.tex` to remove all artifacts, PDF included, of the
     report.
   * `latexmk -C *.tex` to remove all artifacts of all documents.


## Structure

As of writing this, the project has the following structure:

```
grad                    This directory.
├── latexmkrc           LaTeXMk's local configuration file.
├── refs.bib            Bibliography.
├── glossary.tex        Glossary.
├── report.tex          The report.
├── presentation.tex    The presentation.
├── img                 Image directory.
│   └── ...             Various sub-directories.
└── include             Contains parts imported in documents.
    ├── vars.tex        Constants.
    ├── frontpage.tex   Frontpage of the report.
    └── abstract.tex    Abstract of the report.
```
