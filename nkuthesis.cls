% brief:	基本实现2022年11月版《南开大学本科毕业论文（设计）指导手册》的格式要求

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nkuthesis}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[zihao=-4,linespread=1.64,fontset=none]{ctexart}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                               Basic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 字体
% Times New Roman
\setmainfont[
	BoldFont=timesbd.ttf,
	ItalicFont=timesi.ttf,
	BoldItalicFont=timesbi.ttf,
	Path=fonts/
]{times.ttf}
\setsansfont[
	ItalicFont=timesbi.ttf,
	Path=fonts/
]{timesbd.ttf}
\setCJKmainfont[BoldFont=simhei.ttf,ItalicFont=simkai.ttf,Path=fonts/]{simsun.ttf}
\setCJKsansfont[Path=fonts/]{simhei.ttf}
\setCJKmonofont[Path=fonts/]{simfang.ttf}
\setCJKfamilyfont{fb@song}{simsun.ttf}[AutoFakeBold=1,Path=fonts/]


% 页面设置
\pagestyle{plain} % 兼容fancyhdr
\RequirePackage[paper=a4paper,vmargin=2.54cm,hmargin=3.17cm,
	headheight=0.75cm,headsep=0.29cm,footskip=0.79cm]{geometry}

% 标题
\RequirePackage{titlesec}
\RequirePackage{pifont}
\RequirePackage{calc}
\setcounter{secnumdepth}{5}
\newcommand{\sectionbreak}{\newpage\vspace*{0pt}}
\titleformat{\section}{\centering\zihao{-3}\sffamily}{\chinese{section}、}{0em}{}
\titleformat{\subsection}{\centering\zihao{4}\sffamily}{（\chinese{subsection}）}{0em}{}
\titleformat{\subsubsection}{\zihao{-4}\sffamily}{\arabic{subsubsection}.}{0.5em}{}
\titleformat{\paragraph}{\zihao{-4}\sffamily}{(\arabic{paragraph})}{0.5em}{}
\titleformat{\subparagraph}{\zihao{-4}\sffamily}{\ding{\numexpr171+\value{subparagraph}}}{0.5em}{}

% 注释
\RequirePackage[perpage,bottom]{footmisc}
\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}}} % 仅 1-10 有效
\RequirePackage{etoolbox}
\patchcmd\@makefntext{{\hss\@makefnmark}}
	{{\hss\hbox{\normalfont\zihao{-5}\@thefnmark}}\enspace}{}{\fail}

% 图、表
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{enspace}{\enspace}
\captionsetup{labelsep=enspace,skip=1pt}
\RequirePackage{flafter} % 浮动体置于引用后，包含h选项后似乎不生效
\RequirePackage[section]{placeins} % 浮动体不跨节

