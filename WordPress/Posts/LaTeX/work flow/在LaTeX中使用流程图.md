# 在 LaTeX 中使用流程图

流程图是表达算法思想最为有效的图形工具。作为计算机专业的学生，我们经常需要在文档中使用流程图来描述算法。在 LaTeX 中使用流程图可以通过 Ti*k*Z 或 flowchart 宏包来实现，但从本质上来说 flowchart 宏包也是使用 Ti*k*Z 宏包来实现的。下面分别通过一个简单的例子来对这两种方法进行说明。

## 使用 flowchart 宏包绘制流程图

flowchart 宏包根据 IBM 提出的流程图标准，定义了流程图中最常用的五种标准形状，包括：
1. PROCESS: 一切函数过程
2. DECESION: 条件判断
3. PREDEFINED　PROCESS：预定义过程
4. STORAGE: 数据存储
5. TERMINAL: 开始，结束

下面，我们通过一个简单的示例代码来说明，请注意看代码中的注释

     %!TEX program = xelatex
     % 使用 ctexart 文类，UTF-8 
     % 作者：王泽宇
    \documentclass[UTF8]{ctexart}
    \usepackage{tikz,mathpazo}
    \usetikzlibrary{shapes.geometric, arrows}
    \usepackage{flowchart}
    \begin{document}
    \begin{tikzpicture}[font={\sf \small}]
    \def \smbwd{2cm}
    \thispagestyle{empty}
  
     %定义流程图的具体形状
    \node (start) at (0,0) [draw, terminal,minimum width=\smbwd, minimum height=0.5cm] {开始};      % 定义开始 
    \node (getdata) at (0,-1.5) [draw, predproc, align=left,minimum width=\smbwd,minimum height=1cm] {读取数据};        %定义预处理过程，读取数据
    \node (decide) at (0,-3.5) [draw, decision, minimum width=\smbwd, minimum height=1cm] {判断条件};    %定义判断条件
    \node (storage) at (0,-5.5) [draw, storage, minimum width=\smbwd, minimum height=1cm] {数据存储};     %定义数据存储
    \node (process) at (3,-5.5) [draw, process, minimum width=\smbwd, minimum height=1cm] {处理过程};      %定义处理过程
    \coordinate (point1) at (0,-6.75);
    \node (end) at (0,-7.75) [draw, terminal,minimum width=\smbwd,minimum height=0.5cm] {结束};        %定义结束

     %连接定义的形状，绘制流程图--表示垂直线，|表示箭头方向
    \draw[->] (start) -- (getdata);
    \draw[->] (getdata) -- (decide);
    \draw[->] (decide) -| node[above]{是} (process);
    \draw[->] (decide) -- node[above]{否}(storage);
    \draw[->] (process) |- (point1);
    \draw[->] (storage) -- (point1) -- (end);
    \end{tikzpicture}
    \end{document}

以上代码编译结果如图

<center>![flowchart1.jpg](http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/flowchart.jpg)</center>

使用 flowchart 和 Ti*k*Z 绘制流程图，主要包括两个步骤：

+ 绘制流程图的具体形状。该过程主要是利用 flowchart 宏包的预定义形状，根据流程图具体需要实例化，即定义形状的大小，高度宽度等信息。定义形状时，有一点需要注意的是，在需要使用折线时，需要定义折线的转折点，如示例中的 point1 。
+ 将形状使用线连接，得到流程图。这部分比较简单，只要记住线和箭头的表示方法即可。


## 直接使用 Ti*k*Z 宏包绘制流程图。

flowchart 定义的形状数量比较少，可能满足不了绘制复杂流程图的需要，我们还可以直接使用 Ti*k*Z 强大的绘图功能来实现流程图的绘制。还是先看示例代码，配合注释，再进行讲解吧。 


     %!TEX program = xelatex
     % 使用 ctexart 文类，UTF-8 编码
     % 作者：王泽宇
    \documentclass[UTF8]{ctexart}
    \usepackage{tikz,mathpazo}
    \usetikzlibrary{shapes.geometric, arrows}
    \begin{document}
    \thispagestyle{empty}
     % 流程图定义基本形状
    \tikzstyle{startstop} = [rectangle, rounded corners, minimum width=3cm, minimum height=1cm,text centered, draw=black, fill=red!30]
    \tikzstyle{io} = [trapezium, trapezium left angle=70, trapezium right angle=110, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=blue!30]
    \tikzstyle{process} = [rectangle, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=orange!30]
    \tikzstyle{decision} = [diamond, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=green!30]
    \tikzstyle{arrow} = [thick,->,>=stealth]

    \begin{tikzpicture}[node distance=2cm]
     %定义流程图具体形状
    \node (start) [startstop] {Start};
    \node (in1) [io, below of=start] {Input};
    \node (pro1) [process, below of=in1] {Process 1};
    \node (dec1) [decision, below of=pro1, yshift=-0.5cm] {Decision 1};
    \node (pro2a) [process, below of=dec1, yshift=-0.5cm] {Process 2a};
    \node (pro2b) [process, right of=dec1, xshift=2cm] {Process 2b};
    \node (out1) [io, below of=pro2a] {Output};
    \node (stop) [startstop, below of=out1] {Stop};

     %连接具体形状
    \draw [arrow](start) -- (in1);
    \draw [arrow](in1) -- (pro1);
    \draw [arrow](pro1) -- (dec1);
    \draw [arrow](dec1) -- (pro2a);
    \draw [arrow](dec1) -- (pro2b);
    \draw [arrow](dec1) -- node[anchor=east] {yes} (pro2a);
    \draw [arrow](dec1) -- node[anchor=south] {no} (pro2b);
    \draw [arrow](pro2b) |- (pro1);
    \draw [arrow](pro2a) -- (out1);
    \draw [arrow](out1) -- (stop);
    \end{tikzpicture}
    \end{document}

以上代码编译结果如图

<center>![flowchart2.jpg](http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/flowchart2.jpg)</center> 

## 方法比较

比较两个方法的代码可知，相比使用 flowchart 宏包，直接使用 Ti*k*Z 绘制流程图多了定义基本形状一步。但通过 Ti*k*Z 自己定义基本形状，流程图的可定制性更好，可以根据具体需要，定义多种流程图形状。另外一个使用 flowchart 宏包来绘制，最终还是需要用到 Ti*k*Z 语法，也不见得有多简单。因此，推荐使用 Ti*k*Z 直接绘制流程图。另外，在很久之间，还有一个名为 nassflow 的宏包也可以实现流程图的绘制，但在目前的几个留下的 LaTeX 的发行版中，都没有预装该宏包，因此，在这里也就不做说明了。
