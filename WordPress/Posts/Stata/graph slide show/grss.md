## 图形覆盖问题 
刚开始接触 Stata 画图的时候，经常会被一个问题所困扰：在同一个 do 文件中，如果出现两条及两条以上的画图命令时，Stata 画图会自动覆盖之前的画图输出结果，只输出最后一个画图结果。在面对这种情况的时候，总不能一条一条选择命令执行吧，这种方法太过耗时耗力，点着点着，可能就变鼠标手了！今天，就给大家详细介绍一种简单粗暴的解决方法！

## 解决方法

以坊间流传甚广的 Stata 教材——中国人民大学陈传波老师的 Stata 十八讲中 157 页模拟白噪声的程序为例。

### 准备
在此之前，我们先安装模拟 ARMA 过程的一个包，安装步骤如下：
<pre class="lang:default decode:true " >
search sim_arma,net
</pre>
选择一个链接，然后选择右下角 `(click here to install)`即可安装完成。

### 问题重现
陈老师提供的 do 文件是这样的：
<pre class="lang:default decode:true " >
set seed  1234
drawnorm  x , n( 691 ) sds( 3 ) clear
set seed  1234
sim_arma  y , sigma( 3 ) //注意到x和y两个序列是完全一样的
tsline  y //趋势图
hist y ,bin(50) norm //直方图
sum  y , d //统计该随机过程的分布特征
ttest y==0 //检验零均值
sdtest y==1 //检验方差是否为1
pnorm y, grid //标准正态分布检验
wntestb y //白噪声检验
wntestq y //白噪声检验
corrgram y //Q检验
ac y //自相关图检验
pac y //偏相关图检验
</pre>

运行得到的结果是这样的：
<center>![Single Graph](http://ddswhu.com/wp-content/uploads/2014/12/pac.png)</center>

等等。。。中间的图去哪儿了。。。？ 只看到运行过程中图表不停地闪动，然后就没有然后了。。。

**解释**：在运行的过程中，我们看到整个代码生成了好几张图，但是，每一张图都被后一张所覆盖了，所以到最后我们只看到了 y 偏自相关检验的那张图。

### 解决问题 

为了解决上述问题，在此提供一个简单粗暴的方法 —— grss (graph slide show) 命令。该命令并不是 Stata 自带的，但可以通过下载相关程序包进行安装。具体步骤如下：（傻瓜式教学，求轻拍）

+ 在代码窗口键入 `findit grss`，
+ 选择其中一个链接，点击右下角 `(click here to install)` 安装即可
+ 将之前代码中需要画图的语句前加上 grss 并点击执行，新技能 get√！

**备注**：图文安装教程参看 [findit help](http://www.ats.ucla.edu/stat/Stata/faq/findit.htm)。

### 新的世界

我们把原来的代码修改得到新的代码：
<pre class="lang:default decode:true " >
set seed  1234
drawnorm  x , n( 691 ) sds( 3 ) clear
set seed  1234
sim_arma  y , sigma( 3 ) //注意到x和y两个序列是完全一样的
grss tsline  y //趋势图
grss hist y ,bin(50) norm //直方图
sum  y , d //统计该随机过程的分布特征
ttest y==0 //检验零均值
sdtest y==1 //检验方差是否为1
grss pnorm y, grid //标准正态分布检验
grss wntestb y //白噪声检验
wntestq y //白噪声检验
corrgram y //Q检验
grss ac y //自相关图检验
grss pac y //偏相关图检验
</pre>

此时我们得到了六张图，效果如下：
<center>![Graph grss](http://ddswhu.com/wp-content/uploads/2014/12/graph-grss.jpg)</center>

### 广告时间
此外，推荐下载 [程序集](http://www.ats.ucla.edu/stat/Stata/ado/copyatslocal.htm上atsado2014.zip)，并按照说明安装。[http://www.ats.ucla.edu/stat/](http://www.ats.ucla.edu/stat/) 是一个学习各类统计软件的必备良品，强推！

## 感谢

感谢 YPY 同学的悉心整理，欢迎大家荐稿投稿！
