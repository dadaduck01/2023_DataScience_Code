App.DF <- read.csv("E:/finalappresults.csv")

head(App.DF)

table(App.DF$position)
# performance 0930download
# manhattan_1
# update_count
#des_len

variables <- c("X0930_download","position","position_1","position_2","position_3",
               "manhattan_1","X0801_download","size","update_count",
               "des_len",
               "mumayi","baidushouji",
               "X360","youyi","yingyonghui")

App.DF.variables <- App.DF[,variables]
App.DF.variables$position <- as.factor(App.DF.variables$position)
summary(App.DF.variables)
ggplot(App.DF.variables,aes(y=log(X0930_download),x=position)) +
  geom_boxplot() +
  scale_x_discrete("市场地位",labels = c("明星","现金牛","问号","瘦狗")) +
  scale_y_continuous("10月1号下载量的对数值") +
  theme_bw(base_size = 22)

  

ggplot(App.DF.variables,aes(x=log(X0930_download))) +
  geom_histogram(binwidth = 0.9,alpha = 0.1,color = "red") +
  scale_x_continuous("10月1号下载量的对数值") +
  scale_y_continuous("频数") +
  theme_bw(base_size = 22)

ggplot(App.DF.variables,aes(x=manhattan_1)) +
  geom_histogram(binwidth = 0.01,alpha = 0.1,color = "red") +
  scale_x_continuous("曼哈顿距离") +
  scale_y_continuous("频数") +
  theme_bw(base_size = 22)

ggplot(App.DF.variables,aes(y=manhattan_1,x=position)) +
  geom_boxplot() +
  scale_x_discrete("市场地位",labels = c("明星","现金牛","问号","瘦狗")) +
  scale_y_continuous("曼哈顿距离") +
  theme_bw(base_size = 22)
anova.result <- aov(manhattan_1~position, data = App.DF.variables)
summary(anova.result)

ggplot(App.DF.variables,aes(y=log(X0930_download),x=manhattan_1)) +
  geom_jitter(alpha=0.5) +
  stat_smooth() +
  scale_x_continuous("曼哈顿距离") +
  scale_y_continuous("10月1号下载量的对数值") +
  theme_bw(base_size = 22)

model1 <- lm(X0930_download~ 
               size + update_count + des_len +X0801_download + mumayi + baidushouji + X360 + youyi + yingyonghui, data = App.DF.variables)

summary(model1)

model2 <- lm(X0930_download~ 
               position_1 + position_2 + position_3 + manhattan_1, data = App.DF.variables)

summary(model2)

model3 <- lm(X0930_download~ 
               position_1 + position_2 + position_3 + manhattan_1 +
               size + update_count + des_len +X0801_download + mumayi + baidushouji + X360 + youyi + yingyonghui, data = App.DF.variables)

summary(model3)

model4 <- lm(X0930_download~position_1 + position_2 + position_3 + manhattan_1 +
     position_1 * manhattan_1 + position_2*manhattan_1 + position_3*manhattan_1 + 
       X0801_download + 
     size + update_count + des_len + mumayi + baidushouji + X360 + youyi + yingyonghui, data = App.DF.variables)

summary(model4)

