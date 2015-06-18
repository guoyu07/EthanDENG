# 参考文献：http://blog.sina.com.cn/s/blog_6bc5205e0102vma9.html
setwd("D:/R/ChinaMap")
# install.packages("maptools")
# install.packages("mapproj")
require(maptools)
require(ggplot2)
require(dplyr)
require(showtext)
showtext.auto()

# 读取地图数据
china_map = readShapePoly("bou2_4p.shp")

# 读取行政信息
x <- china_map@data
# 含岛屿共925个形状
xs <- data.frame(x,id=seq(0:924)-1)

china_map1 <- fortify(china_map)
china_map1$id <- as.numeric(china_map1$id)
china_map_data <- full_join(china_map1, xs)

# 导入 GDP 数据
mydata <- read.csv("mydata.csv")

# 将 GDP 数据合并到之前的地图数据文件里
mydata$NAME <- as.character(mydata$NAME)
china_map_data$NAME <- as.character(china_map_data$NAME)
china_data <- full_join(china_map_data, mydata)

ggplot(china_data, aes(x = long, y = lat, group = group,fill = GDP)) +
     geom_polygon(colour="grey40") +
     scale_fill_gradient(low="white",high="darkgreen") +
     # 指定渐变填充色，可使用RGB
     coord_map("polyconic") +
     # 指定投影方式为polyconic，获得常见视角中国地图
     theme(  # 清除不需要的元素
          panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          legend.position = c(0.2,0.3)
          ) + labs(title="2014 年全国各省市 GDP 比较")
