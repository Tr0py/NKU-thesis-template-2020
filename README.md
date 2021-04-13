# NKU-thesis-template-2020
Undergraduate dissertation latex template for Nankai University that synchronizes with Overleaf. 南开大学本科生毕业设计Latex模板，与overleaf同步

## 0x0 How to use

Using Overleaf Link

[Link to overleaf template](https://www.overleaf.com/latex/templates/nku-dissertation-template2020/ryscpwbhbmhs)

## 0x1 Change Log

### 2020/4/23

1. 根据学校要求，参考文献改为三名作者以上列等或et al.
2. 修复了封面英文第二行填无无法消失的问题
3. 根据学院要求改动，目录可添加摘要、Abstract和目录

### 2020/4/30

根据学院封面要求改动

1. 修改了左对齐(\hfil)
2. 添加了楷体粗体(\cukai)
3. 添加了字号小三(\zihaoxiaosan)

### 2021/04/13
1. 增加了Times New Roman字体
2. 增加了本地编译的选项

本地编译方法
#### 依赖 
textlive-2020
##### Linux
```
  sudo apt install texlive-full
```
##### Windows
下载texlive-2020并添加到环境变量。

#### 编译
##### 自动编译
make

##### 手动编译
```
xelatex main
biber main
xelatex main
xelatex main # 两次编译以生成正确的参考文献。
```


## 0x2 TODO:

* 兼容学校/学院模板？
  * 用一个宏去切换？
  * 发布两个版本？
* 参考文献中文兼容问题未解决
  * and
  * 尚未进行测试因为没用中文参考文献
* 替换manual为多个文件，如introduction.tex等
