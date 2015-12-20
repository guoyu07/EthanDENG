10 天前，勤劳的小 L 给我们带来了一个类文件—— khandout.cls! 

我个人觉得不是很美观（黑+蓝+白感觉不能忍），网友反映想有人对这个类文件进行修改，经过我的一番折腾，将类文件更新为 dhandout.cls Ver 1.0，作为 ElegantLaTeX 项目小组的共同资产，今后将一直维护下去。

dhandout 相比 khandout 而言，对节样式、小节样式、页眉页码、纸张都进行了一定的修改，如果想参考最原始的 khandout 文件，请参考 [khandout](http://elegantlatex.org/2014/10/07/khandout-cls/) 一文，该文后有下载地址。

这个类文件，格式比较简单，适用于大家日常写作！cls 文件易读性很高，拓展性也比较高，让我们一睹为快吧！

## How to Use!

Download the cls file from the website, put the main file and cls file in the same directory, one example of the main file:

<pre class="lang:tex decode:true " >
\documentclass[12pt,colorx]{dhandout}

\begin{document}

\section{One Section Example}
The text of the file goes here.

\end{document}
</pre>

## 使用说明

从网上下载 cls 类文件，然后将主文件与类文件放在同一个文件夹内，主文件只需要将 documentclass 改为 dhandout ，并且添加中文支持即可。示例如下：

<pre class="lang:tex decode:true " >
\documentclass{dhandout}

\usepackage[UTF8,space]{ctex}

\begin{document}

使用 ctex 支持中文输入！

\end{document}
</pre>

效果如下：

<center>![khandout](http://elegantlatex.org/wp-content/uploads/2014/10/guide.jpg)</center>

### 备注说明

此类文件有两个选项，分别为 `colorx`（默认） 与 `nocolorx`，后者可以用于打印。正文字体大小可以选择 10pt 或者 11pt！其他选项和 article 的选项一致。

[file]
