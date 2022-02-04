% Copyright (c) 1998-2022 by Amado Cabrera 
%                            and 
%                            Mariana Pérez
%
% License missing
%
% Repository: https://github.com/AmadoCab/HomeWorkclass
%
% Notes
% ~~~~~
% The following tags are used:
% HW@   :   the generic tag used through the class
% HWl@  :   the tag used to define labels and its translations
%

\ProvidesClass{HomeWork}[2022/01/15 V2.0 by Amado Cabrera and Mariana Pérez]
\NeedsTeXFormat{LaTeX2e}

\typeout{-- See "HomeWork.pdf" manual for usage information.}
\typeout{-- ctan/url.}

% HomeWork.cls version numbers, provided as of V1.3
% These values serve as a way a .tex file can
% determine if the new features are provided.
% The version number of this HomeWork.cls can be obtained from 
% these values. i.e., V1.4
\def\HWvMajor{2}
\def\HWvMinor{0}

% Class option conditionals
\newif\ifHW@spanish     \HW@spanishfalse % Spanish language
\newif\ifHW@tables      \HW@tablesfalse  % Load xcolor table specs
\newif\ifHW@theorems    \HW@theoremsfalse% To load my theorems
\newif\ifHW@frames      \HW@framesfalse  % Some interesting frames
\newif\ifHW@code        \HW@codefalse    % Syntax highlighting

