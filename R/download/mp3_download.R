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
