第一次见 pdfscreen 是在现代数学老师的课堂上，最初是以为该宏包是用来做 Presentation 的。但其实 pdfscreen 宏包是用来让输出的 pdf 文档在保持通用文档可打印特性的同时适应在屏幕上显示。该宏包的功能主要是通过重定义页面的边距以及高度和宽度来实现。通过调整宏包选项，可以方便的实现从打印文档到显示文档之间的转换。首先我们来看一个简单的例子：

<pre class="lang:tex decode:true " >
\documentclass[a4paper,11pt]{article}
\usepackage{xspace,colortbl}
\usepackage[panelleft,chocolate,paneltoc,screen]{pdfscreen}
\margins{.75in}{.75in}{.75in}{.75in}
\screensize{6.25in}{8in}
\begin{document}
Example!
\end{document}
</pre>

在该示例中，我们使用了 pdfscreen 宏包，并且开启了 screen 选项，这就是说我们希望得到的输出是适合在屏幕上显示的。编译完后结果如图：

<center>![screen](http://elegantlatex.org/wp-content/uploads/2014/10/screen.jpg)</center>

当我们使用 print 选项时，我们可以得到适合打印的 pdf 输出

![print](http://elegantlatex.org/wp-content/uploads/2014/10/print.jpg)

使用 pdfscreen 宏包时，我们还可以在面板上添加自定义文本以及图片按钮，命令形式如下

<pre class="lang:tex decode:true " >
\addButton{hlengthi}{hbutton text stringi}
\imageButton{hwidthi}{hheighti}{hgraphic file name}
</pre>

需要注意的是，使用上述命令添加的按钮是在文档内部，而不是导航条上。一般来说，用 pdfscreen 来制作幻灯片时，预定义的按钮已经足够。pdfscreen 也可以用来制作幻灯片，通过下面的代码(头文件与上个示例一样)即可制作出简单的幻灯片。

<pre class="lang:tex decode:true " >
\begin{document}
\begin{slide}{Example Slides}
\begin{itemize}
\item item 1
\item item 2
\item item 3
\end{itemize}
$$e = mc^{2}$$
\end{slide}
\end{document}
</pre>

在第一次见到人使用 pdfscreen 时所有的按钮上的文字都是汉字，但将按钮汉化的代码较为复杂，这里提供一个由游道德提供的按钮汉化模板[下载链接](http://pan.baidu.com/s/1dDEM5Br) ，基本原理是通过重定义导航面板上按钮的名称得到。另外由于其在模板中使用的是CJK宏包来进行重定义，导致代码看起来比较吓人。下面是该模板的效果图。

<center> ![slides](http://elegantlatex.org/wp-content/uploads/2014/10/slides.jpg) </center>

总的来说 pdfscreen 最大的优势是能方便快捷的实现屏幕显示与打印需求之间的切换，但目前见到大多还是用在幻灯片制作中。如果需要打印幻灯片的话，使用该宏包来制作幻灯片是个不错的选择。需要注意的是，该宏包中使用的是CJK显示中文那一套，如果用ctex宏包的话，会出错。

<center>![chinesepdfscreen](http://elegantlatex.org/wp-content/uploads/2014/10/chinesepdfscreen.jpg)</center>
