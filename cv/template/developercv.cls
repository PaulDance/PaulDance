% CLASS CONFIGURATION.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[Developer CV]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass{extarticle}

\newcommand{\lorem}{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.} % Dummy text


% PACKAGES AND OTHER DOCUMENT CONFIGURATIONS.
\setlength{\parindent}{0mm}  % Suppress paragraph indentation.
\usepackage[hidelinks]{hyperref}  % Required for links, boxes hidden.
\pagestyle{empty}  % No headers or footers.
\usepackage{moresize}  % Provides more font size commands (\HUGE and \ssmall).


% PAGE LAYOUT
\usepackage{geometry}  % Required for adjusting page dimensions and margins.
\geometry{
    paper=a4paper,  % Paper size, change to letterpaper for US letter size.
    top=1.75cm,  % Top margin.
    bottom=1.75cm,  % Bottom margin.
    left=2cm,  % Left margin.
    right=2cm,  % Right margin.
    headheight=0.75cm,  % Header height.
    footskip=1cm,  % Space from the bottom margin to the baseline of the footer.
    headsep=0.5cm,  % Space from the top margin to the baseline of the header.
    %showframe,  % Uncomment to show how the type block is set on the page.
}


% FONTS
\usepackage[utf8]{inputenc}  % Required for inputting international characters.
\usepackage[T1]{fontenc}  % Output font encoding for international characters.
\usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
%\usepackage[default]{gillius}
%\usepackage{roboto}
\renewcommand*\familydefault{\sfdefault}  % Force sans-serif.

% Icon command.
\usepackage{fontawesome}

% Command to output an icon in a black square box with text to the right.
% #1: FontAwesome icon name.
% #2: Box size.
% #3: Text.
\newcommand{\icon}[3]{
    \vcenteredhbox{%
        \colorbox{black}{%
            \makebox(#2, #2){%
                \textcolor{white}{%
                    \large\csname fa#1\endcsname  % Icon and box.
                }%
            }%
        }%
    }%
    \hspace{0.2cm}  % Whitespace.
    \vcenteredhbox{\textcolor{black}{#3}}  % Text.
}


% GRAPHICS DEFINITIONS
\usepackage{tikz}  % Required for creating the plots.
\usetikzlibrary{shapes, backgrounds}
\tikzset{x=1cm, y=1cm}  % Default tikz units.

% Command to vertically centre adjacent content.
% #1: Content.
\newcommand{\vcenteredhbox}[1]{%
    \begingroup%
        \setbox0=\hbox{#1}\parbox{\wd0}{\box0}%
    \endgroup%
}


% CHARTS
% Bar chart.
\newcounter{barcount}

% Environment to hold a new bar chart.
% #1: Maximum bar width, in cm.
\newenvironment{barchart}[1]{
    \newcommand{\barwidth}{0.35}
    \newcommand{\barsep}{0.2}

    % Command to add a bar to the bar chart
    % #1: Bar label.
    % #2: Bar width, in % of total width.
    \newcommand{\baritem}[2]{
        \pgfmathparse{##2}
        \let\perc\pgfmathresult

        \pgfmathparse{#1}
        \let\barsize\pgfmathresult

        \pgfmathparse{\barsize*##2/100}
        \let\barone\pgfmathresult

        \pgfmathparse{(\barwidth * \thebarcount) + (\barsep * \thebarcount)}
        \let\barx\pgfmathresult

        \filldraw[fill=black, draw=none]
            (0,-\barx)
            rectangle
            (\barone,-\barx-\barwidth);

        \node [label=180:\colorbox{black}{\textcolor{white}{##1}}]
            at (0,-\barx-0.175) {};
        \addtocounter{barcount}{1}
    }

    \begin{tikzpicture}
        \setcounter{barcount}{0}
        }{
    \end{tikzpicture}
}

% Bubbles.
\newcounter{a}
\newcounter{b}
\newcounter{c}

% Command to output a number of automatically-sized bubbles from a string in
% the format of '<size>/<label>', e.g. \bubbles{5/Eclipse, 6/git, 4/Office,
% 3/Inkscape, 3/Blender}.
\newcommand{\bubbles}[1]{
    \setcounter{a}{0}
    \setcounter{c}{150}

    \begin{tikzpicture}[scale=3]
        \foreach \p/\t in {#1} {
            \addtocounter{a}{1}
            \bubble{\thea/2}{\theb}{\p/25}{\t}{1\p0}
        }
    \end{tikzpicture}
}

% Command to output a bubble at a specific position with a specific size.
\newcommand{\bubble}[5]{
    \filldraw[fill=black, draw=none] (#1, 0.5) circle (#3);  % Bubble
    \node[label=\textcolor{black}{#4}] at (#1, 0.7) {};  % Label
}


% CUSTOM SECTIONS
% Command to output section title headings.
% #1: Section text.
\newcommand{\cvsect}[1]{
    \vspace{\baselineskip}  % Whitespace.
    \colorbox{black}{
        \textcolor{white}{
            \MakeUppercase{\textbf{#1}}  % Section title.
        }
    }\\
}


% ENTRY LIST
\usepackage{longtable}  % Required for tables that span multiple pages.
\setlength{\LTpre}{0pt}  % Remove default whitespace before longtable.
\setlength{\LTpost}{0pt}  % Remove default whitespace after longtable.
\setlength{\tabcolsep}{0pt}  % No spacing between table columns.

% Environment to hold a new list of entries.
\newenvironment{entrylist}{
    \begin{longtable}[H]{l l}
        }{
    \end{longtable}
}

% Command to output an entrylist entry.
% #1: Date text.
% #2: Bold left-aligned entry heading.
% #3: Bold right-aligned entry qualifier.
% #4: Entry content.
\newcommand{\entry}[4]{
    \parbox[t]{0.175\textwidth}{
        #1  % Leftmost entry date(s) text
    }
    &\parbox[t]{0.825\textwidth}{
        \textbf{#2}  % Entry heading text
        \hfill
        { \footnotesize \textbf{\textcolor{black}{#3}} }\\  % Qualifier text.
        #4  % Entry description text
    }\\\\
}


% Command to output a separator slash between lists, e.g. '  /  '
\newcommand{\slashsep}{\hspace{3mm}/\hspace{3mm}}
