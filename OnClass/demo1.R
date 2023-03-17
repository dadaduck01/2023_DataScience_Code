a = c(0, 1, 2, 3)
print(a)
print(ls())

women

class(women[1])
class(women[[1]])
class(c(1:10))
x <- matrix(c(1:10),2,5,byrow = T)
class(x)

mtcars

f <- factor(mtcars$cyl)
f

week <- factor(c("Mon","Mon","Fri","Wed","Fri"), ordered = TRUE, levels = c("Mon","Tue"
                                                                      ,"Wed","Thu",
                                                                      "Fri"))

week


num <- c(10:1000)
cut(num,c(seq(0,1000,100)))


mat <- matrix(c(1:40),8,5,byrow = T)
colnames(mat) <- c("C1","C2","C3","C4","C5")
rownames(mat) <- c("R1","R2","R3","R4","R5","R6","R7","R8")
mat
mat[mat[,1]>=12]

cbind(c(80:87),mat)
c(mat)

switch(1,"南京大学","数据科学")


typeof(women)
typeof()


rec <- list("sex" = c("female","male"),
            "age" = c(18,18,19,20),"dept" = c("CS","IM"))
rec

names(rec)[names(rec) == "dept"] <- "专业"
rec
unlist(rec)
typeof(rec)


library(forcats)
x <- c("男", "女", "男", "男",  "女")
sex <- factor(x,levels = c("男","女"), labels = c("Man","Women"))
sex
table(sex)
h <- c(165, 170, 168, 172, 159)
h <- factor(h)
tapply(h, sex, median)

d <- data.frame(
  name=c("李明", "张聪", "王建"), 
  age=c(30, 35, 28), 
  height=c(180, 162, 175),
  stringsAsFactors=FALSE)
print(d)

d[d$age >= 29,]

dm <- data.frame(
  "年级"=1:6,
  "出游"=c(0, 2, 2, 2, 2, 1),
  "疫苗"=c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)
)
dm
rownames(dm) <- dm$年级
dm$年级 <- NULL
dm

height <- c(2,4,6,2,4,1,5,7,7,3,3,5,7,8,42,2)
type <- c(rep("a",5),rep("b",6),rep("c",5))
bac <- data.frame(height,type)
bac

bac$type <- as.factor(bac$type)
ba.an <- aov(lm(height~type, data = bac))   #anova
summary(ba.an)

boxplot(height~type,data = bac,col = "green")

# df:degree of freedom:自由度
# sum_sq:和的方差
# mean_sq:平均值方差
# F_value:F检验，值越大越显著
# Pr：P值
# apa：汇报统计结果


add <- function(a, b){
  result = a + b
  return(result)
}
add(3, 4)

library(nycflights13)
data()
dim(flights)

head(flights)
filter(flights, month == 1)
library(dplyr)

summarise(flights, delay = mean(dep_delay,na.rm = TRUE))
library(ggplot2)