% Declaring the class options
\DeclareOption{spanish}{\HW@spanishtrue}
\DeclareOption{theorems}{\HW@theoremstrue}
\DeclareOption{frames}{\HW@framestrue}
\DeclareOption{code}{\HW@codetrue\HW@framestrue}
\DeclareOption{tables}{\PassOptionsToPackage{table, xcdraw}{xcolor}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*\relax
\LoadClass{article}

% Loading all packages
\RequirePackage[T1]{fontenc}
\RequirePackage[letterpaper,tmargin=1in, bmargin=1in, rmargin=1in, lmargin=1in]{geometry}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{dsfont}
\RequirePackage{xcolor}
\RequirePackage[shortlabels]{enumitem}

\ifHW@frames
    \usepackage{tcolorbox}
    \tcbuselibrary{skins,breakable,minted}
\fi

\if@twocolumn
    \relax
\else
    \RequirePackage{multicol}
\fi

%% Language configuration %%
% English (defaults)
\def\HWl@theorem{Theorem}
\def\HWl@definition{Definition}
\def\HWl@corollary{Corollary}
\def\HWl@lemma{Lemma}
\def\HWl@institute{}
\def\HWl@author{Name:\space}
\def\HWl@id{Id:\space}
\def\HWl@course{Course:\space}
\def\HWl@professor{Professor:\space}
\def\HWl@prob{Problem}
% Spanish
\ifHW@spanish
\def\HWl@theorem{Teorema}
\def\HWl@definition{Definición}
\def\HWl@corollary{Corolario}
\def\HWl@lemma{Lema}
\def\HWl@institute{}
\def\HWl@author{Nombre:\space}
\def\HWl@id{Carné:\space}
\def\HWl@course{Curso:\space}
\def\HWl@professor{Catedrático:\space}
\def\HWl@prob{Problema}
\fi

%% Auxiliary commands %%
%\HW@undefined

\newcommand{\HW@isUndef}[2]{%
\ifx#1\HW@undefined%
    {}%
\else%
    {#2}%
\fi%
}

\newcommand{\institute}[1]{\gdef\HW@institute{#1}}
\newcommand{\course}[1]{\gdef\HW@course{#1}}
\newcommand{\id}[1]{\gdef\HW@id{#1}}
\newcommand{\professor}[1]{\gdef\HW@professor{#1}}
\newcommand{\email}[1]{\gdef\HW@email{\ttfamily#1}}

%% Article redefinitions %%
% == Maketitles ==
% Classic Maketitle
\let\HW@Tclassic\maketitle

\if@titlepage
% Stylish Maketitle
\newcommand{\HW@Tstylish}{%
    \begin{titlepage}\centering%
    \HW@isUndef{\HW@institute}{\Large\scshape\HW@institute}%
    \null\vfill%
    \begin{minipage}{2\p@}%
    \vrule width 2\p@ height 0.85\textheight\relax%
    \end{minipage}\@killglue\kern 20\p@\relax%
    \begin{minipage}{0.65\textwidth}%
    {\Huge\bfseries\@title}\\[3em]
    {\itshape\Large\@author}\\[1em]
    \HW@isUndef{\HW@id}{{\Large\HW@id}\\[2em]}
    {\large\@date}
    \vskip 0.5\textheight\relax\null
    \HW@isUndef{\HW@course}{{\large\HW@course}\\[1em]}
    \HW@isUndef{\HW@professor}{\large\HW@professor}
    \end{minipage}%
    \kern 22\p@\relax%
    \vfill\null%
    \end{titlepage}%
}
\else
% Stylish Maketitle
\newcommand{\HW@Tstylish}{%
    \ifnum\col@number=\@ne
        \newpage%
        \null%
        \vskip 2em%
        \begin{center}%
        \HW@isUndef{\HW@institute}%
            {\scshape\HWl@institute\HW@institute\par\vskip 5\p@}%
        \hrule%
        \vskip 10\p@%
        {\huge\bfseries\@title\par}%
        \vskip 6\p@%
        \HWl@author{\itshape\@author}\par%
        \vskip 1\p@%
        \HW@isUndef{\HW@id}{\HWl@id\HW@id}%
        \vskip 10\p@%
        \hrule%
        \vskip 5\p@%
        \HW@isUndef{\HW@course}{{\HWl@course}{\itshape\HW@course}}%
        \HW@isUndef{\HW@professor}%
            {\HW@isUndef{\HW@course}{\space--\space}%
            {\HWl@professor{\itshape\HW@professor}}}\par%
        \vskip 5\p@%
        {\@date}%
        \end{center}\par%
        \vskip 1.5em%
    \else
        \twocolumn[\HW@Tstylish]
    \fi
}
% Geometric Maketitle
\newcommand{\HW@Tgeometric}{%
    \ifnum\col@number=\@ne
        \global\@topnum\z@
        \newpage%
        \null%
        \vskip 2em%
        \begin{center}%
        \HW@isUndef{\HW@institute}%
            {\scshape\HWl@institute\HW@institute\par\vskip 10\p@}%
        \setlength{\tabcolsep}{3\p@}%
        \begin{tabular}{l}
            \@author \\
            \HW@isUndef{\HW@id}{\HW@id}
        \end{tabular} \hfill
        \begin{tabular}{r}
            \@date \\
            \HW@isUndef{\HW@email}{\HW@email}
        \end{tabular}\par\vskip 10\p@%
        \fbox{%
        \begin{minipage}{\dimexpr\textwidth-2\fboxsep-2\fboxrule} 
        \centering\huge%
        \vspace*{15\p@}%
        \@title
        \vspace*{10\p@}%
        \end{minipage}%
        }\par\vskip-0.8em%
        {\hspace*{15\p@}%
        \HW@isUndef{\HW@course}{\colorbox{white}{\HW@course}}%
        \HW@isUndef{\HW@professor}{
        \HW@isUndef{\HW@course}{\hfill}%
        \colorbox{white}{\HW@professor}}%
        \hspace*{15\p@}}
        \end{center}\par%
    \else
        \twocolumn[\HW@Tgeometric]
    \fi
}
\fi

% == Maketitle style ==
\let\maketitle\HW@Tstylish\relax

\newcommand{\titlesty}[1]{%
\expandafter\let\expandafter\maketitle\csname HW@T#1\endcsname%
\ifx\maketitle\relax%
    \let\maketitle\HW@Tstylish\relax%
    \ClassWarning{HomeWork}{Perhaps you miss-spell \string\titlesty argument, there is no "#1" style}%
\else%
    \relax%
\fi%
}

%% Extra commands %%
% non starred labline
\newcommand*{\HW@labline}[2][0.4pt]{%
\def\hrulefill{\leavevmode\leaders\hrule height #1\hfill\kern\z@}
\setbox\z@\hbox{#1}\relax%
\begin{center}%
{\hrulefill\raisebox{\dimexpr-0.5\ht\z@+0.5\dp\z@\relax} {\hspace{\fboxsep}{#2}\hspace{\fboxsep}}\hrulefill}\null%
\end{center}%
}%
% starred labline
\newcommand*{\HW@@labline}[3][0.4pt]{%
\def\hrulefill{\leavevmode\leaders\hrule height #1\hfill\kern\z@}
\setbox\z@\hbox{#1}\relax%
\begin{center}%
{\hrulefill\raisebox{#2\relax} {\hspace{\fboxsep}{#3}\hspace{\fboxsep}}\hrulefill}\null%
\end{center}%
}%

\def\labline{\@ifstar\HW@@labline\HW@labline}


%% Math configuration %%
% Amsthm configuration
\newtheoremstyle{HWbreak}
    {}
    {}
    {\slshape}
    {\z@}
    {\bfseries}
    {}
    {\z@}
    {\thmname{#1}\thmnumber{~#2}:\thmnote{ \mdseries#3.}\\[2\p@]}
\newtheoremstyle{HWbreak*}
    {}
    {}
    {\slshape}
    {\z@}
    {\bfseries}
    {}
    {\z@}
    {\ifx\HW@undefined#3\HW@undefined%
        {\thmname{#1}}%
    \else%
        {\thmname{#3}}%
    \fi:\\[2\p@]}
\renewcommand{\qedsymbol}{$\mathcal{Q.E.D.}$}

% Theorems loaded by the theorems option
\ifHW@theorems
\theoremstyle{HWbreak}
\newtheorem{theorem}{\HWl@theorem}
\newtheorem{definition}{\HWl@definition}
\newtheorem{corollary}{\HWl@corollary}
\newtheorem{lemma}{\HWl@lemma}
\theoremstyle{HWbreak*}
\newtheorem*{theorem*}{\HWl@theorem}
\theoremstyle{plain}
\fi

% more math commands
\newlength{\HW@columnEq}
\setlength{\HW@columnEq}{0.25\columnwidth}

\newenvironment{nameEq}[1]{%
\begin{list}{}{%
    \topsep=\abovedisplayskip\relax%
    \partopsep=\z@\relax%
    \parsep=\z@\relax%
    \rightmargin=\z@\relax%
    \leftmargin=\z@\relax%
    \listparindent=\z@\relax%
    \itemsep=\z@\relax%
}
\item\begin{minipage}{\HW@columnEq}\bfseries%
#1%
\end{minipage}%
\hspace{-\HW@columnEq}%
\begin{minipage}{\columnwidth}%
\begin{equation}
}{%
\end{equation}
\end{minipage}%
\end{list}
}

\newenvironment{nameEq*}[1]{%
\begin{minipage}{\HW@columnEq}\bfseries%
#1%
\end{minipage}%
\hspace{-\HW@columnEq}%
\begin{minipage}{\columnwidth}%
\begin{equation*}
}{%
\end{equation*}
\end{minipage}%
}

\newcommand{\Cboxed}[2][red]{%
\fcolorbox{#1}{white}{\m@th$\displaystyle#2$}%
}

% Start code from campa (https://tex.stackexchange.com/a/610299/234538) with a modification by Amado Cabrera.
\newcommand*\CAboxed[2][red]{%
   \let\bgroup{\romannumeral-`}%
   \@CAboxed{#1}#2&&\ENDDNE
}

\def\@CAboxed#1#2&#3&#4\ENDDNE{%
  \ifnum0=`{}\fi \setbox \z@
    \hbox{$\displaystyle#2{}\m@th$\kern\fboxsep \kern\fboxrule}%
    \edef\@tempa {\kern \wd\z@ &\kern -\the\wd\z@ \fboxsep 
        \the\fboxsep \fboxrule\the\fboxrule }\@tempa \Cboxed[#1] {#2#3}%
}
% End code from campa

\DeclareMathOperator{\arccosh}{arccosh}
\DeclareMathOperator{\arcsinh}{arcsinh}

\newcommand{\dif}{\,\mathrm{d}}

\newcommand{\pdif}{\,\partial}

\def\td{\@ifstar\HW@tdI\HW@tdD}

\newcommand{\HW@tdD}[3][]{%
    \frac{\mathrm{d}^{#1}#2}{\mathrm{d}#3^{#1}}%
}

\newcommand{\HW@tdI}[3][]{%
    \mathrm{d}^{#1}#2/\mathrm{d}#3^{#1}%
}

\def\pd{\@ifstar\HW@pdI\HW@pdD}

\newcommand{\HW@pdD}[3][]{%
    \frac{\partial^{#1}#2}{\partial\HW@pdDenominator#3,\HW@delim}%
}

\newcommand{\HW@pdI}[3][]{%
    \partial^{#1}#2/\partial\HW@pdDenominator#3,\HW@delim %
}

\def\HW@pdDenominator#1,#2\HW@delim{%
    \ifx\HW@undefined#2\HW@undefined%
        {#1}%
    \else%
        {#1\,\partial\HW@pdDenominator#2\HW@delim}%
    \fi%
}

%% Lists configuration %%
\newcommand{\staritem}{\global\HWstartrue\item}
\newcommand{\perhapsstar}{%
  \ifHWstar\raisebox{0.75\p@}{$\star$}\global\HWstarfalse\fi
}
\newif\ifHWstar

% Enumerate
\setlist[enumerate,1]{label={\protect\perhapsstar\,\arabic*.}}
\setlist[enumerate,2]{label={\protect\perhapsstar\,\alph*)}}
\setlist[enumerate,3]{label={\protect\perhapsstar\,\roman*.}}
\setlist[enumerate,4]{label={\protect\perhapsstar\,\arabic*)}}

% Itemize
\def\HWbulletSq{\leavevmode\hbox to 1.2ex{\hss\vrule height .9ex width .7ex depth -.2ex\hss}}
\setlist[itemize,1]{label={\HWbulletSq}}
\setlist[itemize,2]{label={$\diamond$}}
\setlist[itemize,3]{label={\textbullet}}
\setlist[itemize,4]{label={$\m@th\circ$}}


% Description
\setlist[description,1]{font={}}
\setlist[description,2]{font={}}
\setlist[description,3]{font={}}
\setlist[description,4]{font={}}

%% Adjust width %%
\newenvironment{adjustwidth}[2]{%
    \begin{list}{}{%
    \topsep\z@%
    \listparindent\parindent%
    \parsep\parskip%
    \ifx\HW@undefined#1\HW@undefined%
        \setlength{\leftmargin}{\z@}%
    \else%
        \setlength{\leftmargin}{#1}%
    \fi%
    \ifx\HW@undefined#2\HW@undefined%
        \setlength{\rightmargin}{\z@}%
    \else%
        \setlength{\rightmargin}{#2}%
    \fi%
    }
    \item[]}%
    {\end{list}}
    
%% Commands for Homework assignments %%
% Answer environment
% Marianita's version <----------------------------------------
\newenvironment{ans}{%
    \begin{adjustwidth}{1.5em}{1.5em}}%
    {\end{adjustwidth}}

%% Boxes environments %%
\newcounter{HWprob}
\def\HWlprob{\arabic{HWprob}}

\ifHW@frames
% Problems environment
\tcbset{HWprob/.style={
    breakable,
    enhanced,
    frame hidden,
    fonttitle={\large\hspace{-7\p@}},
    left=7\p@,
    right=7\p@,
    bottomtitle=3\p@,
    sharp corners,
    colback={sky!6},
    coltitle={sky}
    }
}

\newtcolorbox[
    use counter*=HWprob,
    number format=\arabic
]{prob}[1][Problema~\thetcbcounter]{
    HWprob,
    title={#1},
}
\newtcolorbox{prob*}[1][]{
    HWprob,
    title={#1},
}
\newenvironment{listprob}{%
    \begin{enumerate}}%
    {\end{enumerate}}

\tcolorboxenvironment{listprob}{
    HWprob,
    title={\stepcounter{HWprob}Problema~\theHWprob},
}

% info environment
\newtcolorbox{info}[1][]{
    breakable,
    enhanced,
    coltitle=black,
    colback=white,
    top=-2\p@,
    bottom=\z@,
    fonttitle={\bfseries},
    detach title,
    frame hidden,
    before skip=1em,
    after skip=1em,
    title={Information},
    before upper={\tcbtitle\textbf{:}\space},
    overlay unbroken and first={
        \draw[line width=1.2\p@] (frame.north west) -- (frame.south west);
        \draw[line width=1.2\p@,white,fill=black] (frame.north west) circle[radius=1.3ex] node[white,scale=0.85]{\textbf{i}};
    },
    overlay middle and last={
        \draw[line width=1.2\p@] (frame.north west) -- (frame.south west);
    },
    #1
}
% warn environment
\newtcolorbox{warn}[1][]{
    breakable,
    enhanced,
    coltitle=black,
    colback=white,
    top=-2\p@,
    bottom=\z@,
    fonttitle={\bfseries},
    detach title,
    frame hidden,
    before skip=1em,
    after skip=1em,
    title={Warning},
    before upper={\tcbtitle\textbf{:}\space},
    overlay unbroken and first={
        \draw[line width=1.2\p@] (frame.north west) -- (frame.south west);
        \draw[line width=1.2\p@,white,fill=black,rotate=45] ([yshift=-1.1ex,xshift=-1.1ex]frame.north west) rectangle ([yshift=1.1ex,xshift=1.1ex]frame.north west);
        \node at (frame.north west)[white,scale=0.85]{\textbf{!}};
    },
    overlay middle and last={
        \draw[line width=1.2\p@] (frame.north west) -- (frame.south west);
    },
    #1
}
\else
% Problems environment
\newenvironment{prob}[1][\HWl@prob~\HWlprob]{%
    \stepcounter{HWprob}
    \section*{#1}
    \begin{trivlist}\item}%
    {\end{trivlist}}%
\fi

%% Code environments %%
\ifHW@code
% Command line box
\tcbset{HWcommandline/.style={
    arc=\z@,
    colback=black!5!white,
    colframe=black!50!white,
    fonttitle={\normalfont\sffamily\hspace{5\p@}},
    title={Command Line},
    left skip=10\p@,
    right skip=10\p@,
    toptitle=2\p@,
    bottomtitle=2\p@,
    left=5\p@,
    breakable
    }
}
\newtcblisting{commandline}[1][]{
    HWcommandline,
    listing only,
    listing engine=minted,
    minted language=text,
    minted options={
        breaklines,
        breakanywhere,
        #1,
    },
}
\newtcbinputlisting{\commandlineF}[2][]{
    HWcommandline,
    listing only,
    listing engine=minted,
    minted language=text,
    listing file={#2},
    minted options={
        breaklines,
        breakanywhere,
        #1,
    },
}

% File box
\newcommand{\window}{%
\tikz{
    \fill[black!10!white] (-0.5ex,-0.3em) rectangle (3.5ex,0.3em);
    \draw[red!90!black,fill=red] (0,0) circle[radius=0.5ex];
    \draw[yellow!80!black,fill=yellow!90!black] (1.5ex,0) circle[radius=0.5ex];
    \draw[green!70!black,fill=green!80!black] (3ex,0) circle[radius=0.5ex];}%
}
\tcbset{HWfile/.style={
    fonttitle={\ttfamily\color{black}\hspace{-3\p@}\window\hspace{8\p@}},
    bottomtitle=\z@,
    breakable,
    enhanced,
    sharp corners,
    boxrule=0.6\p@,
    bottomrule=-1\p@,
    rightrule=-1\p@,
    colframe=black,
    colback=white,
    colbacktitle=black!10!white,
    left=10\p@,
    right=10\p@,
    rounded corners=northwest,
    top=0.35cm,
    bottom=0.35cm,
    left skip=10\p@,
    right skip=10\p@,
    overlay first and middle={
        \draw[line width=0.6\p@] (frame.north east) -- (frame.south east);
    },
    overlay unbroken and last={
        \draw[line width=0.6\p@] (frame.south east) ++(0,1cm) -- ++(-1cm,0) -- ++(0,-1cm);
        \draw[line width=0.6\p@] (frame.south east) ++(0,1cm) -- ++(-1cm,-1cm);
        \draw[line width=0.6\p@] (frame.south east) ++(0,1cm) -- (frame.north east);
        \draw[line width=0.6\p@] (frame.south east) ++(-1cm,0) -- (frame.south west);
    },
    }
}
\newtcblisting{file}[2][File]{
    HWfile,
    title={#1},
    listing only,
    listing engine=minted,
    minted language={#2},
    minted options={
        linenos,
        numbersep=4\p@,
        breaklines,
        breakanywhere,
    },
}
\newtcblisting{file*}[2][]{
    HWfile,
    listing only,
    listing engine=minted,
    minted language={#2},
    minted options={
        linenos,
        numbersep=4\p@,
        breaklines,
        breakanywhere,
    },
    #1,
}
\newtcbinputlisting{\fileF}[3][]{
    HWfile,
    title={#3},
    listing only,
    listing engine=minted,
    minted language={#2},
    listing file={#3},
    minted options={
        linenos,
        numbersep=4\p@,
        breaklines,
        breakanywhere,
        #1
    },
}
\fi

\endinput

%% TO DO LIST %%
% Ponerle color a las cajas de color matemáticas
% Ponerle color a los labels de nameEq
% Tal vez a los títulos de los teoremas
% Color para las listas
