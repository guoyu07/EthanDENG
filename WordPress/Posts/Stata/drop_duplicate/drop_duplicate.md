## 问题描述
这个问题来源于一个数据，在这个数据中，同一个家庭 ID 下，某个变量有重复值，比如，一个家庭中父亲、母亲同为户主（householder = 1），题主也不知道这是怎么产生的，由于这个问题会造成信息混乱，可能我们需要删除这些信息，或者保留部分信息。我们需要怎么做呢？

## 解决方法
Stata 有一个命令是 `duplicates`，可以用来处理重复信息的问题，我们这里用到的命令就是这个命令，具体说明见例子。

+ `duplicates drop`：这个命令可以把重复信息删除，可以对单变量，也可以对多变量；
+ `duplicates tag`：用于给重复信息的观测贴上一个标签，方便后面的操作。

## duplicates 示例分析

### 示例数据部分

<pre class="lang:default decode:true " >
use http://www.ats.ucla.edu/stat/stata/notes/hsb2,clear
keep id female ses math read `write'
sort id
drop if id > 10
</pre>

我们使用上面的命令得到一个小的数据集，这里面是没有重复值的。

<pre class="lang:default decode:true " >
list in 1/10,noobs
  +------------------------------------+
  | id   female      ses   read   math |
  |------------------------------------|
  |  1   female      low     34     40 |
  |  2   female   middle     39     33 |
  |  3     male      low     63     48 |
  |  4   female      low     44     41 |
  |  5     male      low     47     43 |
  |------------------------------------|
  |  6   female      low     47     46 |
  |  7     male   middle     57     59 |
  |  8   female      low     39     52 |
  |  9     male   middle     48     52 |
  | 10   female   middle     47     49 |
  +------------------------------------+
</pre>

然后我们手动构造 5 个重复值（复制 1-5 行的数据），然后依据 id 来升序排列，并且修改第 1 行的 math 值为 84，这样的话，如果我们以 ID 来判断重复记录的话，重复信息有 5 条，但是，如果我们以 id 和 math 两个变量来判断重复记录的话，重复信息有 4 条。我们将着重考察后者的处理。

<pre class="lang:default decode:true " >
expand 2 if _n <=5
sort id 
replace math = 84 if _n==1
list in 1/15, noobs
  +------------------------------------+
  | id   female      ses   read   math |
  |------------------------------------|
  |  1   female      low     34     84 |
  |  1   female      low     34     40 |
  |  2   female   middle     39     33 |
  |  2   female   middle     39     33 |
  |  3     male      low     63     48 |
  |------------------------------------|
  |  3     male      low     63     48 |
  |  4   female      low     44     41 |
  |  4   female      low     44     41 |
  |  5     male      low     47     43 |
  |  5     male      low     47     43 |
  |------------------------------------|
  |  6   female      low     47     46 |
  |  7     male   middle     57     59 |
  |  8   female      low     39     52 |
  |  9     male   middle     48     52 |
  | 10   female   middle     47     49 |
  +------------------------------------+
</pre>

## duplicates 删除操作
以上部分都是为了得到我们的试验数据集，在实际的过程中，我们待处理的数据肯定已经准备好了，也就不存在上面的步骤。正式的，我们分为两种情况

1. 删除重复信息的一行；
2. 删除重复信息的全部行。

### 删除一行的操作
删除重复行中的一行操作很简单，只需要一个命令
<pre class="lang:default decode:true " >
duplicates drop id math,force
</pre>
这个命令将会依据变量 id 和 math 来判断两个观测（行）是否重复，并且把重复行删除，删除之后的数据变成了 11 行，数据显示如下：

<pre class="lang:default decode:true " >
list,noobs
  +------------------------------------+
  | id   female      ses   read   math |
  |------------------------------------|
  |  1   female      low     34     84 |
  |  1   female      low     34     40 |
  |  2   female   middle     39     33 |
  |  3     male      low     63     48 |
  |  4   female      low     44     41 |
  |------------------------------------|
  |  5     male      low     47     43 |
  |  6   female      low     47     46 |
  |  7     male   middle     57     59 |
  |  8   female      low     39     52 |
  |  9     male   middle     48     52 |
  |------------------------------------|
  | 10   female   middle     47     49 |
  +------------------------------------+
</pre>

### 删除全部重复行的操作
我们可能会觉得这些“重复”行信息存在问题，我们想把这些重复行全部删除，在我们这里，由于根据 id-math 组的重复行总共有 8 条（4*2），总的观测有 15 个，所以，删除全部重复行之后剩下的应该是只有 7 行。命令以及效果如下：

<pre class="lang:default decode:true " >
duplicates tag id math, gen(dup_idmath)
drop if dup_idmath==1
drop dup_idmath
  +------------------------------------+
  | id   female      ses   read   math |
  |------------------------------------|
  |  1   female      low     34     84 |
  |  1   female      low     34     40 |
  |  6   female      low     47     46 |
  |  7     male   middle     57     59 |
  |  8   female      low     39     52 |
  |------------------------------------|
  |  9     male   middle     48     52 |
  | 10   female   middle     47     49 |
  +------------------------------------+
</pre>

**说明**：命令的意思是说，首先我们根绝 id 和 math 两个变量判断是否重复，将重复的行标记为 1，并且生成一个变量 （dup_idmath），然后把 `dup_idmath == 1` 的观测删除，最后再把中间变量 `dup_idmath` 删除。最终是我们需要的结果，目标完成！

## 参考文献
+ [How can I detect duplicate observations?](http://www.ats.ucla.edu/stat/stata/faq/stata_faq_dup.htm)
+ [duplicates manuals](http://www.stata.com/manuals13/dduplicates.pdf)
+ [drop manuals](http://www.stata.com/manuals13/dduplicates.pdf)
+ [drop specific duplicates](http://www.statalist.org/forums/forum/general-stata-discussion/general/276048-drop-specific-duplicates)
