% handout class file
% Desgined by Liam Huang, for Kejin(Rebecca) Zhu
% 2014-10-07 15:22:03

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{khandout}[2014/10/07 Presentation Handout Class]
% ----- Options -----
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family = kejin, prefix = kejin@}

\DeclareBoolOption[true]{colored}
\DeclareComplementaryOption{nocolored}{colored}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax
\LoadClass[10pt]{article}

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
\ifkejin@colored
  \definecolor{sectcolor}{rgb}{0.50,0.50,0.73}
  \colorlet{secttextcolor}{white}
  \colorlet{leadcolor}{black}
  \colorlet{subsectcolor}{sectcolor}
\else
  \colorlet{sectcolor}{white}
  \colorlet{secttextcolor}{black}
  \colorlet{leadcolor}{gray}
  \colorlet{subsectcolor}{leadcolor}
\fi
% \section
\newcommand{\mytitle}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.03\textwidth}p{0.97\textwidth}}
\cellcolor{leadcolor} &\cellcolor{sectcolor} \rule{0pt}{1.1em}\textcolor{secttextcolor}
{\hspace{.7em}\bfseries\LARGE \thesection ~ #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{\section}[hang]{\bfseries\LARGE\sffamily}
{}{0mm}{\hspace{-0.4cm}\mytitle}
% \section*
\newcommand{\mytitlestared}[1]{
\setlength{\tabcolsep}{0pt}
\begin{tabular}{p{0.03\textwidth}p{0.97\textwidth}}
\cellcolor{leadcolor} &\cellcolor{sectcolor} \rule{0pt}{1.1em}\textcolor{secttextcolor}
{\hspace{.7em}\bfseries\LARGE #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{name = \section, numberless}[hang]{\bfseries\LARGE\sffamily}
{}{0mm}{\hspace{-0.4cm}\mytitlestared}
% \subsection
\newcommand{\mysubsection}[1]{
\setlength{\tabcolsep}{0pt}
\setlength\arrayrulewidth{1pt}\arrayrulecolor{sectcolor}
\begin{tabular}{p{0.03\textwidth}p{0.97\textwidth}}
\hline
\cellcolor{subsectcolor} &  \rule{0pt}{1.1em}\textcolor{black}{\hspace{.7em}\bfseries \Large \thesubsection ~ #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{\subsection}[hang]{\bfseries\Large\sffamily}
{}{0mm}{\hspace{-0.5cm}\mysubsection}
% \subsection
\newcommand{\mysubsectionstared}[1]{
\setlength{\tabcolsep}{0pt}
\setlength\arrayrulewidth{1pt}\arrayrulecolor{sectcolor}
\begin{tabular}{p{0.03\textwidth}p{0.97\textwidth}}
\hline
\cellcolor{subsectcolor} &  \rule{0pt}{1.1em}\textcolor{black}{\hspace{.7em}\bfseries \Large #1}
\end{tabular}
\arrayrulewidth=0.4pt
}
\titleformat{name = \subsection, numberless}[hang]{\bfseries\Large\sffamily}
{}{0mm}{\hspace{-0.5cm}\mysubsectionstared}
% Spacing
\titlespacing*{\section}
  {0pc}{1.5ex plus .10ex minus .2ex}{-3.5ex}
\titlespacing*{name = \section, numberless}
  {0pc}{1.5ex plus .10ex minus .2ex}{-3.5ex}
\titlespacing*{\subsection}
  {0pc}{1.5ex plus .08ex minus .1ex}{-3.5ex}
\titlespacing*{name = \subsection, numberless}
  {0pc}{1.5ex plus .08ex minus .1ex}{-3.5ex}

% ----- Geometry -----
\geometry{letterpaper, scale = 0.765}

% ----- Page Style -----
\newcommand\graysquare{\textcolor{sectcolor}{\rule{1ex}{1ex}}}
\newcommand{\helv}{\fontfamily{phv}\fontseries{}\fontsize{10}{12}\selectfont}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\fancyhf{}
\rhead{\helv\rightmark\hspace{1.5em}\graysquare\hspace{.5em}\thepage}
\renewcommand{\headrulewidth}{0pt}
