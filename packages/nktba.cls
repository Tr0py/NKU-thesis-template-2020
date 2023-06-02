\NeedsTeXFormat{LaTeX2e}[2021/11/15]
\ProvidesClass{nktba}
  [2023/06/02 
    Nankai University bachelor's thesis document class]
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[zihao=-4,linespread=1.64]{ctexart}
%% 字体
\IfFontExistsTF{Times New Roman}{
\setmainfont{Times New Roman}
  \setsansfont{Times New Roman Bold}
}{
  \ClassWarning{nkuthesis}{“Times New Roman”不可用，使用“XITS”替代}
  \setmainfont{XITS}
  \setsansfont{XITS-Bold}
}
%% 页边距
\RequirePackage{geometry}
\geometry{
  paper=a4paper,
  vmargin=2.54cm,
  hmargin=3.17cm,
  headheight=0.4cm,
  headsep=0.64cm,
  footskip=0.79cm,
}
%% 页眉页脚
\RequirePackage{fancyhdr}
\fancypagestyle{chdr}{
  \fancyhf{}
  \fancyhead[C]{\zihao{-5}\leftmark}
  \fancyfoot[C]{\zihao{-5}\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\headruleskip}{1pt}
}
\pagestyle{plain}
%% 页眉字体
\NewCommandCopy\old@markboth{\markboth}
\renewcommand{\markboth}[2]{\old@markboth{\zihao{-5}#1}{\zihao{-5}#2}}
\NewCommandCopy\old@markright{\markright}
\renewcommand{\markright}[1]{\old@markright{\zihao{-5}#1}}
%% 五级编号标题
\RequirePackage{pifont}
\RequirePackage{calc}
\ctexset{
  secnumdepth=subparagraph,
  section = {
    name={,、},
    number=\chinese{section},
    format=\zihao{-3}\sffamily,
  },
  subsection = {
    name={（,）},
    number=\chinese{subsection},
    format=\zihao{4}\sffamily,
  },
  subsubsection = {
    name={,.},
    number=\arabic{subsubsection},
    format=\zihao{-4}\sffamily,
  },
  paragraph = {
    name={(,)},
    number=\arabic{paragraph},
    format=\zihao{-4}\sffamily,
    runin=false,
  },
  subparagraph = {
    number=\ding{\numexpr171+\value{subparagraph}},
    format=\zihao{-4}\sffamily,
    runin=false,
  },
}
\labelformat{section}{第\zhnumber{#1}章}
\renewcommand{\thesubsection}{\arabic{subsection}}
\labelformat{subsection}{第\zhnumber{#1}节}
%% 脚注
\RequirePackage[perpage,bottom]{footmisc}
\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}}}
\NewCommandCopy\old@makefntext{\@makefntext}
\renewcommand{\@makefntext}[1]{\old@makefntext{\enspace{}#1}}
%% 图、表
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{enspace}{\enspace}
\captionsetup{labelsep=enspace,skip=1pt}
\RequirePackage{flafter}
\RequirePackage[section]{placeins}
\labelformat{figure}{图~#1\space}
\labelformat{table}{表~#1\space}
\labelformat{equation}{式~(#1)\space}
%% 超链接、PDF书签、PDF元数据
\RequirePackage[hidelinks,pdfa,pdfusetitle,bookmarksnumbered]{hyperref}
\hypersetup{pdfsubject={南开大学本科生毕业论文（设计）}}
%% 封面信息
\newcommand{\zh@title}{}
\newcommand{\en@title}{}
\newcommand{\@studentid}{}
\newcommand{\@grade}{}
\newcommand{\@major}{}
\newcommand{\@department}{}
\newcommand{\@college}{}
\newcommand{\@adviser}{}
\newcommand{\studentid}[1]{\renewcommand{\@studentid}{#1}}
\newcommand{\grade}[1]{\renewcommand{\@grade}{#1}}
\newcommand{\major}[1]{\renewcommand{\@major}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\adviser}[1]{\renewcommand{\@adviser}{#1}}
\RenewDocumentCommand{\title}{sm}{\IfBooleanTF{#1}
  {\renewcommand{\en@title}{#2}}
  {\renewcommand{\zh@title}{#2}\hypersetup{pdftitle={#2}}}}
%% 伪加粗
\NewDocumentCommand{\textfb}{O{1}m}{%
  \special{pdf:code q 2 Tr #1 w}
  \textnormal{#2}
  \special{pdf:code Q}%
}
%% 封面
\RequirePackage{etoolbox}
\DeclareListParser{\dolinelist}{\\}
\newcommand{\titlestyle}{}
\newcommand{\uline@parbox}[2]{%
  \renewcommand*{\do}[1]{\underbar{\makebox[#1][l]{##1}}\\}
  \begin{tabular}[t]{@{}l@{}}
  \expandafter\dolinelist\expandafter{#2}
  \end{tabular}%
}
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \hbadness=10000
    \centering
      \vspace*{25pt}\par\linespread{1}\fontsize{56}{0}
    \textfb{\makebox[5.5em][s]{南开大学}}\par
      \vspace{35pt}\par\linespread{1}\zihao{2}
    \makebox[255pt][s]{本科生毕业论文（设计）}\par
      \vspace{60pt}\par\linespread{1.2}\zihao{3}
    \begin{tabular}{p{4em}@{：}p{\widthof{
      \begin{tabular}{l}\zh@title\\\en@title\end{tabular}
    }}}
      \makebox[\hsize][s]{中文题目} & \uline@parbox{\hsize}{\zh@title} \\
      \makebox[\hsize][s]{外文题目} & \uline@parbox{\hsize}{\en@title} \\
    \end{tabular}
      \vspace{\fill}\par\linespread{1.15}\zihao{3}
    \begin{tabular}{p{4em}@{：}p{\widthof{
      \begin{tabular}{l}\@studentid\\\@author\\\@grade\\\@major\\
        \@department\\\@college\\\@adviser\\\@date\end{tabular}
    }}}
      \makebox[\hsize][s]{学号} & \uline@parbox{\hsize}{\@studentid}  \\
      \makebox[\hsize][s]{姓名} & \uline@parbox{\hsize}{\@author}  \\
      \makebox[\hsize][s]{年级} & \uline@parbox{\hsize}{\@grade}  \\
      \makebox[\hsize][s]{专业} & \uline@parbox{\hsize}{\@major}  \\
      \makebox[\hsize][s]{系别} & \uline@parbox{\hsize}{\@department}  \\
      \makebox[\hsize][s]{学院} & \uline@parbox{\hsize}{\@college}  \\
      \makebox[\hsize][s]{指导教师} & \uline@parbox{\hsize}{\@adviser}  \\
      \makebox[\hsize][s]{完成日期} & \uline@parbox{\hsize}{\@date}  \\
    \end{tabular}
      \vspace{\fill}
  \end{titlepage}%
}
%% 声明
\NewDocumentCommand{\nolabel@section}{smO{#4}m}{%
  \section*{\phantomsection\centering\sffamily\zihao{#2}#4}
  \markboth{\centering{}#3}{}
  \IfBooleanF{#1}{%
    \addcontentsline{toc}{section}{#3}%
  }%
}
\newcommand{\declaration}{%
  \clearpage
  \nolabel@section*{3}[声明]{关于南开大学本科生毕业论文（设计）的声明}
  本人郑重声明：所呈交的学位论文，是本人在指导教师指导下，进行研究工作所取得的成果。
  除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人创作的、
  已公开发表或没有公开发表的作品内容。对本论文所涉及的研究工作做出贡献的其他
  个人和集体，均已在文中以明确方式标明。本学位论文原创性声明的法律责任由本人承担。
  \par\bigskip\begin{flushright}
    学位论文作者签名：\hspace*{6em}\medskip\par\@date
  \end{flushright}\vspace{4\baselineskip}\par
  本人声明：该学位论文是本人指导学生完成的研究成果，已经审阅过论文的全部内容，
  并能够保证题目、关键词、摘要部分中英文内容的一致性和准确性。
  \par\bigskip\begin{flushright}
    学位论文指导教师签名：\hspace*{6em}\medskip\par
    年\hspace{2em}月\hspace{2em}日
  \end{flushright}
  \clearpage%
}
%% 设置中英关键词
\newcommand{\zh@keywords}{}
\newcommand{\en@keywords}{}
\NewDocumentCommand{\keywords}{sm}{%
  \IfBooleanTF{#1}{%
    \renewcommand{\en@keywords}{#2}%
  }{%
    \renewcommand{\zh@keywords}{#2}%
    \hypersetup{pdfkeywords={#2}}%
  }%
}
%% 中文摘要
\renewenvironment{abstract}{%
  \clearpage
  \nolabel@section{4}[摘要]{摘\hspace{1em}要}
}{%
  \par\bigskip\par
  \noindent\mbox{\textsf{关键词：}}\parbox[t]{\textwidth}{\zh@keywords}
  \clearpage%
}
%% 英文摘要
\newenvironment{abstract*}{%
  \clearpage
  \nolabel@section{4}{Abstract}
}{%
  \par\bigskip\par
  \noindent\textsf{Key Words:\space}\parbox[t]{\textwidth}{\en@keywords}
  \clearpage%
}
\setcounter{tocdepth}{2}
%% 目录
\RequirePackage{titletoc}
\titlecontents{section}[0em]{\zihao{-3}}
  {\thecontentslabel}{}{\titlerule*{$\cdot$}\contentspage}
\titlecontents{subsection}[2em]{\zihao{4}}
  {\thecontentslabel}{}{\titlerule*{$\cdot$}\contentspage}
\renewcommand{\tableofcontents}{%
  \clearpage
  \nolabel@section*{3}[目录]{目\hspace{1em}录}
  \@starttoc{toc}
  \clearpage
}
%% 单附录
\NewCommandCopy{\old@appendix}{\appendix}
\renewcommand{\appendix}{%
  \clearpage
  \old@appendix
  \nolabel@section{4}[附录]{附\hspace{1em}录}%
  \renewcommand{\thesection}{A}%
}
%% 多附录
\RequirePackage{titlesec}
\newcommand{\appendices}{%
  \clearpage
  \old@appendix
  \ctexset{section/name={附录,：}}
  \titleformat{\section}{\centering\zihao{4}\sffamily}
    {附\hspace{1em}录\Alph{section}：}{0em}{}%
}
%% 参考文献
\newenvironment{reference}{
  \clearpage
  \nolabel@section{4}{参考文献}
  \ifdef{\bibfont}{%
    \renewcommand{\bibfont}{\zihao{5}}% 兼容natbib、biblatex
  }{%
    \zihao{5}%
  }
}{%
  \clearpage%
}
%% 致谢
\newenvironment{acknowledgement}{%
  \clearpage
  \nolabel@section{4}[致谢]{致\hspace{1em}谢}
  \newcounter{begin@page}
  \setcounter{begin@page}{\value{page}}
}{%
  \ifnumequal{\thebegin@page}{\thepage}{%
  }{%
    \ClassWarning{nkuthesis}{致谢超过了一页}%
  }%
  \clearpage%
}
