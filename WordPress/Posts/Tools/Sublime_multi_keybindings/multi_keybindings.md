## 想实现的功能
近日，由于最近一直想用 Sublime Text （之后简称 ST） 彻底替代掉 Stata 中的 do file editor，这样就能享受到单个编辑器带来的各种好处，但是这一路貌似不太容易，一来是因为使用 ST 的人大多数都是和网页编程的人，而经济学中所用到的那些计量软件没人去折腾。

当我为了实现 `CTRL + Enter` 运行 do 文件中的光标所在的当前行（这是 RStudio 的一个功能），由于 StataEditor 中并没有这个功能，我不得不重新改写 StataEditor 的 Key Bindings，而在我能力范围内是无法通过一个命令来实现，在 google 上搜了很久，终于找到了我所需要的东西：`run_multiple_commands.py`，而这个版本也至少有 3 个（3 个作者），文末提供本人使用的版本，它是基于最初版本的一个改良版本。

## 实现方法
### 还原某些被覆盖的快捷键
我们发现在安装 StataEditor 之后，ST 中几个很重要的快捷键被覆写了，比如，选择某一行（`CTRL+L`），选择一个单词（`CTRL+D`），这些功能是比较基础的，我们平常都会用到。所以，第一步我们需要把这些快捷键找回来。我们可以在 `Preference` -> `Key Bingdings - Default` 里面找到我们所需要找回的快捷键，然后复制粘贴到 `Preference` -> `Key Bingdings - User` 里面，这样我们就找回了 ST 的默认快捷键。StataEditor 与 ST 冲突两个快捷键分别是 `CTRL+L` 和 `CTRL+D`，我们可以把下面的代码粘贴到用户的快捷键的文件中：

<pre class="lang:js decode:true " >
 // the keybindings conflict with StataEditor
 // recover the default key bindings
    { "keys": ["ctrl+l"], "command": "expand_selection", "args": {"to": "line"} },
    { "keys": ["ctrl+d"], "command": "find_under_expand" },
</pre>

另外，由于之后我们需要定义 `CTRL+Enter`，而 ST 的 `CTRL+Enter` 本身就很有用（当前行的下一行添加一空行），所以，为了还原 ST 的 `CTRL+Enter`，我们将 ST 中 `CTRL+Enter` 的定义给 `CTRL+SHIFT+Enter`（ST 中 `CTRL+SHIFT+Enter` 是在当前行的上一行添加一个空行，并不常用）。

<pre class="lang:js decode:true " >
{ "keys": ["ctrl+shift+enter"], "command": "run_macro_file", "args": {"file": "res://Packages/Default/Add Line.sublime-macro"},"context":[{ "key": "selector", "operator": "equal", "operand": "source.stata" }]},
</pre>

### 还原 StataEditor 的功能
由于在上面我们还原了 ST 默认的快捷键（`CTRL+D`），所以 StataEditor 的编译（`CTRL+D`）功能会缺失，为了方便，我们重新定义它们，将如下代码添加到用户的快捷键配置文件中即可：

<pre class="lang:js decode:true " >
 // Stata Keybindings
    // run the selection part of do file
    { "keys": ["ctrl+r"],   "command": "stata_execute", "args": {"Mode": "do"}, "context":[{"key":"selector", "operator":"equal", "operand":"source.stata"}]},
    // run the do file silently
    { "keys": ["ctrl+shift+r"], "command": "stata_execute", "args": {"Mode": "run"}, "context":[{ "key": "selector", "operator": "equal", "operand": "source.stata" }]},
</pre>
实际上就是将 `CTRL+R` 定义为 StataEditor 中的 `CTRL+D`（编译整个文件或者选择的某些行），而 StataEditor 中的 `CTRL+R` 重新修改为 `CTRL+SHIFT+R`。 

## 添加运行当前行的功能键

上面我们还原快捷键和新定义快捷键的目的就是为了给我们的新功能 "运行当前行" 让路，本节将介绍如何添加这个功能的快捷键。

### 安装 run_multiple_commands 插件
下载 `run_multiple_commands.py`，将其复制到 ST 的 `User` 目录下，或者打开 `run_multiple_commands.py`，将内容复制出来，选择 `Tools` -> `New Plugin...`，清空里面的内容，将我们复制的内容粘贴到里面，保存，命名为 `run_multiple_commands.py` 即可。

### 添加 `CTRL+Enter` 功能
为了实现将光标所在行内容发送到 Stata，我们通过多个命令组合起来实现，分别由下面命令构成：

+ 将光标移到行末（对应于`End`）；
+ 在行末插入一个空格（特殊作用）；
+ 从行末开始，选择直到行首的内容（对应于 `SHIFT+Home`）；
+ 将其发送到 Stata 中（借助 StataEditor 的命令）；
+ 将光标移到下一行（对应于 `Home`）

我们将这 5 个步骤“打包”到一起，定义一个功能快捷键 `CTRL+Enter`，也即使用下面的定义（添加到 `Key Bindings - User 下`）：

<pre class="lang:js decode:true " >
 // define a multiple commands keybinding with multiple_commands.py
    { "keys": ["ctrl+enter"],
    "command": "run_multiple_commands",
    "args": {
         "commands": [
            {"command": "move_to", "args": {"to": "hardeol", "extend": false}},
            {"command": "insert", "args": {"characters": " "} },
            {"command": "move_to", "args": {"to": "hardbol", "extend": true}},
            {"command": "stata_execute", "args": {"Mode": "do"}},
            {"command": "move_to", "args": {"to": "hardbol", "extend": false}},
            ]},
            "context":[{ "key": "selector", "operator": "equal", "operand": "source.stata"}]
            },
</pre>

**NOTES**: 添加第二个命令的目的在于：当我们的光标处于空行中，如果按 `CTRL+Enter`，实际上是按了 StataEditor 原来的 `CTRL+D`，而它的定义是在 **没有选择内容** 的时候运行整个文件，这对我们定义这个功能键是有害无益的，所以为了避免这个问题，我们在行末添加一个空格，这一行就有内容了，从行末选择到行首只会选择这个空格，运行这个空格是没有问题的。

由于我并不知道 StataEditor 的“构造”，目前没有更完美的解决方法。为了删除不必要的空格，我们可以在 `Preference` -> `Settings - User` 中添加 `"trim_trailing_white_space_on_save": true,`，这样在我们保存文件的时候会自动删除不必要的空格。

## 命令改造总结

+ 还原了 ST 三个默认的快捷键：`CTRL+D`、`CTRL+L`（被 StataEditor 覆写了）；
+ 重新定义 `CTRL+SHIFT+Enter` 为在下一行插入空行；
+ 将 StataEditor 中 `CTRL+D` 换做 `CTRL+R`，用于编译选中部分或者运行整个 do 文件；
+ 将 StataEditor 中 `CTRL+R` 换做 `CTRL+SHIFT+R`，用于无输出运行选择部分或者运行整个 do 文件；
+ 新定义 `CTRL+Enter` 功能键为：运行光标所在行。

也即，我们常用的快捷键变成了 `CTRL+Enter` 和 `CTRL+R`。

## `run_multiple_commands.py` 下载 

[file]
