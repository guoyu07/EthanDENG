ElegantLaTeX base 是我们系列模板中广泛使用的一个图案，在之前的模板中，我们使用了 pdf 文件，使用 pdf 很方便，代码也很简单，但是，如果用户要自定义颜色的话，修改 ElegantLaTeX base 将会变得很烦人，需要使用矢量图绘制软件对其修改颜色。考虑到修改颜色的不便之处，我们这里提供了 ElegantLaTeX base 的 Ti*k*Z 实现方式，代码如下：

<pre class="lang:tex decode:true " >
\documentclass{standalone}
 
\usepackage{tikz}
 % tikz setting
\definecolor{main}{RGB}{230,90,7}
\tikzset{x=1pt,y=1pt}
\tikzset{elegant/.style={fill=main,draw=main},
            null/.style={fill=white,draw=white}}            
 % the triangle shape
\newcommand{\triz}[2]{
\begin{scope}[xshift=#1,rotate=#2]
  \draw[elegant] (0,0) -- (105,6) .. controls (119,21) and (132,13) .. (135,12) .. controls (124,15) and (110,8) .. (107,-12) -- cycle;
  \draw[null] (40,-1.5) -- (101,-4) -- (103,1)--cycle;
\end{scope}
}
 % the ellipse shape +127
\newcommand{\ellz}[1]{
\begin{scope}[xshift=#1,yshift=3]
  \draw[elegant,rotate around={60:(0,-3)}](0,-3) ellipse (10.5 and 8.5);
  \draw[null](-3,-10) .. controls (-10,-6)  and (-2,6) .. (4.5,4) .. controls (0,3) and  (-4,-6) .. (-3,-10)--cycle;
\end{scope}
}
 % the integration shape+147
\newcommand{\intz}[1]{
\begin{scope}[xshift=#1,yshift=2]
  \draw[elegant] (-31,-14.5) .. controls (-17,-21)  and (-9,-8) .. (-3,0) .. controls (10,19) and (22,17) .. (29,9) .. controls (21,13) and (13,13) .. (3,-1) .. controls (-4,-11) and (-18,-27) .. (-31,-14.5) -- cycle ;
\end{scope}
}
 
\begin{document}
 
\begin{tikzpicture}
\triz{0}{0}
\ellz{127}
\intz{147}
\ellz{163}
\intz{183}
\ellz{200}
\triz{327}{180}
\end{tikzpicture}
 
\end{document}
</pre>

实现的效果如下：

<center>![ElegantLaTeX base](http://elegantlatex.org/wp-content/uploads/2014/09/base.jpg)</center>

[download info="ElegantLaTeX base" time="2014-03-30" cat="项目线、绘图"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/09/ELTX-Base.zip" target="_blank">本站下载</a>
[/download]
