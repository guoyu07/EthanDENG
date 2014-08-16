    complete <- function(directory, id = 1:332) {
        path <- paste(getwd(), directory, "", sep="/")
        list <- paste(path, substr(as.character(1000 + id), 2, 4), ".csv", sep="")
        myfiles = lapply(list, read.csv, sep = ",", stringsAsFactors = FALSE)
        df <- do.call("rbind", myfiles)
        newdf <- na.omit(df)
        ## another option
        # newdf <- df[complete.cases(df),]
        newdf$ID <- factor(newdf$ID,order=FALSE,levels=id)
        count <- table(newdf$ID)
        sum <- as.data.frame(count,row.names=NULL)
        data.frame(id=sum$Var1,nobs=sum$Freq)
    }

