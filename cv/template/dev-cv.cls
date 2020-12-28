% CLASS CONFIGURATION.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dev-cv}[Developer CV]
\DeclareOption{english}{\def\LANG{english}}
\DeclareOption{french}{\def\LANG{french}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass{extarticle}


% PACKAGES AND OTHER DOCUMENT CONFIGURATIONS.
\setlength{\parindent}{0mm}  % Suppress paragraph indentation.
\usepackage[hidelinks]{hyperref}  % Required for links, boxes hidden.
\pagestyle{empty}  % No headers or footers.
\usepackage{moresize}  % Provides more font size commands (\HUGE and \ssmall).
\usepackage{ifthen}  % Tests.
\usepackage[\LANG]{babel}
\usepackage[languages={french, english}]{multilang}

\newcommand{\self}[1]{ #1 }
\NewMultilangCmd{\Text}{
    command=\self,
    margs={t},
}


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
\usepackage{graphicx}

% Command to output an icon in a black square box with text to the right.
% #1: FontAwesome icon name.
% #2: Box size.
% #3: Text.
\newcommand{\icon}[3]{
    \pgfmathparse{0.8 * #2}
    \vcenteredhbox{%
        \colorbox{black}{%
            \makebox(#2, #2){%
                \resizebox{\pgfmathresult pt}{!}{%
                    \textcolor{white}{%
                        \csname fa#1\endcsname  % Icon and box.
                    }%
                }%
            }%
        }%
    }%
    \ifthenelse
        {\equal{#3}{}}
        {}
        {
            \hspace{0.2cm}  % Whitespace.
            \vcenteredhbox{\textcolor{black}{#3}}  % Text.
        }
}

\NewMultilangCmd{\Icon}{
    command=\icon,
    margs={name, size, text},
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

        \pgfmathparse{\barsize * ##2 / 100}
        \let\barone\pgfmathresult

        \pgfmathparse{(\barwidth * \thebarcount) + (\barsep * \thebarcount)}
        \let\barx\pgfmathresult

        \filldraw[fill=black, draw=none]
            (0,-\barx)
            rectangle
            (\barone,-\barx-\barwidth);

        \node [label=180:\colorbox{black}{\textcolor{white}{##1}}]
            at (0, -\barx - 0.175) {};
        \addtocounter{barcount}{1}
    }

    \NewMultilangCmd{\BarItem}{
        command=\baritem,
        margs={label, width},
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
% #1: Section title.
\newcommand{\cvsect}[1]{
    \vspace{\baselineskip}  % Whitespace.
    \colorbox{black}{
        \textcolor{white}{
            \MakeUppercase{\textbf{#1}}  % Section title.
        }
    }\\
}

\NewMultilangCmd{\CvSect}{
    command=\cvsect,
    margs={title},
}


% ENTRY LIST
\usepackage{longtable}  % Required for tables that span multiple pages.
\setlength{\LTpre}{0pt}  % Remove default whitespace before longtable.
\setlength{\LTpost}{0pt}  % Remove default whitespace after longtable.
\setlength{\tabcolsep}{2pt}  % Small spacing between table columns.

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
% #4: URL.
% #5: Tech stack list.
% #6: Entry content.
\newcounter{idx}
\newcommand{\entry}[6]{
    \setcounter{idx}{0}
    \begin{minipage}[t]{0.175\textwidth}
        #1\\  % Leftmost entry date(s) text.
        \raggedright
        \foreach \x in {#5} {  % Tech stack list.
            \ifthenelse
                {\theidx = 0}
                {}
                {\slashsep}
            \texttt{\x}
            \addtocounter{idx}{1}
        }
    \end{minipage}
    &\begin{minipage}[t]{0.825\textwidth}
        \textbf{#2}  % Entry heading text.
        \hfill
        \href{#4}{
            { \footnotesize \textbf{\textcolor{black}{#3}} }  % Qualifier text.
            \ifthenelse
                {\equal{#4}{}}
                {}
                {
                    \icon{ExternalLink}{8}{}
                    \vspace{2pt}
                }
        }\\
        #6  % Entry description text.
    \end{minipage}\\\\
}

\NewMultilangCmd{\Entry}{
    command=\entry,
    margs={date, head, qual, url, tech, text},
}

% Command to add a form of itemized list to an entry's description.
% #1: Comma-seprated list of item texts.
\newcommand{\entryitems}[1]{
    \foreach \str in {#1} {
        \begin{tikzpicture}[baseline=-0.75ex]
            \filldraw[
                draw=black,
                fill=none,
                line width=1.2pt
            ] (0, 0) circle (0.07);
        \end{tikzpicture}
        \str\\
    }
}

\NewMultilangCmd{\EntryItems}{
    command=\entryitems,
    margs={items},
}

% Command to output a separator slash between lists, e.g. '  /  '.
\newcommand{\slashsep}{/\hspace{0.4mm}}


% Interests
\usepackage{fancybox}

% #1: Comma-seperated list of hobbies.
\newcommand{\boxlist}[1]{
    \foreach \str in {#1} {
        \shadowbox{\str}
    }
}

\NewMultilangCmd{\BoxList}{
    command=\boxlist,
    margs={list},
}
