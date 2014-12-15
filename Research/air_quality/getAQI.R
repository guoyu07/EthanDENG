# 设置工作路径
setwd("D:/research/air_pollution")
# 加载网页解析宏包
library(XML)
# 导入城市列表
city_list <- as.data.frame(read.csv("city.csv"))
# 起始日期与截止日期的设置
startdate <- as.Date("2014-01-01")
enddate   <- as.Date("2014-12-15")
# 网址辅助单元
url1 <- "http://datacenter.mep.gov.cn/report/air_daily/air_dairy.jsp?city="
url2 <- "&startdate="
url3 <- "&enddate="
url4 <- "&page="

# xi 表示城市，全部获取需要改为 1:161
# 对城市进行循环
for (xi in 1:3) {
    # 选择其中一个城市
    city <- city_list[xi,]
    # 构建网址
    urlx <- paste(url1,city,url2,startdate,url3,enddate,url4,1,sep="")
    # 获取 HTML 里面的 table
    datx <- readHTMLTable(readLines(urlx,warn=FALSE))
    # 获取单个城市的记录条数，赋值给 nrecode
    # 获取单个城市记录所占页面数
    ttline <- datx[[4]][c(32),c(1)]
    nrecode <- as.integer(substr(ttline, 6, 8))
    npage <- as.integer(substr(ttline, 15, 16))
    # 最后一页所含记录数
    lpr <- nrecode %% 30

    for (xj in 1:npage) {
        # 构造网址
        url <- paste(url1,city,url2,startdate,url3,enddate,url4,xj,sep="")
        # 读取表格
        dat <- readHTMLTable(readLines(url,warn=FALSE))
        # 对每个页面进行循环
        # 当 npage = lpr 时，需要特殊处理，只读取某几行，而不是 30 行
        if (xj != npage) {
            data.final <- dat[[4]][-c(1,32,33,34,35),-c(1,7)]
        }   else {
            data.final <- dat[[4]][c(2:lpr+1),-c(1,7)]
        }
        # 把表格导出到 output.csv 中，注意其中所需要的选项
        write.table(data.final, file = "output.csv", append = TRUE, col.names = FALSE, row.names = FALSE)
    }
}