% 超链接、PDF书签属性（教务处格式未要求）
\RequirePackage[hidelinks,pdfa,pdfusetitle,bookmarksnumbered]{hyperref}
\hypersetup{pdfsubject={南开大学本科生毕业论文（设计）}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                      Command & Envirenment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 文档信息：模仿\title \author \date 的使用
\newcommand{\zh@title}{}
\newcommand{\en@title}{}
\newcommand{\@studentid}{}
\newcommand{\@grade}{}
\newcommand{\@major}{}
\newcommand{\@department}{}
\newcommand{\@college}{}
\newcommand{\@adviser}{}
\newcommand{\zh@keywords}{}
\newcommand{\en@keywords}{}
\newcommand{\studentid}[1]{\renewcommand{\@studentid}{#1}}
\newcommand{\grade}[1]{\renewcommand{\@grade}{#1}}
\newcommand{\major}[1]{\renewcommand{\@major}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\adviser}[1]{\renewcommand{\@adviser}{#1}}
\NewDocumentCommand{\keywords}{sm}{\IfBooleanTF{#1}
	{\renewcommand{\en@keywords}{#2}}
	{\renewcommand{\zh@keywords}{#2}\hypersetup{pdfkeywords={#2}}}}
\RenewDocumentCommand{\title}{sm}{\IfBooleanTF{#1}
	{\renewcommand{\en@title}{#2}}
	{\renewcommand{\zh@title}{#2}\hypersetup{pdftitle={#2}}}}

% 封面
\newlength\topulineparbox@totalheight
\newcommand\ul@t@parbox[2]{{%
	\hbadness=10000 % 禁用此处 "underfull hbox" 提示
	\settototalheight\topulineparbox@totalheight{\parbox[t]{#1}{#2}}%
	\rlap{\smash{\parbox[t]{#1}{%
		\unlessboolexpr{test {\ifdimless{\topulineparbox@totalheight}{0pt}}}{%
			\underline{\hspace{#1}}\\%
			\addtolength\topulineparbox@totalheight{-\baselineskip}%
		}%
	}}}%
	\parbox[t]{#1}{#2}
	\settototalheight\topulineparbox@totalheight{\parbox[t]{#1}{#2}}%
	\ifdimless{\topulineparbox@totalheight}{25pt}{}{\vspace{0.7ex}}
}}
\newlength\@titlewidth
\newlength\@authorwidth
\renewcommand{\maketitle}{
	\begin{titlepage}
		\centering
			\vspace*{25pt}\par\linespread{1}\fontsize{56}{0}
		\textbf{\CJKfamily{fb@song}\makebox[5.5em][s]{南开大学}}\par
			\vspace{35pt}\par\linespread{1}\zihao{2}
		\makebox[255pt][s]{本科生毕业论文（设计）}\par
			\vspace{60pt}\par\linespread{1.2}\zihao{3}
			\settowidth{\@titlewidth}{\begin{tabular}{c}\zh@title\\\en@title\end{tabular}}
		\begin{tabular}{l@{：}l}
			中文题目 & \ul@t@parbox{\@titlewidth}{\centering\zh@title} \\
			外文题目 & \ul@t@parbox{\@titlewidth}{\centering\en@title} \\
		\end{tabular}
			\vspace{\fill}\par\linespread{1.15}\zihao{3}
			\settowidth{\@authorwidth}{
				\begin{tabular}{c}
					\@studentid\\\@author\\\@grade\\\@major\\\@department\\\@college\\\@adviser\\\@date
				\end{tabular}
			}
		\begin{tabular}{l@{：}l}
			学\hspace{2em}号 &\ul@t@parbox{\@authorwidth}{\centering\@studentid}  \\
			姓\hspace{2em}名 &\ul@t@parbox{\@authorwidth}{\centering\@author}     \\
			年\hspace{2em}级 &\ul@t@parbox{\@authorwidth}{\centering\@grade}      \\
			专\hspace{2em}业 &\ul@t@parbox{\@authorwidth}{\centering\@major}      \\
			系\hspace{2em}别 &\ul@t@parbox{\@authorwidth}{\centering\@department} \\
			学\hspace{2em}院 &\ul@t@parbox{\@authorwidth}{\centering\@college}    \\
			指导教师         & \ul@t@parbox{\@authorwidth}{\centering\@adviser}    \\
			完成日期         & \ul@t@parbox{\@authorwidth}{\centering\@date}       \\
		\end{tabular}
			\vspace{\fill}
	\end{titlepage}}

% 声明
\NewDocumentCommand{\nolabel@section}{smO{#4}m}{%
	\clearpage\section*{\phantomsection\sffamily\zihao{#2}#4}\sectionmark{#3}%
	\IfBooleanF{#1}{\addcontentsline{toc}{section}{#3}}}
\newcommand{\declaration}{
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
	\end{flushright}\clearpage}

% 中英摘要
\renewenvironment{abstract}
	{\nolabel@section*{4}[摘要]{摘\hspace{1em}要}}
	{\par\bigskip\par\noindent\textsf{关键词：}\zh@keywords\clearpage}
\newenvironment{abstract*}
	{\nolabel@section*{4}{Abstract}}
	{\par\bigskip\par\noindent\textsf{Keywords:\space}\en@keywords\clearpage}

% 目录
\RequirePackage{titletoc}
\setcounter{tocdepth}{2}
\newcommand{\content@filler}{~\titlerule*[0.96em]{\CJKfamily{fb@song}…}}
\titlecontents{section}[0em]{\zihao{-3}}
	{\zhnumber{\thecontentslabel}、}{}{\content@filler\contentspage}
\renewcommand{\thesubsection}{\arabic{subsection}}
\titlecontents{subsection}[2em]{\zihao{4}}
	{（\zhnumber{\thecontentslabel}）}{}{\content@filler\contentspage}
\renewcommand{\tableofcontents}
	{\nolabel@section*{3}[目录]{目\hspace{1em}录}\@starttoc{toc}\clearpage}

% 附录
\RenewDocumentCommand{\appendix}{s}{
	\setcounter{section}{0}
	\setcounter{subsection}{0}
	\renewcommand{\thesection}{\Alph{section}}
	\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}%
	\titleformat{\section}{\centering\zihao{4}\sffamily}
		{附\hspace{1em}录\Alph{section}：}{0em}{}
	\titlecontents{section}[0em]{\zihao{-3}}{附录\thecontentslabel：}{}
		{\content@filler\contentspage}
	\IfBooleanT{#1}{
		\stepcounter{section}
		\nolabel@section{4}[附录]{附\hspace{1em}录}
	}
}

% 参考文献
\newenvironment{reference}{
	\nolabel@section{4}{参考文献}
	% 兼容natbib、biblatex、和手写
	\ifdef{\bibfont}{\renewcommand{\bibfont}{\zihao{5}}}{\zihao{5}}
}{\clearpage}

% 致谢
\newenvironment{acknowledgement}{
	\nolabel@section{4}[致谢]{致\hspace{1em}谢}
	\newcounter{begin@page}
	\setcounter{begin@page}{\value{page}}
}{
	\ifnumequal{\thebegin@page}{\thepage}{}{\ClassWarning{nkuthesis}{致谢超过了一页}}
	\clearpage
}

	

