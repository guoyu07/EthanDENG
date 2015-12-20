## 为何要用 R 下载文件

使用 R 下载文件的主要理由有以下两点

+ 在 R 函数中使用文件下载命令，在后期不需要手动下载，避免文件遗失，使 R 函数能独立存在。
+ 在碰到有规律的文件列表下载的时候，避免重复点击下载，减少工作量（偷懒）。

## R 中两个下载的函数

### download.file 失灵

最早接触这个命令是在 Coursera 上一个教程上，但是，实际上，这个默认的命令我却怎么用不了，这个命令和 系统（win\linux\mac） 有关，还和 http\https 协议有关，在做作业的时候发现这个命令在 win8\64 位下没法下载，或者下载之后是破损的文件。

### download 函数

后来发现有人开发了一个包叫 `downloader` ，使用这个包的函数 `download` 可以正确下载文件，而且，`download` 和 `download.file` 参数是一致。下载并加载 `downloader` 包使用

<pre class="lang:r decode:true " >
    install.packages("downloader")
    library(downloader)
</pre>

## 单个文件下载示例

### 下载 csv 文件

<pre class="lang:r decode:true " >
    furl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download(url=furl,destfile="./asc.csv")
</pre>

### 下载 PDF 文件示例

<pre class="lang:r decode:true " >
    purl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
    download(url=purl,destfile="codebook.pdf",mode="wb")
</pre>

### 下载 Excel 文件（2010\2013版本）

<pre class="lang:r decode:true " >
    xurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    download(url=xurl,destfile="./nga.xlsx",mode="wb")
</pre>

## 批量文件下载

我这里刚好找到有一个很好的例子，GRE 词汇的 mp3 文件，[下载传送门](http://download.dogwood.com.cn/online/grechjx/index.html)。 总共有 42 个 mp3，而且名字很整齐，`WordList01.mp3`、`WordList13.mp3` 等等，当然我们可以通过浏览器或者下载器（比如旋风）来下载，但是我没找到能够一次性下载全部的文件的方法。

我想到了 R 的文件下载函数 `download`，而且方法也很简单，就写了下，最后成功了，一次性全部下载完毕，总共，也没有损坏，总共 510 MB，花了 19 分钟，平均速度 458kb/s。

<pre class="lang:r decode:true " > 
 # for the first time to use the pkg,
 # install the pkg
install.packages("downloader")

 # load the pkg
library(downloader)

 # choose wd dir to store the download files
setwd("E:/Sola/R/download")

 # the num and char index of files
index <- 1:42
cindex <- as.character(index + 100)
dindex <- substr(cindex,2,3)

 # create the file list
fileindex <- paste("WordList",dindex,".mp3",sep="")

 # create the url list
urlindex <- paste("http://download.dogwood.com.cn/online/grechjx/",fileindex,sep="")

 # download the mp3 files
for (i in index) {
    download(url = urlindex[i],destfile = fileindex[i],mode="wb")
    }
</pre> 

[file]      

## 注意事项

+ 二进制文件需要使用参数：`mode="wb"`，
+ 在某些情况下把 `https` 改为 `http` 是必要的。

## 扩展阅读：

纯文本文件（text file）与二进制文件（binary file）:[二进制文件](http://baike.baidu.com/view/1473761.htm?fr=aladdin)


