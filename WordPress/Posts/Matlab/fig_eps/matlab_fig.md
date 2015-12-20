## 关于 eps 的澄清

eps 是矢量图的一种，由于网上的资料繁杂，使不少 LaTeX 用户产生了一个误解：LaTeX 只支持 eps 插图，实际上，LaTeX 对 eps 的支持并不好，我们插入 eps 图片有如下两种常用方式：

+ `latex` 编译方式（`latex` -> `dvipdf` 或者 `latex` -> `dvips` -> `ps2pdf`）
+ `pdflatex` 编译方式（`pdflatex` 或者 `TeXfify`）+ `epstopdf` 宏包

而且，eps 插图经常碰到两个问题，第一个是 `No Bounding Box`，第二个是，`eps` 周边空白太大，无法处理。对此，我们有如下建议：

+ 使用 `graphicx` 宏包，支持 jpg\png\pdf 等格式图片
+ 在保证矢量图的效果的前提下，优先使用 pdf 格式图片
+ 除非投稿时，杂志社要求 eps，尽量避免 eps 插图。

实际上，LaTeX 对 pdf 支持最好，而且 pdf 具有 eps 所具有的 “矢量” 特性。

如果碰到杂志社只接受 eps 图片，勤劳的小 L 提供了一个批量将位图转化为 eps 图档的工具，参见[这里](http://elegantlatex.org/2014/08/21/bitmap-convert-to-eps-batch/)，原文载于[LiamHuang](http://liam0205.me/2014/08/21/bitmap-convert-to-eps-batch/)。

## Matlab 图片问题

用过 Matlab 作图的人都知道，Matlab 作图时，虽然图形窗里面能正确显示中文，将图片另存为位图格式，比如 jpg 或者 png 的时候不会出现乱码，但是另存为 eps 之后中文会出现乱码，导出的 pdf 也都是乱码。由于我们想要的是矢量图，所以位图导出暂时不考虑。之前也有好些人在 LaTeX 群里问到这个问题。

## 屡试不爽的王道方法

本文提供一种解决方式：
 
+ 使用虚拟打印机将图片打印成 pdf，这个时候大部分图片应该是高保真的 pdf 矢量图
+ 然后使用 pdf 裁剪工具，将 pdf 周围多余的空白裁掉。
+ 如果需要 eps 图档，将 pdf 转成 eps，这样就 OK 了。

实际运用中，PDF 虚拟打印机有好多，Foxit * PDF Printer(小巧)、Adobe PDF；裁剪工具我们尝试过的有 Adobe Acrobat、Adobe PhotoShop（导入之后有点失真，不知道有没有好办法）。

实例如下，Matlab 的绘图代码如下：

<pre class="lang:matlab decode:true " >
t=0:.01:2*pi;
x=cos(2*t).*(cos(t).^2);
y=sin(2*t).*(sin(t).^2);
comet(x,y);
title('二维彗星轨迹图')
hold on
plot(x,y)
</pre>

打印成 pdf 之后进行裁剪之后如下：

<center>![comet](http://elegantlatex.org/wp-content/uploads/2014/10/comet.jpg)</center>

### 还有例外？

不过，有些图，使用上面的方式并不是很好，比如 3D 绘图，这里我们仅举一个例子，Matlab 绘图代码如下：

<pre class="lang:matlab decode:true " >
Z=peaks;
surf(Z)
title('绘制网格表面图')
</pre>

并不是说我们的中文显示有问题，而是，在三维图下，打印成 pdf 之后已经不清晰，可能和 pdf 支持有关系，目测存在 pdf 的时候是以位图存储的，导致不太清晰，特别是文字部分。上述命令的图形结果转成 pdf 之后如下：

<center>![surf](http://elegantlatex.org/wp-content/uploads/2014/10/surf.jpg)</center>

### 没辙，只能上邪道了

这里有种方法，将 Matlab 图形窗的图复制（编辑->复制图形）到 MS Word 里面，然后将其存储为 pdf，然后将 pdf 裁剪得到。不过，在保证了矢量的前提下，好像颜色有点发黑（Σ(°△°|||)##）。更多的方法大家去尝试吧，主要保证两个效果

+ 中文不能有乱码
+ 尽量保证矢量效果（pdf\eps）

当然，有人肯定想过：先画图，然后借助其他工具添加中文标题或者 label，这里打个小广告：利用 TikZ 在图中添加标注或者图形，请看 EthanDeng 的博文 [TikZ-over-image](http://ddswhu.com/2014/07/03/tikz-draw-on-image/)

## 结束语

如果不用中文标注也可以，那就用英文吧！
