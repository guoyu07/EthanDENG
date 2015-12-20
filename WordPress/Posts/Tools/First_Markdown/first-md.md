## Markdown 简介

Markdown 的目标是实现「易读易写」。

可读性，无论如何，都是最重要的。一份使用 Markdown 格式撰写的文件应该可以直接以纯文本发布，并且看起来不会像是由许多标签或是格式指令所构成。Markdown 语法受到一些既有 text-to-HTML 格式的影响，包括 Setext、atx、Textile、reStructuredText、Grutatext 和 EtText，而最大灵感来源其实是纯文本电子邮件的格式。

总之， Markdown 的语法全由一些符号所组成，这些符号经过精挑细选，其作用一目了然。比如：在文字两旁加上星号，看起来就像*强调*。Markdown 的列表看起来，嗯，就是列表。Markdown 的区块引用看起来就真的像是引用一段文字，就像你曾在电子邮件中见过的那样。

## 段落文字编写

### 空格与断行 

+ 单个空格与多个空格效果是一样的（单个空格）
+ 单个回车视为空格，多个回车视为断行。

**示例代码**

    单个空格 之后是多个空格   ，虽然有多个空格，显示效果仍然是单个空格，并且，回车视为空格，这里有一个回车
    我们看到，并没有断行，断行需要使用多个回车（习惯性我们用两个回车），比如另起一段如下

    这是一个新段落。

**效果**

单个空格 之后是多个空格   ，虽然有多个空格，显示效果仍然是单个空格，并且，回车视为空格，这里有一个回车
我们看到，并没有断行，断行需要使用多个回车（习惯性我们用两个回车），比如另起一段如下

这是一个新段落。


### 斜体与加粗

*斜体*只需在斜体文字左右加星号（\*）或下划线（\_）即可，而**粗体**需要加双星号（\*\*）或双下划线（\_\_）。

**示例代码**

    *斜体示例 Italic words and sentences*

    _斜体示例 Italic words and sentences_

    **黑体示例 Bold Face samples**

    __黑体示例 Bold Face samples__
 
**效果**

*斜体示例 Italic words and sentences*

_斜体示例 Italic words and sentences_

**黑体示例 Bold Face samples**

 __黑体示例 Bold Face samples__

**注意**： 星号或者下划线应该与斜体或者加粗字体相连，不能有空格。 

### 引用文字

引文使用 \> 开头。
>(这是一段引文)曾经某人说：不想学 Markdown 的设计师不是高效程序员。而如今这句话将由我来散播，希望能深入人心！

## 标题
Markdown 标题等级有六级，从一级标题到六级标题分别由 # 到 ###### 表示。

**示例代码**

    # 一级标题示例
    ## 二级标题示例
    ### 三级标题示例
    ...
    ###### 六级标题，最末等级标题

**效果** （略）

## 列表

列表有两类，分别为有序列表和无序列表，有序列表使用1、2、3 ... 引导，无序列表使用星号（\*）、加号（\+）或者减号（\-）引导，且三者的效果是一样的（同一等级的话）。并且列表之间是可以嵌套的。

**示例代码** （无序列表）

    * Candy.
        + Candy.
        + Gum.
        + Booze.
    * Gum.
        - Candy.
        - Gum.
        - Booze.
    * Booze.

**效果**

* Candy.
    + Candy.
    + Gum.
    + Booze.
* Gum.
    - Candy.
    - Gum.
    - Booze.
* Booze.

**示例代码** （有序列表）

    1. Red
        1. Red
        2. Green
        3. Blue
    2. Green
        + Candy.
        + Gum.
        + Booze.
    3. Blue

**效果**

1. Red
    1. Red
    2. Green
    3. Blue
2. Green
    + Candy.
    + Gum.
    + Booze.
3. Blue

## 超链接
Markdown 支持两种形式的链接语法：**行内**和**参考**两种形式，两种都是使用括号把文字转成链接。

### 行内语法

