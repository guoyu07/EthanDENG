我自己使用 Sublime Text（后面简称 ST）很多，也推荐了一些身边的同学使用，昨天一个同学和我说 Stata 能在 Sublime 里面跑了！当然，实际上并不是在 ST 里面跑 Stata，只是在 ST 里面写 `.do` 文件，然后在 Stata 里面运行。 下面介绍如何配置 ST。

## 配置步骤

### 安装 Stata，获取路径
首先，你要有 Stata 软件，假设你电脑上已经安装了 Stata，安装路径为 `F:/Program Files/Stata12.1/StataSE-64.exe`。注意绿色版本可能有些问题。

### 安装 StataEditor 包
通过 ST 安装 StataEditor 包和 Pywin32 包。然后将 **StataEditor** 的 `Settings-Default` 复制一份到 `Settings-User`，在 `"stata_path":` 处修改路径为 Stata 的安装完整路径（即`"F:/Program Files/Stata12.1/StataSE-64.exe"`）。

**NOTE**: 复制配置文件的目的是避免包升级的时候覆盖掉原有的配置文件。

### 配置 Stata Automation type library

+ 在安装目录下，找到 `StataSE-64.exe`（各个版本文件名不太一样），右键新建一个快捷方式；
+ 右键新建的快捷方式，选择`属性`，在`目标（T）:`所链接到的文件地址之后添加` /Register`，也即完整的形式为 `"F:\Program Files\Stata12.1\StataSE-64.exe" /Register`，然后确定关闭属性窗口；
+ 右键 Stata 的快捷方式，选择`以管理员身份运行`。

如果配置 Stata Automation 有疑问，参考 [Stata Automation](http://www.stata.com/automation/#createmsapp)。

## StataEditor 的使用
我们可以新建一个 `.do` 文件，在安装这个包之前是 `.do` 文件是没有高亮显示的，装完之后会有代码高亮，并且，有命令提示，如下图所示：
<center>![sublime_StataEditor](http://ddswhu.com/wp-content/uploads/2015/03/ststata.png)</center>

输入命令之后，如果直接按 `ctrl+d`，则会运行整个`.do`文件，如果选择某一行或者多行，然后按 `ctrl+d` 则会将这部分代码发送到 Stata，比如运行上面的代码，则会得到如下的结果

<center>![plots](http://ddswhu.com/wp-content/uploads/2015/03/plot.jpg)![reg](http://ddswhu.com/wp-content/uploads/2015/03/reg.png)</center>

## StataEditor 的特性
参考 StataEditor 的 Readme 文件或者 StataEditor 主页：[Github](https://github.com/mattiasnordin/StataEditor)

**注意**：ST 中有一个 Stata-Ehanced 插件，强烈建议不要使用！
