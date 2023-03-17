library(ggplot2)
library(tidyr)
library(readxl)
library(dplyr)
Clusters <- data.frame(year = c(2016,2017,2018),
                       Zhongchuang = c(6,8,14),
                       Fuhua = c(6,6,17))

Clusters$year <- as.factor(Clusters$year)

ggplot(data = Clusters, aes(x=year,y=Zhongchuang,fill=year)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Zhongchuang), vjust=-0.3, size=8) +
  scale_y_continuous("重创空间数") +
  scale_x_discrete("年份") +
  theme_bw(base_size = 22)

Cluster.long <- gather(Clusters,type,value,Zhongchuang:Fuhua,factor_key = T)

ggplot(data = Cluster.long, aes(x=year,y=value,fill=type)) +
  geom_bar(stat = "identity",position=position_dodge()) +
  geom_text(aes(label=value), vjust=-0.2, color="black",
            position = position_dodge(0.9), size=8)+
  scale_fill_discrete("集群类型",labels =c("众创空间","孵化器")) +
  scale_y_continuous("众创空间和孵化器") +
  scale_x_discrete("年份") +
  theme_bw(base_size = 22)


Zhongchuang <- read_excel("C:/Users/lelek/Downloads/18年众创空间年报（新区14家省级以上众创空间）.xlsx", sheet = 1)
head(Zhongchuang)

Fuhua <- read_excel("C:/Users/lelek/Downloads/2018孵化器年报（新区17家孵化器）.xlsx", sheet = 1)
head(Fuhua)

Fuhua$tdf7a10 <- Fuhua$tdf7a10/10
Fuhua$tdf7a11 <- Fuhua$tdf7a11/10
Fuhua$tdf7a12 <- Fuhua$tdf7a12/10
Fuhua$tdf7a13 <- Fuhua$tdf7a13/10

FuhuaTouzi <- dplyr::select(Fuhua,sid,tdf7a10:tdf7a13)

FuhuaTouzi.long <- gather(FuhuaTouzi,type,value,tdf7a10:tdf7a13,factor_key = T)

ggplot(data = FuhuaTouzi.long, aes(x=sid,y=value,fill=type)) +
  geom_bar(stat = "identity",position=position_stack()) +
  scale_fill_discrete("集群类型") +
  scale_y_continuous("众创空间和孵化器") +
  scale_x_discrete("年份") +
  theme_bw(base_size = 22)


gaoxin <- read_excel("C:/Users/lelek/Downloads/2018年企业火炬统计 附件.xlsx", sheet = 1)
head(gaoxin)

gaoxin.leixing <- dplyr::select(gaoxin,sid,qb16v)

scale_x_discrete(limits=c("D2", "D0.5", "D1"))

IndustryOrder <- c("1.电子与信息","2.生物、医药技术","4.光机电一体化","3.新材料","6.环境保护","10.其他高技术","5.新能源、高效节能","11.非高技术","7.航空航天","9.核应用技术")
ggplot(data = gaoxin, aes(x=factor(qb16v),fill=factor(qb16v))) +
  geom_bar() +
  geom_text(stat='count', aes(label=..count..), vjust=-0.2,size = 8) +
  scale_y_continuous("企业数量") +
  scale_x_discrete("企业所属技术领域",limits=IndustryOrder,labels=c()) +
  scale_fill_discrete("企业所属技术领域") +
  theme_bw(base_size = 22)

gaoxin.gongye <- dplyr::select(gaoxin,sid,qb16v,qc02)
gaoxin.gongye$qc02 <- gaoxin.gongye$qc02/10
gaoxin.gongye.sub <- filter(gaoxin.gongye,qc02>10)


ggplot(gaoxin.gongye.sub,aes(x=log(qc02+1))) +
  geom_histogram(alpha = 0.1,color = "blue") +
  scale_x_continuous("工业总产值(对数)") +
  scale_y_continuous("企业数") +
  theme_bw(base_size = 22)

ggplot(data = gaoxin.gongye.sub, aes(x=qb16v,y=log(qc02),fill=qb16v)) +
  geom_bar(stat = "identity",position=position_dodge()) +
  scale_y_continuous("工业总产值（万元）（对数值）") +
  scale_x_discrete("企业所属技术领域",limits=IndustryOrder,labels=c()) +
  scale_fill_discrete("企业所属技术领域") +
  theme_bw(base_size = 22)

gaoxin.gongye.sub.grouped <- dplyr::group_by(gaoxin.gongye.sub,qb16v)
summarise(gaoxin.gongye.sub.grouped,count = n(),
                                    amount = sum(qc02),
                                    pingjun = mean(qc02))

gaoxin.jishushouru <- dplyr::select(gaoxin,sid,qc02,qb16v,qc06)
gaoxin.jishushouru$qc06 <- gaoxin.jishushouru$qc06/10
gaoxin.jishushouru$qc02 <- gaoxin.jishushouru$qc02/10
gaoxin.jishushouru.sub <- filter(gaoxin.jishushouru,qc06>0)
ggplot(gaoxin.jishushouru.sub,aes(x=log(qc06+1))) +
  geom_histogram(alpha = 0.1,color = "blue") +
  scale_x_continuous("技术收入(对数)") +
  scale_y_continuous("企业数") +
  theme_bw(base_size = 22)


gaoxin.jishushouru.sub <- filter(gaoxin.jishushouru,qc06>0,qc02>0)
ggplot(gaoxin.jishushouru.sub,aes(x=log(qc06+1),y=log(qc02+1))) +
  geom_point(alpha = 0.5) +
  scale_x_continuous("技术收入(对数)") +
  scale_y_continuous("工业产值(对数)") +
  stat_smooth()+
  theme_bw(base_size = 22)


gaoxin.renyuan <- dplyr::select(gaoxin,sid,qc02,qb16v,qd01,qd18,qd08,qd09)
gaoxin.renyuan$renjunchanzhi <- gaoxin.renyuan$qc02/gaoxin.renyuan$qd01
gaoxin.renyuan.sub <- filter(gaoxin.renyuan,renjunchanzhi>0)

ggplot(gaoxin.renyuan.sub,aes(x=log(renjunchanzhi+1))) +
  geom_histogram(alpha = 0.1,color = "blue") +
  scale_x_continuous("人均工业产值(对数)") +
  scale_y_continuous("企业数") +
  theme_bw(base_size = 22)


gaoxin.renyuan.sub.grouped <- dplyr::group_by(gaoxin.renyuan.sub,qb16v)
result.renjun <- summarise(gaoxin.renyuan.sub.grouped,
                           count = n(),
          amount.qd01 = sum(qd01),
          mean.qd01 = mean(qd01),
          amount.qd18 = sum(qd18),
          mean.qd18 = mean(qd18),
          amount.qd08 = sum(qd08),
          mean.qd08 = mean(qd08),
          amount.qd09 = sum(qd09),
          mean.qd09 = mean(qd09))

ggplot(data = gaoxin.gongye.sub, aes(x=qb16v,y=log(qc02),fill=qb16v)) +
  geom_bar(stat = "identity",position=position_dodge()) +
  scale_y_continuous("工业总产值（万元）（对数值）") +
  scale_x_discrete("企业所属技术领域",limits=IndustryOrder,labels=c()) +
  scale_fill_discrete("企业所属技术领域") +
  theme_bw(base_size = 22)
