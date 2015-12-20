## downloadhelper 介绍

本 R 文件主要目的是方便下载，本文件定义了三个函数，分别为

+ `pkgtest`：检测是否已经安装某个宏包，参数为宏包名（参数：字符常量）
+ `transform`：数值索引转换为统一位数格式（参数1：数值索引；参数2：位数）
+ `downloader`：下载文件函数（参数见下文）

### 辅助函数示例

<pre class="lang:r decode:true " >
> pkgtest("xtable")
[1] "The required packages have been installed"
> index <- 1:24
> transform(index, ndigits=3)
 [1] "001" "002" "003" "004" "005" "006" "007" "008" "009" "010" "011" "012"
[13] "013" "014" "015" "016" "017" "018" "019" "020" "021" "022" "023" "024"
</pre>

## 核心函数 downloader 参数说明

+ `urlpre`：字符参数，下载文件网址不含文件名部分，必选参数
+ `index`： 文件名索引，不含拓展名，必选参数，可以为字符向量或者数值向量
+ `transform`：逻辑参数，补零转换，默认 `transform = FALSE`
+ `ndigits`：数值参数，总位数，比如需要得到 012，则 `ndigits=3`，默认 `ndigits=2`
+ `filepre`：字符参数，文件名前缀，比如 `chap`，默认为空
+ `filetype`：字符参数，文件类型，文件拓展名，默认 `filetype="pdf"`

## 注意事项：

+ 函数核心使用了 `downloader` 包，函数会自动检测是否已经安装了这个包，如果没有，则会提示安装。
+ 索引转换是指：有些文件名使用了 05、013 这种形式的名字，函数将 5、13 自动转换为 05、013 形式。
+ 已经测试过的可以支持的文件格式（`filetype` 参数）有：pdf,csv,R,text,tex,xlsx,xls,m,mp3
+ 如果下载文件列表内文件地址不能访问（失效或者不存在），下载过程都会被中断，要继续下载，需要修改索引 index。

## 文件下载示例

### PDF 文件下载

相关网页：[http://www.math.upenn.edu/~guffin/teaching/fall10/](http://www.math.upenn.edu/~guffin/teaching/fall10/)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://www.math.upenn.edu/~guffin/teaching/fall10/lectures/"
index <- 2:4
downloader(urlpre,index,ndigits=2,transform=TRUE,filepre="lecture-",filetype="pdf")
</pre>

### R 文件下载
相关网页：[http://www.rni.helsinki.fi/~pek/r-koulutus/index.html](http://www.rni.helsinki.fi/~pek/r-koulutus/index.html)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://www.rni.helsinki.fi/~pek/r-koulutus/"
index <- c("hello","rintro","fname-esim")
downloader(urlpre,index,filetype="R")
</pre>

### txt 文件下载

相关网页：[http://www1.umn.edu/statsoft/doc/statnotes/](http://www1.umn.edu/statsoft/doc/statnotes/)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://www1.umn.edu/statsoft/doc/statnotes/"
index <- 1:8
downloader(urlpre,index,transform=TRUE,ndigits=2,filepre="stat",filetype="txt")
</pre>

### LaTeX 文件下载

相关网页： [https://gitorious.org/pkuthss/pkuthss/source/1bb0c28e36e7ddb7d6db0009a1d154e1e3ef4c6c:doc/chap](https://gitorious.org/pkuthss/pkuthss/source/1bb0c28e36e7ddb7d6db0009a1d154e1e3ef4c6c:doc/chap)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "https://gitorious.org/pkuthss/pkuthss/raw/1bb0c28e36e7ddb7d6db0009a1d154e1e3ef4c6c:doc/chap/"
index <- 1:3
downloader(urlpre,index,filetype="tex",filepre="chap")
</pre>

### Excel 表格下载

相关网页：[http://www.pbc.gov.cn/publish/html/kuangjia.htm?id=2012s07.htm](http://www.pbc.gov.cn/publish/html/kuangjia.htm?id=2012s07.htm)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://www.pbc.gov.cn/publish/html/"
index <- 5:8
downloader(urlpre,index,transform=TRUE,filetype="xls",filepre="2012s")
</pre>

### Matlab m 文件下载

相关网页：[http://www.rni.helsinki.fi/~pek/software.html](http://www.rni.helsinki.fi/~pek/software.html)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://www.rni.helsinki.fi/~pek/software/smoothing/"
index <- c("llrev","llrcvev","llrssev","llrrev","llrrcvev","llrrssev","knnev","knncvev","knnssev","demo")
downloader(urlpre,index,filetype="m")
</pre>

### MP3 文件下载

相关网页：[http://download.dogwood.com.cn/online/grechjx/index.html](http://download.dogwood.com.cn/online/grechjx/index.html)

<pre class="lang:r decode:true " >
source("downloadhelper.R")
urlpre <- "http://download.dogwood.com.cn/online/grechjx/"
urlindex <- 4:6
downloader(urlpre,index,ndigits=2,transform=TRUE,filepre="WordList",filetype="mp3")
</pre>

## 2.0 版本更新

更新内容：新增函数 tdownloader，只需两个参数

+ `url` ：文件下载示例网址，具有代表性的网址。
+ `index` ：文件索引，同 downloader 函数参数。
+ 其他函数保持不变，也即之前函数仍然可以使用。
+ 函数支持三类下载地址，详情参看下载示例

### 下载示例

**索引类型 1：常规字符文件列表**

<pre class="lang:r decode:true " >
source("downloadhelper.R")
url <- "http://www.rni.helsinki.fi/~pek/software/smoothing/llrev.m"
index <- c("llrev","llrcvev","llrssev","llrrev","llrrcvev","llrrssev","knnev","knncvev","knnssev","demo")
tdownloader(url,index)
</pre>

**索引类型 2：含字符+常规数字文件**

<pre class="lang:r decode:true " >
url <- "https://gitorious.org/pkuthss/pkuthss/source/1bb0c28e36e7ddb7d6db0009a1d154e1e3ef4c6c:doc/chap/chap1.tex"
index <- 1:3
tdownloader(url,index)
</pre>

**索引类型 3：含字符+统一格式数字文件**

<pre class="lang:r decode:true " >
source("downloadhelper.R")
url <- "http://www1.umn.edu/statsoft/doc/statnotes/stat01.txt"
index <- 1:8
tdownloader(url,index)
</pre>

## 更新日志

+ 2014-09-06：创立文件，内含 pkgtest\transform\downloader 函数
+ 2014-09-07：新增 tdownloader 函数，减少参数（皈颖协助）。

[file]

