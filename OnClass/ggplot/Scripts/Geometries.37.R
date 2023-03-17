library(ggplot2)
##Point
d=data.frame(beauty=c(1,2,6,4,4,6,7,8), 
             intelligence=c(8,4,7,5,4,9,2,3), 
             speed=c(7,6,9,5,7,6,7,8), 
             gender=c('m','m','f','m','f','f','f','m')) 
ggplot() + scale_size_continuous(c(4,12)) + 
          geom_point(data=d, 
                      mapping=aes(x=intelligence, 
                                  y=beauty, 
                                  shape=gender, 
                                  color=gender, 
                                  size=speed))


#Jitter
d=data.frame(system=rep(c('before','after'), 2000), 
             runtime=rexp(4000, 1)) 
ggplot() + geom_jitter(data=d, 
                       mapping=aes(x=system, y=runtime), size=1) + 
  opts(title="geom_jitter", plot.title=theme_text(size=40, vjust=1.5))


#Geom_text
d=data.frame(time=c(1,2,5,6,8,2), space=c(3,6,2,8,7,5), suite=c('spec','spec','dacapo','dacapo','dacapo','spec'), bm=c('javac','db', 'antlr', 'bloat', 'fop', 'raytrace')) 
ex=subset(d, time<=min(time)|time>=max(time)|space<=min(space)|space>=max(space)) 
ggplot() + scale_y_continuous(limits=c(1.5, 8)) + 
  geom_point(data=d, mapping=aes(x=time, y=space, fill=suite), size=9, shape=21, color="black") +
  geom_text(data=d, mapping=aes(x=time, y=space, label=substr(suite, 1, 1)), size=6) + 
  geom_text(data=ex, mapping=aes(x=time, y=space, label=bm), size=4, vjust=3, hjust=0.5) 

         
#Geom_segment
require(grid) 
d=data.frame(x=c(1,2,5,6,8), 
             y=c(3,6,2,8,7), 
             vx=c(1,1.5,0.8,0.5,1.3), 
             vy=c(0.2,1.3,1.7,0.8,1.4)) 
ggplot() + geom_segment(data=d, 
                        mapping=aes(x=x, y=y, xend=x+vx, yend=y+vy), 
                        arrow=arrow(), size=2, color="blue") + 
          geom_point(data=d, mapping=aes(x=x, y=y), size=4, shape=21, fill="white")

#geom_polygon
d=data.frame(x=c(1,2,2, 3,4,4), 
             y=c(1,1,2, 2,2,3), 
             t=c('a', 'a', 'a', 'b', 'b', 'b'), 
             r=c(1,2,3, 4,5,6)) 
ggplot() + geom_polygon(data=d, 
                        mapping=aes(x=x, y=y, group=t)) + 
           geom_point(data=d, aes(x=x, y=y, color=t)) + 
           geom_text(data=d, aes(x=x, y=y, label=r), hjust=0, vjust=1, size=4) 


#geom_rect()
d=data.frame(x1=c(1,3,1,5,4), 
             x2=c(2,4,3,6,6), 
             y1=c(1,1,4,1,3), 
             y2=c(2,2,5,3,5), 
             t=c('a','a','a','b','b'), 
             r=c(1,2,3,4,5))
ggplot() + scale_x_continuous(name="x") + 
           scale_y_continuous(name="y") + 
           geom_rect(data=d, 
                     mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=t), color="black", alpha=0.5) + 
           geom_text(data=d, aes(x=x1+(x2-x1)/2, y=y1+(y2-y1)/2, label=r), size=4)

#geom_rug()
d=data.frame(x=c(1.5, 2, 5.5, 2.5), 
             y=c(2.5, 3, 6.5, 5.5)) 
ggplot() + geom_rug(data=d, mapping=aes(x=x), color="red") + 
           geom_rug(data=d, mapping=aes(y=y), color="blue") + 
           geom_point(data=d, mapping=aes(x=x, y=y), color="grey50") 

#geom_step()
d=data.frame(x=c(1,2,4,5,7,8,9), y=c(1,2,3,5,6,7,9)) 
ggplot() + geom_step(data=d, mapping=aes(x=x, y=y)) + 
  geom_step(data=d, mapping=aes(x=x, y=y), direction="vh", linetype=3) + 
  geom_point(data=d, mapping=aes(x=x, y=y), color="red") 


#geom_blank()
d=data.frame(x=c(1,2,3,4), y=c(4,5,6,7))
ggplot(data=d, mapping=aes(x=x, y=y)) + 
  geom_blank() 

#geom_abline()
d=data.frame(s=c(1,2,3), ic=c(0,2,5)) 
ggplot() + scale_x_continuous(name="x", limits=c(0,10)) + 
  scale_y_continuous(name="y", limits=c(0,30)) + 
  scale_linetype(name="s") + 
  geom_abline(data=d, mapping=aes(slope=s, intercept=ic, linetype=factor(s))) 


#geom_hline()
d=data.frame(x=c(1,2,3,4,4,6,7,9), y=c(9,3,7,1,8,4,5,6)) 
ggplot() + geom_point(data=d, mapping=aes(x=x, y=y)) + 
           geom_hline(yintercept=mean(d$y), color="red") 


#geom_vline()
d=data.frame(date=as.Date(c("1971-09-01", "1991-12-01", "1994-12-01", "2000-01-01", "2002-08-01", "2005-08-01")), 
             event=c("birth", "entered college", "BS", "entered grad school", "MS", "PhD")) 

ggplot() + scale_x_date(limits=as.Date(c("1970-1-1", "2010-12-31"))) +
           geom_vline(data=d, mapping=aes(xintercept=date), color="blue") + 
           geom_text(data=d, mapping=aes(x=date, y=0, label=event), size=4, angle=90, vjust=-0.4, hjust=0)


#geom_errorbar()
d=data.frame(drink=c("coffee","tea","water"), 
             mean=c(3,6,2), 
             lower=c(2.6,5.6,1.8), 
             upper=c(3.5,6.3,2.8)) 
ggplot() + geom_errorbar(data=d, mapping=aes(x=drink, ymin=upper, ymax=lower), width=0.2, size=1, color="blue") + 
           geom_point(data=d, mapping=aes(x=drink, y=mean), size=4, shape=21, fill="white") 

#geom_barh()
d=data.frame(drink=c("coffee","tea","water"), 
             mean=c(3,6,2), 
             lower=c(2.6,5.6,1.8), 
             upper=c(3.5,6.3,2.8)) 
ggplot() + geom_errorbarh(data=d, 
                          mapping=aes(y=drink, x=upper, xmin=upper, xmax=lower), height=0.2, size=1, color="blue") + 
            geom_point(data=d, mapping=aes(y=drink, x=mean), size=4, shape=21, fill="white")

#geom_linerange()
d=data.frame(drink=c("coffee","tea","water"), 
             mean=c(3,6,2), 
             lower=c(2.6,5.6,1.8), 
             upper=c(3.5,6.3,2.8))
ggplot() + geom_linerange(data=d, mapping=aes(x=drink, ymin=upper, ymax=lower), width=0.2, size=1, color="blue") + 
           geom_point(data=d, mapping=aes(x=drink, y=mean), size=4, shape=21, fill="white") 

#geom_pointrange()
d=data.frame(drink=c("coffee","tea","water"), 
             mean=c(3,6,2), 
             lower=c(2.6,5.6,1.8), 
             upper=c(3.5,6.3,2.8)) 
ggplot() + geom_pointrange(data=d, mapping=aes(x=drink, y=mean, ymin=upper, ymax=lower), width=0.2, size=1, color="blue", fill="white", shape=22) 
