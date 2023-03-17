GetDistribution <- function(df,limit){
  variable.No <- ncol(df) # 获取data.frame中的列数
  if(variable.No > limit){
    variable.No = limit
  }
  for (i in 1:variable.No){
    hist(df[,i]) # 绘制每一列的直方图
  }
}

GetDistribution(mtcars,100)

GetDistribution2 <- function(df,limit){
  variable.No <- ncol(df) # 获取data.frame中的列数
  if(variable.No > limit){
    variable.No = limit
  }
  for (i in 1:variable.No){
    TmpFileName <- paste("test/",i,"_",colnames(df)[i],".png",sep = "")
    png(file=TmpFileName)
    hist(df[,i]) # 绘制每一列的直方图
    dev.off()
  }
}
GetDistribution2(mtcars,100)
