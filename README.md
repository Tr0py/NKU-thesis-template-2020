# NKU-thesis-template-2020
Undergraduate dissertation template in latex for Nankai University that synchronizes with Overleaf. 南开大学本科生毕业设计Latex模板，与overleaf同步

[TOC]

## 0x0 How to use

### 1. 在线使用：Using Overleaf Link （推荐）

[Link to overleaf template](https://www.overleaf.com/latex/templates/nku-dissertation-template2020/ryscpwbhbmhs)


### 2. 离线使用：Compile using texlive

1. 环境依赖:`textlive`
   1. Windows / Linux: [TeX Live](https://www.tug.org/texlive/)
   2. MacOS: [MacTeX](http://www.tug.org/mactex/)
2. 编译指令: `make`



## 0x1 Change Log

### 2021/06/18

1. 增加了数字及英文的黑体支持。可使用`\enghei`来对数字/英文使用黑体。
2. 根据最新要求，三级标题数字修正为黑体加粗。如图。

<img src="./Figures/21JunSimHei.png" style="zoom:50%;" />

### 2021/04/13

1. 增加了Times New Roman字体
2. 增加了本地编译的选项

### 2021/03/10
1. 优化格式

### 2020/4/23

1. 根据学校要求，参考文献改为三名作者以上列等或et al.
2. 修复了封面英文第二行填无无法消失的问题
3. 根据学院要求改动，目录可添加摘要、Abstract和目录

### 2020/4/30

根据学院封面要求改动

1. 修改了左对齐(\hfil)
2. 添加了楷体粗体(\cukai)
3. 添加了字号小三(\zihaoxiaosan)



## 0x2 TODO:

* 兼容学校/学院模板？
  * 用一个宏去切换？
  * 发布两个版本？
* 替换manual为多个文件，如introduction.tex等
