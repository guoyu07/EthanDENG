## 简单介绍
本文中所画的两个图均是我在城市经济学 pre 中所用到图，由于几个同学觉得图有学习的价值，特此贴出单独的代码以飨读者。这两个图分别为：

+ 象限图，用于分类讨论使用，特别是 2 个维度的度量可以根据正负性进行讨论；
+ 正态分布图，用于解释标准正态分布曲线的标准差的改变导致的影响。

## 要点过滤
### 定义全局缩放选项

<pre class="lang:tex decode:true " >
 % 定义一个整体的缩放比例参数，否则会导致图形缩放了，而文本没有相等比例的缩放
\tikzset{global scale/.style={
    scale=#1,
    every node/.style={scale=#1}
  }
}
</pre>

### 定义正态分布函数以及求值
<pre class="lang:tex decode:true " >
 % 定义正态分布函数
\pgfmathdeclarefunction{gauss}{2}{%
  \pgfmathparse{1/(#2*sqrt(2*pi))*exp(-((x-#1)^2)/(2*#2^2))}%
}

 % 根据 x 的值，求出正态分布上的点的纵坐标的值
\def\x{-0.5}
\def\fx{1/(1.3*sqrt(2*pi))*exp(-((\x+0.5)^2)/(2*1.3^2))}
</pre>

### 实现层叠效果
<pre class="lang:tex decode:true " >
\visible<n-m>{\tikzcommand;}
</pre>
将 `\tikzcommand` 放在 `visible` 里面，可以实现层叠效果（overlay），其中 `n` 和 `m` 用于声明从第 `n` 张开始显示，到第 `m` 张结束，并且 `n\m` 是指一张 frame 里面的帧数，从 1 开始，如果一直显示，可以不写 `m`。

## 象限图的层叠效果
<pre class="lang:tex decode:true " >
\begin{tikzpicture}[global scale=0.8]
 % 画出两个坐标轴，并标注为 Q0 和 Q1
\draw[->] (-4.2,0) -- (4.2,0) node[below]{$Q_{0}$};
\draw[->] (0,-4.2) -- (0,4.2) node[right]{$Q_{1}$};
\draw (0,0) node[anchor=north west]{$(0,0)$};
 % 填充第一象限
\visible<1->{
\fill[gray,opacity=0.2] (0,0) rectangle (4,4);
\draw (2,2) node[text width=3cm,align=center]{\alert{Postive Selection} $\rho > 1/k \mbox{ and } k > 1$};}
 % 填充第二象限
\visible<2->{
\fill[gray,opacity=0.2] (0,0) rectangle (-4,-4);
\draw (-2,-2) node[text width=3cm,align=center]{\alert{Negative Selection} $\rho > k \mbox{ and } k < 1$};}
 % 填充第三象限
\visible<3->{
\fill[gray,opacity=0.2] (0,0) rectangle (-4,4);
\draw (-2,2) node[text width=3cm,align=center]{\alert{Refugee Sorting} $\rho < \min\{1/k,k\}$}; }
 % 填充第四象限 + 两个直线
\visible<4->{
\fill[gray,opacity=0.2] (0,0) rectangle (4,-4);
\draw (0.2,-0.2) -- (3.8,-3.8);
\draw (3.8,-0.2) -- (0.2,-3.8);
\draw (2,-2) node[text width=5cm,align=center]{\alert{Theoretically Impossible} };}
 % 填充第一、第四象限
\visible<5-6>{
\fill[blue,opacity=0.5] (0,-4) rectangle (4,4);
\draw (2,0) node[text width=3cm,align=center]{\textcolor{white}{Upper tail of home country} };}
 % 填充第二、第三象限
\visible<6-6>{
\fill[blue,opacity=0.5] (0,-4) rectangle (-4,4);
\draw (-2,0) node[text width=3cm,align=center]{\textcolor{white}{Lower tail of home country} };}
 % 填充第一、第二象限
\visible<7-8>{
\fill[magenta,opacity=0.4] (-4,0) rectangle (4,4);
\draw (0,1) node[text width=3cm,align=center]{\textcolor{blue}{Outperform the native population} };}
 % 填充第三、第四象限
\visible<8-8>{
\fill[magenta,opacity=0.4] (-4,0) rectangle (4,-4);
\draw (0,-1) node[text width=3cm,align=center]{\textcolor{blue}{Not well performed  in U.S. labor market} };}
\end{tikzpicture}
</pre>

效果如下：
<center>![panel](http://ddswhu.com/wp-content/uploads/2015/05/panel.png)</center>

## 正态分布曲线的层叠
<pre class="lang:tex decode:true " >
\begin{tikzpicture}[global scale = 0.85]
 % 画出坐标轴，不需要 x 和 y 的轴线，不标注
\begin{axis}[axis x line=none, axis y line = none,xtick=\empty,ytick=\empty,every axis plot post/.append style={domain=-5:5,samples=50,smooth}]
  \addplot[magenta] {gauss(1,0.9)}; % 添加正态分布曲线 1
  \addplot[blue] {gauss(-0.5,1.3)}; % 添加正态分布曲线 2
  \draw (axis cs:-5,0) -- (axis cs:5,0); % 添加一根直线，作为轴线的替代
  
  \draw[dashed] (axis cs:{\x},{\fx}) -- (axis cs:{\x},0) node[below]{$\mu_{0}+\pi$}; % 从正态分布 1 的顶端画一根垂线下来，交于 x 轴
  \draw[dashed] (axis cs:{\y},{\fy}) -- (axis cs:{\y},0) node[below]{$\mu_{1}$}; % 从正态分布 2 的顶端画一根垂线下来，交于 x 轴
  \node at (axis cs: -3, 0.3){$\sigma_{1} < \sigma_{0}$}; % 文本标注
  
  \only<2->{\addplot[blue] {gauss(-0.5,1.8)}; % 添加另外一根正态分布曲线
  \node at (axis cs: -3, 0.2){\textcolor{blue}{$\sigma_{0}^{\prime} > \sigma_{0}$}};}
\end{axis}
\end{tikzpicture}
</pre>

效果如下：
<center>![normal](http://ddswhu.com/wp-content/uploads/2015/05/normal.png)</center>

[download info="完整绘图代码" time="2015-05-31" cat="绘图"]
<a href="http://stack.ddswhu.com/LaTeX/TikZ/TikZ_Beamer/beamer_tikz.tex" target="_blank">点击下载</a>
[/download]