**示例代码**

    This is an [example link with title](http://example.com/ "标题 Title").

**效果**

This is an [example link with title](http://example.com/ "标题 Title").

说明：行内语法用到了方括号和圆括号，方括号表示链接在网页中的显示效果，而圆括号内为链接地址，使用双引号可以加入链接标题，这个标题是指当我们鼠标停留在链接时，网页上浮动显示的文字，链接标题是 *可选项*，比如：

    This is an [example link without title](http://example.com/).

### 参考语法

参考形式的链接让你可以为链接定一个名称，你可以在文件的其他地方（建议放在文末）定义该链接的内容。

**示例代码**

文中引用部分：

    ElegantLaTeX 的站点链接为 [ElegantLaTeX][1]，其中部分内容来源于 [TeX Stack Exchange][2]，作为更全面的一个站点，我们推荐 [LaTeX Studio][3].

链接参考引用代码（文末）：

    [1]: http://elegantlatex.org/ "ElegantLaTeX"
    [2]: http://tex.stackexchange.com/ "TeX.Stack.Exchange"
    [3]: http://www.latexstudio.net/ "LaTeX Studio"

**效果**

ElegantLaTeX 的站点链接为 [ElegantLaTeX][1]，其中部分内容来源于 [TeX Stack Exchange][2]，作为更全面的一个站点，我们推荐 [LaTeX Studio][3]。


## 插图

图片的语法和链接很像，区别在开头加一个惊叹号\!。同样，图片插入也有两种方式，一种是行内，一种是参考引用。

### 行内语法

**示例代码**

    我们 ElegantLaTeX 的图标是 
    <center>![ElegantLaTeX Logo](http://ddswhu.com/wp-content/uploads/2014/06/logo-ElegantLaTeX.png "ElegantLaTeX Logo")</center>

**效果** 
 

我们 ElegantLaTeX 的图标是 
<center>![ElegantLaTeX Logo](http://ddswhu.com/wp-content/uploads/2014/06/logo-ElegantLaTeX.png "ElegantLaTeX Logo")</center>


### 参考语法

参考语法的格式和超链接的几乎一致，比如我们要显示百度的 Logo 使用下面的代码：

**示例代码**

文中引用部分：

    百度的图标为 <center>![Baidu][4]</center>

**文末代码**

图片参考引用代码（文末）：

    [4]: http://www.baidu.com/img/baidu_sylogo1.gif "百度"

显示效果为

百度的图标为 <center>![LaTeXStudio][4]</center>

## 代码显示

### 行内代码

Markdown 中代码显示比较简单，行内代码使用反引号\` 来标记代码区段。

**代码示例**

    在 LaTeX 中调用宏包的命令为`\usepackage{pkg.name}`，其中 `pkg.name` 为宏包名。

**效果**

在 LaTeX 中调用宏包的命令为`\usepackage{pkg.name}`，其中 `pkg.name` 为宏包名。

### 行间代码

行间代码只要每行都缩进 4 个空格或是一个 tab 就可以了。

**代码示例**

     C++ code

        public class Blog
        {
            public int Id { get; set; }
            public string Subject { get; set; }
        }

**效果**

C++ code
     
    public class Blog
    {
        public int Id { get; set; }
        public string Subject { get; set; }
    }

### \\ 的作用

反斜杠 \\ 可以显示 \*\_\+\-\` 等在 Markdown 中有特殊意义的字符。

## 本文参考

图灵社区：[http://www.ituring.com.cn/article/23](http://www.ituring.com.cn/article/23 "如何使用 Markdown")

Wow Ubuntu：[http://wowubuntu.com/markdown/basic.html](http://wowubuntu.com/markdown/basic.html "Markdown 入门")

---

[1]: http://elegantlatex.org/ "ElegantLaTeX"
[2]: http://tex.stackexchange.com/ "TeX.Stack.Exchange"
[3]: http://www.latexstudio.net/ "LaTeX Studio"
[4]: http://www.baidu.com/img/baidu_sylogo1.gif "百度"
