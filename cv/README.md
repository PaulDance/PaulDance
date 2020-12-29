# CV directory

This is where you will find what is necessary in order to build the PDF for my
*Curiculum Vitæ*, made with LaTeX.


## Requirements

The LaTeX document expects a full XeLaTeX installation, with many packages used
such as:

 * hyperref
 * moresize
 * ifthen
 * babel
 * multilang
 * geometry
 * inputenc
 * fontenc
 * raleway
 * fontawesome
 * graphicx
 * tikz
 * longtable
 * fancybox


## Building

The project uses `latexmk`, so:

 * Build:
   * `latexmk -pdfxe lang/en` for the english version.
   * `latexmk -pdfxe lang/*` for all versions.
 * Clean:
   * `latexmk -c lang/en` to remove artifacts of the english version.
   * `latexmk -C lang/en` to remove all artifacts, PDF included, of the
     english version.
   * `latexmk -C lang/*` to remove all artifacts of all versions.


## Structure

As of writing this, the project has the following structure:

```
cv                      This directory.
├── main.tex            Most of the document.
├── template            Template home.
│   └── dev-cv.cls      Base class.
├── common              Elements not requiring translation.
│   ├── contact.tex     Contact information.
│   └── skills.tex      Skills horizontal bar chart.
└── lang                Bindings for splitting targets by langage.
    ├── en.tex          English.
    └── fr.tex          French.
```


### Copyrights

This project is originally based on the [`developpercv`
template](https://www.latextemplates.com/template/developer-cv) by Jan Vorisek,
itself adapted from [Jan Küster's work](https://github.com/jankapunkt/latexcv).
