rivers

# 元素个数
length(rivers)
#  均值
mean(rivers)
# 中位数
median(rivers)
# 标准差
sd(rivers)
# 方差
var(rivers)
# 最大值
max(rivers)
# 最小值
min(rivers)

rivers.Des.1 <- c(length(rivers),mean(rivers),median(rivers),sd(rivers),var(rivers),max(rivers),min(rivers))

rivers.Des.1

library(Hmisc)
x <- Hmisc::describe(rivers)

list1 <- x$counts
list2 <- x$extremes

df <- data.frame(
  counts=list1[1],
  missing=list1[2],
  distinct=list1[3],
  info=list1[4],
  mean=list1[5],
  Gmd=list1[6],
  five_percent=list1[7],
  ten_percent=list1[8],
  twentyfive_percent=list1[9],
  fifty_percent=list1[10],
  seventyfive_percent=list1[11],
  ninty_percent=list1[12],
  nintyfive_percent=list1[13],
  lowest5=list2[1:5],
  high5=list2[6:10]
)
df

women
nrow(women)
ncol(women)

head(women,6)
tail(women,6)

HeightMeans = colMeans(women)[1]
HeightMeans

HeightVar <- var(women[1])
HeightVar

height <- women[[1]]
women.Height60 <- height[which(height > 60)]
women.Height60

women.list <- list(women[[1]],women[[2]])
names(women.list) <- c("height","weight")
women.list

women.matrix <- as.matrix(women)
women.matrix
t(women.matrix)

cor(women)

cor(women, method = "pearson")
cor(women, method = "kendall")
cor(women, method = "spearman")
