% origin khandout class file Designed by Liam Huang (http://liam0205.me)
% dhandout Designed by ddswhu (http://ddswhu.com)
% Copyright by ElegantLaTeX (http://elegantlatex.org)
% Last modification: 2014-10-17 00:11:01

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dhandout}[2014/10/17 Presentation Handout Class]
% ----- Options -----
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family = elegant, prefix = elegant@}

\DeclareBoolOption[true]{colorx}
\DeclareComplementaryOption{nocolorx}{colorx}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax
\LoadClass[10pt,twoside]{article}

% ----- Loading Packages -----
\RequirePackage{titlesec}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\RequirePackage{calc}
\RequirePackage{lipsum}
\RequirePackage{enumitem}
\RequirePackage{longtable}
\RequirePackage{tabu}
\RequirePackage{makecell}

% ----- Section Style -----
\ifelegant@colorx
  \definecolor{dblue}{RGB}{2,131,239}
  \definecolor{dred}{RGB}{228,0,0}
\else
  \definecolor{dblue}{RGB}{158,158,158}
  \definecolor{dred}{RGB}{158,158,158}
\fi



\colorlet{scolor}{white}
\colorlet{stcolor}{dblue}
\colorlet{slcolor}{dblue}
\colorlet{sltcolor}{white}
\colorlet{subscolor}{white}
\colorlet{substcolor}{orange}
\colorlet{subslcolor}{orange}
\colorlet{subsltcolor}{white}

% \section
\newcommand{\mytitle}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.06\textwidth}p{0.94\textwidth}}
\cellcolor{slcolor}\hfil\textcolor{sltcolor}\thesection\hfil &\cellcolor{scolor} \rule{0pt}{1.1em}\textcolor{stcolor}
{\hspace{.7em}\bfseries\LARGE  #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{\section}[hang]{\bfseries\LARGE}
{}{0mm}{\hspace{-0.4cm}\mytitle}

% \section*
\newcommand{\mytitlestared}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.06\textwidth}p{0.94\textwidth}}
\cellcolor{slcolor} \hfil\textcolor{sltcolor}\graysquare\hfil &\cellcolor{scolor} \rule{0pt}{1.1em}\textcolor{stcolor}
{\hspace{.7em}\bfseries\LARGE  #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{name = \section, numberless}[hang]{\bfseries\LARGE}
{}{0mm}{\hspace{-0.4cm}\mytitlestared}

% \subsection
\newcommand{\mysubsection}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.06\textwidth}p{0.94\textwidth}}
\cellcolor{subslcolor}\hfil\textcolor{subsltcolor}\thesubsection\hfil &  \rule{0pt}{1.1em}\textcolor{substcolor}{\hspace{.7em}\bfseries \Large #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{\subsection}[hang]{\bfseries\Large}
{}{0mm}{\hspace{-0.4cm}\mysubsection}

% \subsection*
\newcommand{\mysubsectionstared}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.06\textwidth}p{0.94\textwidth}}
\cellcolor{subslcolor}\hfil\textcolor{subsltcolor}\graysquare\hfil &  \rule{0pt}{1.1em}\textcolor{substcolor}{\hspace{.7em}\bfseries \Large #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{name = \subsection, numberless}[hang]{\bfseries\Large}
{}{0mm}{\hspace{-0.4cm}\mysubsectionstared}


\RequirePackage{geometry}
\geometry{
      a4paper,
      left=27mm,  %% or inner=23mm
      right=27mm, %% or outer=18mm
      top=25.4mm, bottom=25.4mm,
      headheight=2.17cm,
      headsep=4mm,
      footskip=12mm
}

% ----- Page Style -----
\newcommand\graysquare{\textcolor{sltcolor}{\rule[2px]{1ex}{1ex}}}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\fancyhf{}
\rhead{\color{slcolor}\itshape\rightmark}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[c]{\color{slcolor}--\thepage--}
\renewcommand{\headrule}{\color{slcolor}\hrule width\textwidth}
\pagestyle{fancy}
