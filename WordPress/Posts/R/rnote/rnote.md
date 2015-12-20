## 数据操作
### 查看数据
<pre class="lang:r decode:true " >
head(x) # head = head(x,5)
tail(x)
str(x)
</pre>

### 拓宽屏幕输出
<pre class="lang:r decode:true " >
options(width=numcols); # by default width=80
</pre>

### 赋值并查看
<pre class="lang:r decode:true " >
(x <- 1) # 在赋值语句外加括号即可 
</pre>

### 行列求和
<pre class="lang:r decode:true " >
rowSums(m)   # m 为矩阵
colSums(m)  
</pre>

可以用 `cbind` 或者 `rbind` 将矩阵的行和，列和添加到矩阵中
<pre class="lang:r decode:true " >
cbind(df,rowSums(df))
rbind(df,colSums(df))
</pre>

### 按列输出
<pre class="lang:r decode:true " >
print(cbind(x,y))
</pre>

### 对数据分组（分级）
<pre class="lang:r decode:true " >
f <- cut(x,breaks=c(1.1, 1.4, 1.5, ...),labels=c("A", "B", "C", ...))
</pre>

 
### 找到某个元素的位置
<pre class="lang:r decode:true " >
match(90,vec)  # 其中 vec 为一个向量
which.min(vec) # 找出最小值的位置
which.max(vec) # 找出最大值的位置
</pre>

### 每隔 n 个选出一个元素
<pre class="lang:r decode:true " >
 # Method 1 适用于所有
index <- seq_along(v) %% n # 其中 v 为一个向量
v(index)
 # Method 2 适用于特殊情况
index <- c(FALSE,TRUE)
v(index)
</pre>

### 成对向量的最小值，最大值
<pre class="lang:r decode:true " >
pmin(vec1,vec2)  # vec1\vec2 为一组向量
pmax(vec1,vec2)
 # 对期权定价，期权价值为 max{S-X,0}，可以用 pmax(S-X,0) 来比较
</pre>

### 多因子（factor）组合
<pre class="lang:r decode:true " >
expand.grid(f,g)  # f,g 为 factor
</pre>

### 排序
<pre class="lang:r decode:true " >
sort(x) # 对向量排序，注意结果是结果，而不是索引、下标
 # 对 dataframe 多字段的排序
dfm <- dfm[order(dfm$key1,dfm$key2),] # key1\key2 为排序关键字
</pre>

### 移除变量属性
<pre class="lang:r decode:true " >
attributes(x) <- NULL # 移除全部
attr(x,"attributeName") <- NULL # 移除 x 的名字
</pre>

### 查看数据结构
<pre class="lang:r decode:true " >
class(x)
mode(x)
str(x)
</pre>

### 从 list 中提取数据方便函数调用
<pre class="lang:r decode:true " >
unlist(lst) # 把 lst 变成 vec
do.call(func,lst) # 把 列表 lst 中的每个部分拆分，应用到函数 func 中
</pre>

## 编程相关
### lapply 与 sapply
<pre class="lang:r decode:true " >
lst2 <- lapply(lst,func) # 对 lst 应用 func 函数
vec <- sapply(lst,func) # 返回结果会尽量简化（simplify）
</pre>

### apply
<pre class="lang:r decode:true " >
apply(mat,1,func)        # 对矩阵 mat 的行 (第一维度) 应用函数 func
apply(mat,2,func)        # 对矩阵 mat 的列应用函数 func
apply(array,c(1,2),func) # 对多维数组 array 的 1,2 维度应用 func
</pre>

### tapply
<pre class="lang:r decode:true " >
tapply(vec,f,func) # 对向量 vec 根据分组因子 f 应用函数 func 
 # example
n <- 17
fac <- factor(rep(1:5, length = n), levels=1:5, labels =c("A","B","C","D","E"))
table(fac)
tapply(1:n, fac, sum)
</pre>

### by 
<pre class="lang:r decode:true " >
by(dfm,f,func) # 对 dataframe dfm 根据 f（比如 dfm$sex）应用函数 func
</pre>

### mapply
想量化使用参数（参数向量使用）
<pre class="lang:r decode:true " >
 # vec1 vec2 对应的元素作为 func 的参数参与计算
mapply(func,vec1,vec2)   # mapply 为 sapply 的多元版本
 # example 
mapply(rep, times = 1:4, x = 4:1) 
</pre>


### 抑制警告提示以及错误提示（warning and error msg）
<pre class="lang:r decode:true " >
suppressWarnings(cmd)
</pre>

### 定义二元运算符
<pre class="lang:r decode:true " >
'%+-%' <- function(x,margin...)
</pre>
