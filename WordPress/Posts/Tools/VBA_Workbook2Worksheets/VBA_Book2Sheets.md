## 拆分工作簿为多个工作簿
在日常工作中，我们可能会碰到一种情况是，一个工作簿中有好多工作表，而为了更加方便操作（比如用 R 读取一个一个工作表），如果直接读取这个工作簿，然后一个一个循环选择其中的工作表，这个工作将是耗时的，因为当这个工作簿很大的时候，读取这个工作簿就很费事，循环反复将会加大计算机的工作量。

本文介绍如何使用 VBA 将一个工作簿（Workbook）中的工作表（Worksheets）拆分出来，并且将每个工作表另存为工作簿。然后在后期处理我们可以对工作表进行循环操作。

## 解决方法

+ 选定其中一个工作表（Worksheet），然后选择`查看代码`；
<center>![](http://ddswhu.com/wp-content/uploads/2015/05/select.png)</center>
+ 将下面代码粘贴到刚才打开的 VBA 的模块窗口里面；

<pre class="lang:default decode:true " >
Private Sub hjs()
  Dim sht As Worksheet
  Dim ThisBook As Workbook
  Set ThisBook = ActiveWorkbook
  For Each sht In ThisBook.Sheets
    sht.Copy
    ActiveWorkbook.SaveAs ThisWorkbook.Path & "\" & sht.Name & ".xlsx"
    ActiveWorkbook.Close
  Next
  MsgBox "分拆完毕"
End Sub
</pre>
+ 然后保存（`CTRL+S`），将会碰到一个对话框，选择`否`，如下图：  
<center>![](http://ddswhu.com/wp-content/uploads/2015/05/save.png)</center>

+ 在弹出的另存为对话框，在 `保存类型` 中选择 `Excel启用宏的工作簿（*.xlsm）`，然后点击保存即可。
<center>![](http://ddswhu.com/wp-content/uploads/2015/05/save2.png)</center>

+ 单击运行按钮来完成各个工作表保存为单一工作簿。
<center>![](http://ddswhu.com/wp-content/uploads/2015/05/run.png)</center>

+ 拆分之后的效果如下
<center>![](http://ddswhu.com/wp-content/uploads/2015/05/complete.png)</center>

## 参考资料
+ [Excel将工作簿的每个工作表保存为单一新工作簿](http://jingyan.baidu.com/article/03b2f78c70dea95ea337ae67.html)


