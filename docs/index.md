---
layout: default
---

# 南开大学毕业论文模板
![NKUTHESIS](https://img.shields.io/badge/NKthesis-latex-blue.svg)
[![Gitter](https://badges.gitter.im/nkuthesis/community.svg)](https://gitter.im/nkuthesis/community)

## 简介

本项目为南开大学毕业论文的 LaTeX 模板，主要支持本科生毕业论文模板。

This is a LaTeX template for Nankai University graduation thesis.
It mainly provides undergraduate thesis template.

## 如何使用

有三种常用使用方式，以下三种任选其一，难度递增。

### 1. 使用Overleaf模板

1. 打开 [Overleaf南开大学本科生毕业论文模板](https://www.overleaf.com/latex/templates/nan-kai-da-xue-ben-ke-sheng-bi-ye-lun-wen-mo-ban-v1-dot-4/hdfqhtmmmdpv)
2. 点击"Open as Template"

### 2. 使用源码+overleaf

1. 下载最新的源码
	- 打开[最新的Release页面](https://github.com/Tr0py/NKU-thesis-template-2020/releases/latest)
	- 点击Source code (zip) 下载源码
2. 在Overleaf中上传源码作为project
	- Overleaf中，点击左方"New Project" - "Upload Project"
	- 选择下载好的zip文件上传
	- 选择使用XeLateX + 2020 TeX Live 进行编译
		- 左上角Menu - Compiler 选择XeLateX, TeX Live Version选择2020(Legacy)

### 3. 使用源码+tex本地编译

1. 安装环境依赖:textlive
	- Windows / Linux: TeX Live
	- MacOS: MacTeX
	- Note: 目前TeX Live 2020 + XeLateX可以正常编译，新版本可能会有报错。未来计划修复。
2. 克隆源码
3. 使用`make`进行编译


## 其他

- 硕士生/博士生毕业论文模板可以移步[南开大学硕士毕业论文(博士论文)Latex模板](https://nkthesis.newfuture.cc/)
- 如果遇到问题，你可以
	- 在GitHub提出[Issue](https://github.com/Tr0py/NKU-thesis-template-2020/issues)
	- 在[Gitter](https://gitter.im/nkuthesis/community)问问题
	- 向维护者发送[邮件](https://github.com/tr0py/)询问
