## 写这个小 code 的缘由
背景：最近一个同学问了 Python 爬虫的问题，我其实 Python 也是初学者，只是之前写过一个简单的爬虫。

本来上午在写半参的东西，快收尾的时候想找“怎么在 R 中较好的输出结果”，结果找到了普林斯顿大学的一个 PDF 教程，翻看了一下觉得很好，然后发现网页上还有些教程（PDF），文件比较多，需要一个一个下载是比较麻烦的。所以，脑袋一残，一短路，我抛弃了我的半参（写完还是要继续的），开始写 Python 的下载工具。

我之前写过一个 R 语言版本的下载辅助工具，参见[R 辅助下载工具 – downloadhelper.R](http://ddswhu.com/2014/09/06/r-download-premium/)，使用说明见[DownloadHelper 用户手册](http://stack.ddswhu.com/R/download/user-guide.pdf)。但由于现在碰到的下载地址的规律性太弱，除了文件地址前部分相同，文件名相差太大，当然也可以使用 R 或者 Python 把文件名弄下来，然后使用上面的工具。

## DownloadHelper.py 函数说明
DownloadHelper 由两部分组成，一是爬下来，二是下下来！其中定义了三个函数，分别是 `getHtml`，`getUrl`，`getFile`。下面将逐一介绍。

### getHtml 函数
<pre class="lang:python decode:true " >
def getHtml(url):
    page = urllib2.urlopen(url)
    html = page.read()
    page.close()
    return html
</pre>

`getHtml` 函数用于读取一个网址的内容，参数为 `url`，返回的是网页的内容（`html`），后者将用于后面使用。

### getUrl 函数
<pre class="lang:python decode:true " >
def getUrl(html):
    reg = r'(?:href|HREF)="?((?:http://)?.+?\.pdf)'
    url_re = re.compile(reg)
    url_lst = re.findall(url_re,html)
    obfile.write('\n'.join(url_lst))
    obfile.write('\n')
    obfile.close()
    return(url_lst)
</pre>

这个函数是最重要的一个函数，首先，参数是上面的返回值 `html`，也即网页的内容，在这部分，主要是将这个网页内容中符合某个特定模式（pattern）的内容找出来，然后写入到目标文件 `obfile` 中，并且返回这些内容的一个列表，实际上就是我们查找的文件的后半部分地址的列表（含文件名）。

### getFile 函数
注：此函数来源于网络，参见 [How do I download a file over HTTP using Python?](http://stackoverflow.com/questions/22676/how-do-i-download-a-file-over-http-using-python)

<pre class="lang:python decode:true " >
def getFile(url):
    file_name = url.split('/')[-1]
    u = urllib2.urlopen(url)
    f = open(file_name, 'wb')
    meta = u.info()
    file_size = int(meta.getheaders("Content-Length")[0])
    print "Downloading: %s Bytes: %s" % (file_name, file_size)

    file_size_dl = 0
    block_sz = 8192
    while True:
        buffer = u.read(block_sz)
        if not buffer:
            break

        file_size_dl += len(buffer)
        f.write(buffer)
        status = r" %10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
        status = status + chr(8)*(len(status)+1)
        print status,

    f.close()
</pre>
这个函数也是非常重要的一个函数，看起来好像很复杂的样子，其实，这个函数大部分内容都只是在为了得到动态的下载效果（即让我们在下载的时候能看到下载进度，下载大小等等）。上面提到的那个网页中提供了好几种方法，我们这里用到的可能是看起来比较麻烦的一个方法，但是却是最人性化（有趣）的一种方法。

## 使用说明
有了这个 DownloaHelper 之后，怎么使用呢？

在使用之前，我们需要搞清楚我们所需要下载的文件的具体情况

+ 原始网址（raw_url），也就是我们要获取文件列表的那个网址；
+ 从原始网址中导出的列表到底是不是完整的地址（Y/N），是则结束；
    * 文件的根地址（root_url）是不是 raw_url，（Y/N），是则结束；
        - 如果不是，则需要手动提供 root_url。

备注：判断这些只需要选择一个文件的地方，右键选择审查元素，非常容易判断这些问题。

## 下载示例
1. 下载地址（raw_url）为:[http://www.princeton.edu/~otorres/](http://www.princeton.edu/~otorres/)，我们选择一个链接，右键查看源码，我们发现文件的地址是完整的。使用下面的命令：
<center>![example1](http://ddswhu.com/wp-content/uploads/2015/03/example1.png)</center>

2. 下载地址为:[http://www.learneconometrics.com/class/5263/notes/](http://www.learneconometrics.com/class/5263/notes/)，我们选择一个链接（比如 Regression Review），右键查看源码，文件的地址不是完整的（GretlNotes_ch6.pdf），这个时候打开这个链接，发现文件的地址（[http://www.learneconometrics.com/class/5263/notes/GretlNotes_ch6.pdf](http://www.learneconometrics.com/class/5263/notes/GretlNotes_ch6.pdf)），这也就是说我们的 root_url 和 raw_url 是一致的，所以下载时，根据提示，正确的方法是如下
<center>![example2](http://ddswhu.com/wp-content/uploads/2015/03/exaample2.png)</center>

3. 下载地址为 [https://files.nyu.edu/eo1/public/Book-PDF/](https://files.nyu.edu/eo1/public/Book-PDF/)，选择一个链接，比如 [Chapter 1.pdf](https://files.nyu.edu/eo1/public/Book-PDF/Chapter%201.pdf) ，文件地址不是完整的（/eo1/public/Book-PDF/Chapter%201.pdf），然后打开这个链接，我们发现完整的下载地址为 [https://files.nyu.edu/eo1/public/Book-PDF/Chapter%201.pdf](https://files.nyu.edu/eo1/public/Book-PDF/Chapter%201.pdf)，对两个网址作减法，所以我们需要手动提供 root_url 为 [https://files.nyu.edu](https://files.nyu.edu)，所以，下载提示的回答如下
<center>![](http://ddswhu.com/wp-content/uploads/2015/03/example3.png)</center>

## 自定义下载
+ 我们默认使用的是下载 PDF，当然如果要下载其他文件，只需要在 21 行处添加相应的文件拓展名即可。
+ 文中设定的是将网址中所有可以下载的 PDF 文件下载下来，如果只需要部分，可以在 72 行处添加数字，比如 `url_lst[0:4]` 表示下载前面四个文件。
+ 如果需要中断下载，只需要按 CTRL+C 就行。

## 欢迎大家试玩，如果有什么改进意见欢迎探讨！

[file]
