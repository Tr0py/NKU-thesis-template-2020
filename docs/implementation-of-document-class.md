# 文档类的实现

文档类文件`nkuthesis.cls`（下称本文档类）实现了[《关于做好2023年度本科毕业论文（设计）管理工作和校级优秀本科毕业论文（设计）评选工作的通知》](http://jwc.nankai.edu.cn/2022/1124/c24a497818/page.htm)之附件1《南开大学本科毕业论文（设计）指导手册》的格式要求（下称教务处格式）。

本文档类最小化实现教务处格式，教务处格式未说明的格式保留默认样式。出于兼容性和可维护性考虑，使用主流宏包实现所需功能，不重复造轮子。

本文为实现文档而非使用文档，帮助读者对实现方式进行理解和修改，作者假定读者具有基本的 latex 知识。若有相关实现难以理解，读者可查阅对应的依赖宏包或[《一份（不太）简短的 LATEX 2ε 介绍》](http://mirrors.ctan.org/info/lshort/chinese/lshort-zh-cn.pdf)。

## 依赖

本节仅介绍显式依赖，不列举隐式依赖。例如，ctexart依赖fontspec，不列举fontspec。

| 宏包   | 说明                      |
| -------- | ----------------------------------------------- |
| calc   | 提供数值计算                  |
| caption  | 题注格式与间距                  |
| ctexart  | 中文 article 文档类，提供中文环境和默认中文样式 |
| etoolbox | 分支、循环、命令补丁等              |
| flafter  | 修改浮动规则，浮动体置于引用后          |
| footmisc | 设置脚注格式                  |
| geometry | 设置页面边距                  |
| hyperref | 超链接、PDF 书签与属性、交叉引用跳转等      |
| pifont   | 提供带圈数字                  |
| placeins | 修改浮动规则，浮动体不跨节            |
| titlesec | 设置标题格式                  |
| titletoc | 设置目录格式                  |

依赖宏包的详细用法请查看宏包文档。借助`texdoc`可查看当前 tex 发行版中包含的宏包文档。例如，运行`texdoc ctex`查看ctex系列宏包的文档。网上也有一些热心人士翻译的中文手册，可对照阅读。

## 对照实现

本节分部分介绍实现，先引述教务处格式的对应原文，然后介绍实现方法和对应代码，最后提供一些帮助理解的相关文章。对应代码第一行以`file:line`的格式说明代码位置。

### 结构

> 毕业论文（设计）结构一般由封面、中英文内容摘要及关键词、目录、正文、附录、参考文献、致谢等组成。毕业论文（设计）一律采用打印形式，编排装订顺序依次为：（1）封面（2）声明（3）中英文内容摘要及关键词（4）目录（5）正文（6）附录（7）参考文献（8）致谢（9）毕业论文（设计）题目审批表（10）毕业论文（设计）中期检查表（11）毕业论文（设计）指导教师评语及打分表（12）毕业论文（设计）答辩记录及打分表（13）“查重”检测结果及对检测结果的认定材料。

本文档类实现前八个部分，剩余部分为附件部分，不实现。

### 正文格式

> 正文采用1.5倍行间距。中文用小四号宋体，英文用小四号Times New Roman字体。

借助 ctexart 选项设置默认字号与行间距。默认字号设置为小四，linespread 设置为 1.5，不使用 ctex 默认字体设置。

```latex
\LoadClass[zihao=-4,linespread=1.5,fontset=none]{ctexart}
```

使用 fontspec 宏包设置字体。注意，这里中文无衬线字体为黑体，西文无衬线字体为加粗的Times New Roman，为后文标题格式的设置做准备。

```latex
\setmainfont[BoldFont=timesbd.ttf,ItalicFont=timesi.ttf,BoldItalicFont=timesbi.ttf,Path=fonts/]{times.ttf}
\setsansfont[ItalicFont=timesbi.ttf,Path=fonts/]{timesbd.ttf}
\setCJKmainfont[BoldFont=simhei.ttf,ItalicFont=simkai.ttf,Path=fonts/]{simsun.ttf}
\setCJKsansfont[Path=fonts/]{simhei.ttf}
\setCJKmonofont[Path=fonts/]{simfang.ttf}
```

*推荐阅读*：

- [latex 字体与行距](https://www.jianshu.com/p/3a833e484214)
- [LaTeX 中文字体配置基础指南](https://zhuanlan.zhihu.com/p/538459335)
- [ctex 宏集手册](http://mirrors.ctan.org/language/chinese/ctex/ctex.pdf)
- [fontspec 宏包文档](http://mirrors.ctan.org/macros/unicodetex/latex/fontspec/fontspec.pdf)

### 打印要求

> 诚信声明、毕业论文（设计）相关表格中的评语和意见需指导教师或学生手写签字，其他文字一律采取Word或与Word兼容的软件打印，A4纸张，页边距采取默认形式（上下2.54cm，左右3.17cm，页眉1.5cm，页脚1.75cm）；字符间距为默认值（缩放100%，间距：标准）；论文总页数在50页以上的双面打印。

借助 geometry 宏包设置页码大小和页边距

```latex
\RequirePackage[paper=a4paper,vmargin=2.54cm,hmargin=3.17cm,headheight=0.75cm,headsep=0.29cm,footskip=0.79cm]{geometry}
```

不显示页面，仅显示页码。注意，本文档类的实现方式兼容页眉，切换其他页面样式即可显示。然教务处格式未做要求，为避免节外生枝，本文档类默认不显示页眉，使用时可酌情覆盖该设置。若追求美观，推荐使用 fancyhdr 宏包提供的 fancy 页面样式。

```latex
\pagestyle{plain}
```

*推荐阅读*：

- 如何使用 geometry ：[Page size and margins](https://www.overleaf.com/learn/latex/Page_size_and_margins)
- pagestyle的介绍：[LaTex 修改页面页眉页脚的样式](https://www.jianshu.com/p/6999ac4b4c19)
- [The fancyhdr and extramarks packages](http://mirrors.ctan.org/macros/latex/contrib/fancyhdr/fancyhdr.pdf)
- [一个关于 geometry 设置页眉 1.5 cm，页脚 1.5 cm的问题](https://ask.latexstudio.net/ask/question/3474.html)

### 标题格式

>毕业论文（设计）正文数字标题书写顺序依次为：一、（一）1. (1) ①；第一级标题用小三号黑体字，第二级标题用四号黑体字，第三级及以下标题用小四号黑体字。

注意，这里没有使用 ctexheading 设置标题格式，原因是设置附录标题时不够灵活。

首先，设置标题编号的深度。当前设置表示从part到subparagraph的标题前均带编号。计数器secnumdepth的详细含义可查阅 [ctex 宏集手册](http://mirrors.ctan.org/language/chinese/ctex/ctex.pdf)（7.1 编号相关）。

```latex
\setcounter{secnumdepth}{5}
```

然后，设置各级标题的编号。`\chinese`是 ctex 提供的显示中文数字的命令。带圈数字的实现详见注释一节。

```latex
\renewcommand{\thesection}{\chinese{section}}
\renewcommand{\thesubsection}{（\chinese{subsection}）}
\renewcommand{\thesubsubsection}{\arabic{subsubsection}}
\renewcommand{\theparagraph}{(\arabic{paragraph})}
\renewcommand{\thesubparagraph}{\ding{\numexpr171+\value{subparagraph}}}
```

最后，借助 titlesec 宏包提供的`\titleformat`命令设置标题格式。

```latex
\titleformat{\section}{\centering\zihao{-3}\sffamily}{{\thesection}、}{0em}{}
\titleformat{\subsection}{\centering\zihao{4}\sffamily}{\thesubsection}{0em}{}
\titleformat{\subsubsection}{\zihao{-4}\sffamily}{{\thesubsubsection}.}{0.5em}{}
\titleformat{\paragraph}{\zihao{-4}\sffamily}{\theparagraph}{0.5em}{}
\titleformat{\subparagraph}{\zihao{-4}\sffamily}{\thesubparagraph}{0.5em}{}
```

*推荐阅读*：

- [LaTeX使用titlesec宏包改变章节编号形式的方法](https://www.cnblogs.com/Arago/p/5974181.html)
- [The titlesec, titleps and titletoc Packages](http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf)
- [LATEX 笔记：Section 编号方式(数字、字母、罗马)&计数器计数形式修改](https://www.cnblogs.com/oucsheep/p/4246701.html)

### 注释

> 注释一律采用页下注（脚注），而不是随文注或篇末注，可参照《中国社会科学编排规范》中的注释格式要求。注释内容当页完成，中文用小五号宋体，英文用小五号Times New Roman字体。注释序号用①②③，与注释文字之间空一格。在同一页中有两个及以上的注释时，按注释在正文中的先后顺序编号，并标注在正文右上角，如×××①。每一页独立编号。

在 footmisc 宏包中，perpage 选项表示脚注每页重新编号，bottom 表示当浮动体处于页面下方时脚注显示在浮动体的更下方。

```latex
\RequirePackage[perpage,bottom]{footmisc}
```

`thefootnote`是脚注编号，是 pifont 提供的符号的命令，此处为带圈数字。`\ding`命令中从 172 开始依次为 1 到 10 的带圈数字，此处借助 calc 宏包计算对应 1 到 10 数字的编号。

```latex
\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}}}
```

仅修改脚注内容处的脚注编号格式，即5号字、空一格。需要借助 etoolbox 宏包提供的 `\patchcmd`命令对`\@makefntext`打补丁。

```latex
\patchcmd\@makefntext{{\hss\@makefnmark}}
  {{\hss\hbox{\normalfont\zihao{-5}\@thefnmark}}\enspace}{}{\fail}
```

*推荐阅读*：

- [用带圈数字编号脚注和尾注](https://zhuanlan.zhihu.com/p/74515148)
- [footmisc — a portmanteau package for customizing footnotes in LATEX](http://mirrors.ctan.org/macros/latex/contrib/footmisc/footmisc-doc.pdf)
- [Using common PostScript fonts with LATEX](http://mirrors.ctan.org/macros/latex/required/psnfss/psnfss2e.pdf)
- [The calc package - Infix notation arithmetic in LATEX](http://mirrors.ctan.org/macros/latex/required/tools/calc.pdf)
- [The etoolbox Package - An e-TeX Toolbox for Class and Package Authors](http://mirrors.ctan.org/macros/latex/contrib/etoolbox/etoolbox.pdf)

### 公式

> （1）公式应另起一行写在稿纸中央。一行写不完的长公式，最好在等号处转行，如做不到这一点，可在数学符号（如“﹢”、“﹣”号）处转行。
>
> （2）公式的编号用圆括号括起，放在公式右边行末，在公式和编号之间不加虚线。公式可按全文统编序号，也可按章独立序号，如（49）或（4.11），采用哪一种序号应和图序、表序编法一致。不应出现某章里的公式编序号，有的则不编序号。子公式可不编序号，需要引用时可加编a、b、c……重复引用的公式不得另编新序号。公式序号必须连续，不得重复或跳缺。
>
> （3）文中引用某一公式时，写成“由式（16.20）”

TODO: 数学环境的实现变式较多，且各数学宏包的默认样式基本满足要求，因此本文档类不对公式样式进行“微操”，请读者自行调用相关宏包。

### 表格与图

> （1）表格必须与论文叙述有直接联系，不得出现与论文叙述脱节的表格。表格中的内容在技术上不得与正文矛盾。
>
> （2）每个表格都应有表题和序号。表题应写在表格上方正中，序号写在左方，不加标点，空一格接写标题，表题末尾不加标点。
> （3）全文的表格可以统一编序，也可以逐章单独编序。采用哪一种方式和插图、公式的编序方式统一。表序必须连续，不得跳缺。正文中引用时，“表”字在前，序号在后，如写“表2”。
>
> （4）表格允许下页接写，接写时表题省略，表头应重复书写，并在右上方写“续表××”。多项大表可以分割成块，多页书写，接口处必须注明“接下页”、“接上页”、“接第×页”字样。
>
> （5）表格采用“三线表”形式，应位于正文首次出现处的段落下方，不应置前和过分置后。
>
> （示例详见原文）
>
> （1）毕业论文（设计）的插图必须精心制作，线条要匀洁美观。插图应与正文呼应，不得与正文无关或与正文脱节；正文中要求对插图进行解释说明。
>
> （2）图的内容安排要适当，不要过于密实。
>
> （3）每幅插图应有题目和序号，全文的插图可以统一编序，也可以逐章单独编序，如：图45或图6.8；采取哪一种方式应和表格、公式的编序方式统一。图序必须连续，不重复，不跳缺。
>
> （4）由若干分图组成的插图，分图用a、b、c……标序。分图的图名以及图中各种代号的意义，以图注形式写在图题下方，先写分图名，另起行后写代号的意义。
>
> （示例详见原文）

可以在`figure`浮动环境中使用`tabular`等命令或宏包制作表格，使用 longtable 宏包制作跨页表格。使用 bookmarks 宏包帮助制作三线表。图注可以使用 subcaption 等宏包实现。latex 中默认的题注格式不符合要求，本文档类借助 caption 宏包进行修改。

```latex
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{enspace}{\enspace}
\captionsetup{labelsep=enspace,skip=1pt}
```

教务处格式要求表格“应位于正文首次出现处的段落下方”，故借助 flafter 宏包修改浮动规则，将浮动体置于引用后。

```latex
\RequirePackage{flafter}
```

*推荐阅读*：

- [Customizing captions of floating environments](http://mirrors.ctan.org/macros/latex/contrib/caption/caption.pdf)
- [就这样驯服了 LaTeX 浮动体 - 再也不担心它乱动了](https://ask.latexstudio.net/ask/article/644.html)

### 封面

> 使用教务处统一制作的封面，修双学位学生第二学位论文（设计）使用双学位专用封面。
>
> （教务处统一制作的封面见原文）

本文档类使用类似基本文档类的方式定义封面信息，为各项封面信息定义了一些设置和保存信息的命令，原有的`\title`、`\author`和`\date`命令仍然使用。`\RenewDocumentCommand`具体使用方法详见 xparse 宏包，xparse 已默认包含在 latex2e 中。

```latex
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
\RenewDocumentCommand{\title}{sm}{
  \IfBooleanTF{#1}
    {\renewcommand{\en@title}{#2}}
    {\renewcommand{\zh@title}{#2}}
}
```

借助表格环境 `tabular`和各种盒子排版封面，间距字距根据教务处提供的word格式封面估计得来。

```latex
\setCJKfamilyfont{fb@song}{simsun.ttf}[AutoFakeBold=1,Path=fonts/]
\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering
      \vspace*{25pt}\par\linespread{1}\fontsize{56}{0}
    \textbf{\CJKfamily{fb@song}\makebox[5.5em][s]{南开大学}}\par
      \vspace{35pt}\par\linespread{1}\zihao{2}
    \makebox[255pt][s]{本科生毕业论文（设计）}\par
      \vspace{60pt}\par\linespread{1.2}\zihao{3}
    \begin{tabular}{l@{：}l}
      中文题目 & \ul@t@parbox{16.5em}{\centering\zh@title} \\
      外文题目 & \ul@t@parbox{16.5em}{\centering\en@title} \\
    \end{tabular}
      \vspace{\fill}\par\linespread{1.15}\zihao{3}
    \begin{tabular}{l@{：}l}
      学\hspace{2em}号 &\ul@t@parbox{8em}{\centering\@studentid}  \\
      姓\hspace{2em}名 &\ul@t@parbox{8em}{\centering\@author}   \\
      年\hspace{2em}级 &\ul@t@parbox{8em}{\centering\@grade}    \\
      专\hspace{2em}业 &\ul@t@parbox{8em}{\centering\@major}    \\
      系\hspace{2em}别 &\ul@t@parbox{8em}{\centering\@department} \\
      学\hspace{2em}院 &\ul@t@parbox{8em}{\centering\@college}  \\
      指导教师     & \ul@t@parbox{8em}{\centering\@adviser}  \\
      完成日期     & \ul@t@parbox{8em}{\centering\@date}     \\
    \end{tabular}
      \vspace{\fill}
  \end{titlepage}}
```

本文档类定义了一个内部命令 `\ul@t@parbox` 用于实现等长多行下划线盒子。基本思想是分别排版下划线和各行内容，并使二者重叠。`\ul@t@parbox`使用时与`\parbox`类似，可以手动或自动换行。

```latex
\newlength\topulineparbox@totalheight
\newcommand\ul@t@parbox[2]{{%
  \hbadness=10000 % 禁用此处 "underfull hbox" 提示
  \settototalheight\topulineparbox@totalheight{\parbox[t]{#1}{#2}}%
  \ifdimless{\baselineskip}{\topulineparbox@totalheight}{
    \rlap{\smash{\parbox[t]{#1}{%
      \unlessboolexpr{test {\ifdimless{\topulineparbox@totalheight}{0pt}}}{%
        \underline{\hspace{#1}}\\%
        \addtolength\topulineparbox@totalheight{-\baselineskip}%
      }%
    }}}%
    \parbox[t]{#1}{#2}
    \vspace{0.7ex}
  }{
    \underline{\makebox[#1][c]{#2}}
  }
}}
```

*推荐阅读*：

- [双语标题：LaTeX 实现](https://zhuanlan.zhihu.com/p/51494365)
- [LaTeX分享之盒子的使用](https://zhuanlan.zhihu.com/p/428511909)
- [xparse – A generic document command parser](http://mirrors.ctan.org/macros/latex/contrib/l3packages/xparse.pdf)

### 声明

> “关于南开大学本科生毕业论文（设计）的声明”用三号字、黑体，居中书写，正文字体为小四号宋体。学生和指导教师应手写签字，不得打印，不得用印章。声明时间与封面中论文完成时间一致，应在答辩之前。
>
> （声明示例见原文）

声明仿照示例实现即可。

```latex
\newcommand{\declaration}{
  \nolabel@section*{3}[声明]{关于南开大学本科生毕业论文（设计）的声明}
  本人郑重声明：所呈交的学位论文，是本人在指导教师指导下，进行研究工作所取得的成果。
  除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人创作的、
  已公开发表或没有公开发表的作品内容。对本论文所涉及的研究工作做出贡献的其他
  个人和集体，均已在文中以明确方式标明。本学位论文原创性声明的法律责任由本人承担。
  \par\bigskip
  \begin{flushright}
    学位论文作者签名：\hspace*{6em}\medskip\par
    \@date
  \end{flushright}
  \vspace{4\baselineskip}\par
  本人声明：该学位论文是本人指导学生完成的研究成果，已经审阅过论文的全部内容，
  并能够保证题目、关键词、摘要部分中英文内容的一致性和准确性。
  \par\bigskip
  \begin{flushright}
    学位论文指导教师签名：\hspace*{6em}\medskip\par
    年\hspace{2em}月\hspace{2em}日
  \end{flushright}
  \clearpag
}
```

由于教务处格式中声明、目录、摘要等标题格式大同小异，本文档类定义了一个内部命令`\nolabel@section` 来排版这些无编号标题。

- `\section*`是原生的无编号标题
- `\sectionmark`用于更新节页眉
- `\addcontentsline{toc}{section}{xxx}`用于在目录中添加节标题项
- `\phantomsection`则是设置锚点，帮助 hyperref 宏包设置正确的跳转位置。

```latex
\NewDocumentCommand{\nolabel@section}{smO{#4}m}{%
  \clearpage
  \section*{\phantomsection\sffamily\zihao{#2}#4}
  \sectionmark{#3}
  \IfBooleanF{#1}{\addcontentsline{toc}{section}{#3}}
}
```

*推荐阅读*：

- [把不编号章节加进目录和 PDF 书签](https://zhuanlan.zhihu.com/p/66434387)
- [When do I need to invoke \phantomsection?](https://tex.stackexchange.com/questions/44088/when-do-i-need-to-invoke-phantomsection)

### 摘要及关键词

> “摘”“要”中间空两格、四号字、黑体、居中。“Abstract”为四号Times New Roman、加粗、居中。摘要内容：中文字体为小四号字、宋体；英文字体为小四号字、Times New Roman。英文摘要应另起一页。
>
> “关键词”三个字用小四号字、黑体、顶格写。“Keywords” 用小四号字、Times New Roman、加粗、顶格写。关键词内容：中文字体为小四号字、宋体，英文字体为小四号字、Times New Roman，各关键词之间用分号分隔。

本文档类使用类似`\title`和`\author`的方式设置关键字，在使用`abstract`环境时同时排版关键字。

```latex
\newcommand{\zh@keywords}{}
\newcommand{\en@keywords}{}
\NewDocumentCommand{\keywords}{sm}{
  \IfBooleanTF{#1}
    {\renewcommand{\en@keywords}{#2}}
    {\renewcommand{\zh@keywords}{#2}}
}
```

```latex
\renewenvironment{abstract}
  {\nolabel@section*{4}[摘要]{摘\hspace{1em}要}}
  {\par\bigskip\par\noindent\textsf{关键词：}\zh@keywords\clearpage}
\newenvironment{abstract*}
  {\nolabel@section*{4}{Abstract}}
  {\par\bigskip\par\noindent\textsf{Keywords: }\en@keywords\clearpage}
```

### 目录

> “目”“录”中间空两格、三号字、黑体、居中。目录的各章节应简明扼要，其中每章题目采用小三号宋体字，每节题目采用四号宋体字。要注明各章节起始页码，题目和页码之间用“…………”连接。

首先，由于教务处格式中仅说明了前两级别标题在目录中的格式，为避免节外生枝，将目录深度设置为 2。

```latex
\setcounter{tocdepth}{2}
```

然后，借助 titletoc 宏包对目录项格式进行设置。

```latex
\RequirePackage{titletoc}
\newcommand{\content@filler}
  {~\titlerule*[0.96em]{\CJKfamily{fb@song}…}}
\titlecontents{section}[0em]{\zihao{-3}}
  {\thecontentslabel、}{}{\content@filler\contentspage}
\titlecontents{subsection}[2em]{\zihao{4}}
  {\thecontentslabel}{}{\content@filler\contentspage}
```

最后，由于没有什么适合的宏包能够实现预期的目录标题格式，本文档类借助 latex 内部宏`\@starttoc`重新实现了`\tableofcontents`命令。

```latex
\renewcommand{\tableofcontents}
  {\nolabel@section*{3}[目录]{目\hspace{1em}录}\@starttoc{toc}\clearpage}
```

*推荐阅读*：

- [titletoc – Alternative headings for toc/lof/lot](http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf)
- [macros2e – A list of internal LATEX2ε macros](https://www.ctan.org/pkg/macros2e)
- [LaTeX中生成标题、摘要、关键词、目录方法以及自定义所需样式](https://blog.csdn.net/weixin_45008608/article/details/115796434)

### 附录

> 是否需要附录可根据毕业论文（设计）情况而定。附录应另起一页，内容一般包括正文中不便列出的冗长公式推导、符号说明（含缩写）、计算机程序等。“附”“录”中间空两格、四号字、黑体、居中，内容采用小四号、宋体。

附录是万恶之源，按照教务处格式的字面意思，附录仅有一个，但一些学校给的模板中附录存在多个标题，因此本文档类对两种附录均进行了实现，使用者通过参数`*`来选择。

```latex
\RenewDocumentCommand{\appendix}{s}{
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  % 重设编号，保证目录、页眉和书签的编号显示正常
  \renewcommand{\thesection}{附录\Alph{section}}
  % 在目录中不显示附录的二级标题
  \addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
  % 多标题情况的section格式和目录格式
  \titleformat{\section}{\centering\zihao{4}\sffamily}
    {附\hspace{1em}录\Alph{section}：}{0em}{}
  \titlecontents{section}[0em]{\zihao{-3}}{\thecontentslabel：}{}
    {\content@filler\contentspage}
  % 单标题情况直接放置一个标题
  \IfBooleanT{#1}{\nolabel@section{4}[附录]{附\hspace{1em}录}}
}
```

单标题的情况相对简单，直接放置一个标题即可。

多标题情况相对复杂，ctexheading 宏包提供的接口无法实现预期效果，本文档类的具体实现详见注释。

### 致谢

> 致谢是本科生对毕业论文（设计）完成过程中得到的帮助给予的肯定与感谢，学生可根据需要撰写。“致谢”二字中间空两格、四号字、黑体、居中。内容限1页，采用小四号宋体。

```latex
\newenvironment{acknowledgement}
  {\nolabel@section{4}[致谢]{致\hspace{1em}谢}}
  {\clearpage}
```

### 参考文献

> 参考文献应根据各学科正式发表学术论文的规范要求书写，并按在论文中引用的顺序进行排列。每篇文献最多列出3位作者，超出3位时，中文写“等”，英文写“et al”(斜体)。作者的姓名一律姓在前名在后，欧美人的名字可以用缩写字母，且缩写名后省略缩写点“.” 。参考文献应另起一页，一律放在正文后。
>
> 《中国高校自然科学学报编排规范》中几种主要参考文献著录表的格式为：
>
> 连续出版物：作者.文题.刊名，年，卷号（期号）：起~止页码。
>
> 专（译）著：作者.书名（译音）.出版地：出版者，出版年，起~止页码。
>
> 论文集： 作者.文题.见（In）：编者,编（eds.）文集名.出版地：出版者，出版  年，起~止页码。
>
> 学位论文：作者.文题:[博士或硕士学位论文].授予单位，授予年。
>
> 专利：申请者.专利名.国家.专利文献种类.专利号，授权日期。
>
> 技术标准：发布单位.技术标准代号.技术标准名称.出版地:出版者，出版日期。
>
> 人文社会科学论文的文献资料格式为：
>
> 图书：著者.书名.出版者，出版时间，版次，页次。
>
> 期刊：作者.篇名.期刊名称，期号。
>
> 报纸：作者.篇名.报纸名称，日期，版次。
>
> 举例如下：
>
> (示例详见原文)
>
> 以上序号用中扩号，与文字之间空两格。如果需要两行的，第二行文字要位于序号的后边，与第一行文字对齐。中文用五号宋体，外文用五号Times New Roman字体。

natbib 和 biblatex 这两个宏包均可通过重定义`\bibfont`设置参考文献字体。

```latex
\newenvironment{reference}{
  \nolabel@section{4}{参考文献}
  % 兼容natbib、biblatex、和手写
  \ifdef{\bibfont}{\renewcommand{\bibfont}{\zihao{5}}}{\zihao{5}}
}{\clearpage}
```

*推荐阅读*：

- [natbib – Flexible bibliography support](http://mirrors.ctan.org/macros/latex/contrib/natbib/natbib.pdf)
- [BibLATEX – Sophisticated Bibliographies in LATEX](http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf)

### 其他

> 这一部分在教务处格式中未提及，本文档类根据惯例进行了设定

每个 section 另启一页，每个 section 前的空白不可省略。

```latex
\newcommand{\sectionbreak}{\newpage\vspace*{0pt}}
```

浮动体仅放置在当前 section。

```latex
\RequirePackage[section]{placeins}
```

设置超链接，带编号的pdf书签，使用标题为pdf设置标题、作者、日期这些元数据。

```latex
\RequirePackage[hidelinks,pdfa,pdfusetitle,bookmarksnumbered]{hyperref}
```

设置其他元数据项

```latex
\hypersetup{pdfsubject={南开大学本科生毕业论文（设计）}}
\RenewDocumentCommand{\title}{sm}{\IfBooleanTF{#1}
  {\renewcommand{\en@title}{#2}}
  {\renewcommand{\zh@title}{#2}\hypersetup{pdftitle={#2}}}}
\NewDocumentCommand{\keywords}{sm}{\IfBooleanTF{#1}
  {\renewcommand{\en@keywords}{#2}}
  {\renewcommand{\zh@keywords}{#2}\hypersetup{pdfkeywords={#2}}}}
```
