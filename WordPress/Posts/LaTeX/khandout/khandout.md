今天，勤劳的小 L 给我们带来了一个类文件—— khandout.cls!

这个类文件，格式比较简单，适用于大家日常写作！cls 文件易读性很高，拓展性也比较高，让我们一睹为快吧！下载地址见文后！

## How to Use!

Download the cls file from the website, put the main file and cls file in the same directory, one example of the main file:

<pre class="lang:tex decode:true " >
\documentclass{khandout}

\begin{document}

\section{One Section Example}
The text of the file goes here.

\end{document}
</pre>

## 使用说明

从网上下载 cls 类文件，然后将主文件与类文件放在同一个文件夹内，主文件只需要将 documentclass 改为 khandout ，并且添加中文支持即可。示例如下：

<pre class="lang:tex decode:true " >
\documentclass{khandout}

\usepackage[UTF8]{ctex}

\begin{document}

使用 ctex 支持中文输入！

\end{document}
</pre>

效果如下：

<center>![khandout](http://elegantlatex.org/wp-content/uploads/2014/10/guide.jpg)</center>

此类文件有两个选项，分别为 `colored`（默认） 与 `nocolored`，后者可以用于打印。

[download info="khandout cls 文件" time="2014-10-07" cat="项目线"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/10/handout.zip" target="_blank">本站下载</a>
[/download]
