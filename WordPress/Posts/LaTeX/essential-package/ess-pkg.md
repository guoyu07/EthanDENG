本文为翻译改编，欲了解原文，请参看 [9 essential LaTeX packages everyone should use][1]

## 介绍

最开始，我建立这个博客是为了帮助 LaTeX 的新手，但后来随着 [howtoTeX.com][2] 的建立，博客的受众变得更广了，在我看来，这也不是件坏事。你所面临的挑战只会让你一直努力向前！然而，今天，这篇文章对于新手来说是非常有用的(译者注：对于我们国内大部分人来说都是值得一看的)，在这篇文章中，我总结了每个 
LaTeX 用户都应该使用的 9 个宏包！让我们开始吧！

宏包的顺序与其重要性无关，顺序是完全随机的。每节的首行是我调用宏包的常用方式，仅作参考！

### amsmath

<pre class="lang:tex decode:true " >
\usepackage{amsmath}
</pre>

`amsmath` 宏包是 AMS（美国数学协会）系列宏包中最重要的宏包，这个宏包引入了一些改进的数学环境。比如：加载 `amsmath`之后，我们可以使用 `align` 环境。我所有的行间公式都使用了 `align` 环境 (或者无编号版的 `align*` 环境)，即便有时候公式不需要对齐。Lars Madsen 在 *PracTeX* 杂志上有篇文章也鼓励使用 `amsmath` 宏包的环境，详细参看 [Avoid eqnarray!
][3]。

### geometry
<pre class="lang:tex decode:true " >
\usepackage[a4paper]{geometry}
</pre>
使用 `geometry` 宏包来调整页面的页边距非常方便。整个文档默认的页边距可以通过这个宏包的选项来改变（置于`\usepackage` 之后的方括号内，比如 `a4paper`），大部分情况下，我使用这个宏包（使用 `a4paper` 选项）来创建 A4 纸张以及相应的页边距。使用这个宏包，我们也可以改变某个特定页面的页边距，[howtoTeX.com][2] 上另外一篇文章介绍了怎么使用 `geometry` 宏包重新设定文档奇偶页的边距，详情参看 [Two-sided LaTeX page margins][4]。

### graphicx

<pre class="lang:tex decode:true " >
\usepackage{graphicx}
</pre>

关于 `graphicx` 没啥特别的，但是它可能是所有宏包中最重要的宏包，这个宏包引入了插图命令 `\includegraphics`，我们的文档如果需要插图都将用到它。

### nag 

<pre class="lang:tex decode:true " >
\RequirePackage[l2tabu, orthodox]{nag}
</pre>

事实上，如果你的代码没问题，这个宏包将不会做任何事情。**注意**：把这个宏包放在你的导言区的第一行（甚至在 `\documentclass` 之前）。它将会检测你文档中是否使用已经被淘汰了的宏包以及过时的命令，`nag` 的文档说明可以访问 [CTAN-nag][5]。

### microtype

<pre class="lang:tex decode:true " >
\usepackage{microtype}
</pre>

`microtype` 宏包可以改善了单词、字母的间距。它可能做了很多，但是大部分人察觉不到使用它之后文档的变化。但至少，加载了 `microtype` 之后，文档看起来更好，也更容易阅读。**注意**：如果有使用到字体宏包，需要将 `microtype` 宏包放在它们的后面，因为这个宏包对单词、字母的调整和字体是有关的。

### siunitx

<pre class="lang:tex decode:true " >
\usepackage{siunitx}
</pre>

`siunitx` 宏包大大简化了写作科技文的 TeX 命令，科技文写作中很大一部分是单位、数字。这个宏包添加了一些命令，比如 `\num`命令可以输出我们想要的各种方式的数字形式（比如科学记数法），而 `\si` 命令用来输出单位。我经常用到的命令是 `\SI` 和 `\SIrange`。比如 `\SI{10}{\hertz}` 输出为 “10Hz”（这能有效避免输入错误，我可能会写成 HZ 或者 hz 而不是 Hz）。`\SIrange` 命令多一个参数：`\SIrange{10}{100}{\hertz}` 输出为 “10Hz to 100Hz”。


### cleveref

<pre class="lang:tex decode:true " >
\usepackage{cleveref}
</pre>

另外一个非常有吸引力的宏包是 `cleveref`。这个宏包引入了 `\cref` 命令，当使用这个命令用于交叉引用的时候（而不是 `\ref` 或者 `\eqref`），根据引用的不同，它会自动添加一个单词前缀，引用 `figure` 环境，它会自动添加 “fig.”,而对于 `equation` 环境，它会自动添加 “eq.”。因此，这是一个用来简化写作的 LaTeX 宏包。之前有篇文章介绍了 `cleveref` 宏包，在那篇文章中，展示了如何修改引用对象前面的单词（比如 fig,eq），详情参看[Automatic, clever references with cleveref][6]


### hyperref

<pre class="lang:tex decode:true " >
\usepackage[colorlinks=false, pdfborder={0 0 0}]{hyperref}
</pre>

`hyperref` 非常强大，你可以有非常多的可能性，其中最突出的特色是超链接。当引用一幅图的时候，引用与图形形成了链接，当你点击引用的地方，它会跳转到链接的图片处。并且 `hyperref` 可以让你插入 PDF 元数据到你的最终文档中。**注意**：作为一个经验法则，你应该在导言区的最后加入这个宏包，在所有宏包之后。也存在少数例外的情况：比如，本文提到的 `cleveref` 宏包，`cleveref`宏包应该在 `hyperref` 之后。更多的例外情况可以参看：[pkg load after hyperref][7]。

### booktabs

<pre class="lang:tex decode:true " >
 \usepackage{booktabs}
 </pre> 

`booktabs` 宏包可以让我们创建没有竖线分隔的表格，这些分隔线在很多情况下是不必要的，并且很难看。使用 `booktabs` 宏包创建表格比创建普通 LaTeX 表格更费劲。因此，我专门写了一篇文章，关于怎样使用 `booktabs` 宏包创建好看的表格，详情参看 [create nice tables with booktabs][8]


## 示例下载

我这里写了一个示例，主要是导言区部分，在这个示例文件中，上述所有的宏包都加载进去了，Happy TeXing!

[file]

## 译者按

这篇文章是 2 年前的，来自未来的你可能会发现某些宏包已经被淘汰了，或者某些宏包的选项已经改变，或者有更好的宏包选择，欢迎发表您的见解，本文仅为抛砖引玉之用！

[1]: http://www.howtotex.com/packages/9-essential-latex-packages-everyone-should-use/ "9 essential LaTeX packages everyone should use"
[2]: http://www.howtotex.com/ "HowtoTeX.com"
[3]: http://www.tug.org/pracjourn/2006-4/madsen/madsen.pdf "Avoid eqnarray!"
[4]: http://www.howtotex.com/tips-tricks/two-sided-latex-page-margins/ "Two-sided LaTeX page margins"
[5]: http://ctan.org/pkg/nag "pkg nag"
[6]: http://www.howtotex.com/packages/automatic-clever-references-with-cleveref/ "Automatic, clever references with cleveref"
[7]: http://tex.stackexchange.com/questions/1863/which-packages-should-be-loaded-after-hyperref-instead-of-before "pkg load after hyperref"
[8]: http://www.howtotex.com/packages/improve-your-tables-with-booktabs/ "create nice tables with booktabs"
