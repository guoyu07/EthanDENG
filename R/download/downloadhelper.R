# deteck whether the downloader pkg has been installed
# if not, then install the pkg
# otherwise, return the information that the pkg is not installed
pkgtest <- function(x="downloader") {
    if (x %in% rownames(installed.packages()) == FALSE){
        install.packages(x)
    } else {print("The required packages have been installed")}
}

# transform the number index to special character
# index which has the same number of digits
# Example: 1:13 -> 01-09,10,11,12,13
transform <- function(index,ndigits=2){
    nullnum <- 10^{ndigits}
    cindex <- as.character(index + nullnum)
    dindex <- substr(cindex,2,ndigits+2)
    return(dindex)
}

downloader <- function(urlpre, index, transform=FALSE , ndigits = 2, filepre = "", filetype = "pdf") {
    # test whether the pkg is installed
    # load the pkg
    pkgtest("downloader")
    library(downloader)
    # If the transform is set to be TRUE and class of index
    # is not character, then the dindex should be transformed
    # using transform function defined
    if (transform == TRUE & !class(index) == "character"){
        dindex <- transform(index,ndigits)
    } else {
        dindex <- index
    }
    # sometimes, we have filepre such as "chap" or "chapter"
    # filetype can be "pdf","csv","xlsx","mp3"
    fileindex <- paste(filepre,dindex,".",filetype,sep="")

    # to create the full path of the files
    # urlpre indicates the url prefix
    urlindex <- paste(urlpre,fileindex,sep="")

    # binary files and text file list
    textfilelist <- c("csv","txt","R","tex","r","m")

    # mode is set to be "w" short for write(default)
    # if the file is text files, then it should be set
    # to be wb, short for write binary files
    if (filetype %in% textfilelist == FALSE){
        mode <- "wb"
    } else {
        mode <- "w"
    }

    # download process
    for (i in 1:length(index)) {
         download(url = urlindex[i], destfile = fileindex[i], mode = mode)
    }
}

