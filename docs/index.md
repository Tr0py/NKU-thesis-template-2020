---
layout: default
---

# 南开大学毕业论文模板
[![NKUTHESIS](https://img.shields.io/badge/NKthesis-latex-blue.svg)](https://tr0py.github.io/NKU-thesis-template-2020/)
[![GitHub release](https://img.shields.io/github/release/Tr0py/NKU-thesis-template-2020.svg?label=version&style=popout)](https://github.com/Tr0py/NKU-thesis-template-2020/releases/latest)
[![Overleaf](https://img.shields.io/badge/Overleaf模板-green)](https://www.overleaf.com/latex/templates/nan-kai-da-xue-ben-ke-sheng-bi-ye-lun-wen-mo-ban-v1-dot-4/hdfqhtmmmdpv)
[![Questions](https://img.shields.io/badge/模板讨论&使用问题？-pink)](https://github.com/Tr0py/NKU-thesis-template-2020/discussions)

最近一次更新：2023年5月。

## 简介

本项目为南开大学毕业论文的 LaTeX 模板，主要支持本科生毕业论文模板。

This is a LaTeX template for Nankai University graduation thesis.
It mainly provides undergraduate thesis template.

## 如何使用

模板有三种常用使用方式，以下三种任选其一，难度递增。

### 1. 使用Overleaf模板 [便于使用]

1. 打开 [Overleaf南开大学本科生毕业论文模板](https://www.overleaf.com/latex/templates/nan-kai-da-xue-ben-ke-sheng-bi-ye-lun-wen-mo-ban-v1-dot-4/hdfqhtmmmdpv)
2. 点击"Open as Template"

> 注意：overleaf模板版本可能比GitHub版本落后。如果想使用最新版，请使用源码+overleaf方式。

### 2. 使用源码+overleaf [最新版本]

1. 下载最新的源码
	- 打开[最新的Release页面](https://github.com/Tr0py/NKU-thesis-template-2020/releases/latest)
	- 点击Source code (zip) 下载源码并编译
2. 在Overleaf中上传源码作为project
	- Overleaf中，点击左方"New Project" - "Upload Project"
	- 选择编译好的zip文件上传
	- 选择使用XeLateX + 2022 TeX Live 进行编译
		- 左上角Menu - Compiler 选择XeLateX, TeX Live Version选择2022

### 3. 使用源码+tex本地编译 [便于开发]

1. 安装环境依赖:textlive
	- Windows / Linux: TeX Live 2022
	- MacOS: MacTeX
2. 克隆源码
3. 编译模板
4. 使用`make`编译 main.tex

### 4. 使用源码+借助TexWorks本地编译 [开箱即用]

1. 安装环境依赖:miktex
	- Windows / Linux: miktex
2. 克隆源码
3. 编译模板
	- 使用 TexWorks 打开 nkuthesis.dtx
	- 选择 xelatex 引擎编译一次
4. 编译文档
	- 使用 TexWorks 打开 main.tex
		- 依次选择 `xelatex,biber,xelatex,xelatex` 引擎编译共4次
		- 或者，如果参考文献使用的是 natbib 宏包，可以选择 `xelatex+makeindex+bibtex` 引擎编译1次

## 如何编译模板

从源码编译模板：

```
xelatex nkuthesis.dtx
```

将得到模板类实现文档（nkuthesis.pdf）和模板类文件（nkuthesis.cls），确保 
nkuthesis.cls 可用后即可使用模板。

## 其他

- 硕士生/博士生毕业论文模板可以移步[南开大学硕士毕业论文(博士论文)Latex模板](https://nkthesis.newfuture.cc/)
- 如果遇到问题，你可以在QQ群中提问：群号 469868290。如果你会用GitHub：
	- 如果你有疑问或建议，欢迎在[GitHub 讨论区](https://github.com/Tr0py/NKU-thesis-template-2020/discussions)问问题
	- 如果你遇到了bug，欢迎在GitHub提出[Issue](https://github.com/Tr0py/NKU-thesis-template-2020/issues)
	- 最后，欢迎向维护者发送[邮件](https://github.com/tr0py/)询问
