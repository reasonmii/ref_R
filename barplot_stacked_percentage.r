
# ---------------------------------------------------------------------
# lapply vs do.call
#
# lapply
# 1) 인수로 받은 함수를 인수로 받은 리스트의 각각의 인덱스에 하나하나 적용
# 2) 인수로 받은 함수를 인덱스의 요소만큼 실행
# ex) 실행방법 : rbind(x[[1]]) rbind(x[[2]]) 
 
# do.call
# 1) 인수로 받은 함수를 리스트의 인덱스 전체에 적용
# 2) 한번만 실행
# ex) 실행방법 : rbind(x[[1]],x[[2]]) 
# ---------------------------------------------------------------------

library(dplyr)

# Calculate the total number of each category
# Category1 : seg (churn, change)
# Category2 : sex (female, male, etc)

cnt <- data %>%
  group_by(seg, sex) %>%
  summarise(n=n())


# ---------------------------------------------------------------------
# Percentage of 'female' in each seg (churn, change)
# ex) churn = female + male = 100%
# ---------------------------------------------------------------------

pcnt1 <- do.call(rbind,
                 lapply(split(cnt, cnt$seg), function(x){x[x$sex=='FEMALE', 'n']/sum(x$n)}))

# Change the column's name to 'pcnt'
names(pcnt1) <- 'pcnt'

# Add column called category1, 'seg'
pcnt1$seg <- rownames(pcnt1)

# Add column called category2, 'sex'
pcnt1$sex <- 'female'


# ---------------------------------------------------------------------
# Percentage of 'male' in each seg (churn, change)
# ex) churn = female + male = 100%
# ---------------------------------------------------------------------

pcnt2 <- do.call(rbind,
                 lapply(split(cnt, cnt$seg), function(x){x[x$sex=='MALE', 'n']/sum(x$n)}))

# Change the column's name to 'pcnt'
names(pcnt2) <- 'pcnt'

# Add column called category1, 'seg'
pcnt2$seg <- rownames(pcnt2)

# Add column called category2, 'sex'
pcnt2$sex <- 'male'


# ---------------------------------------------------------------------
# Merge
# ---------------------------------------------------------------------

mg <- rbind(pcnt1, pcnt2)


# ---------------------------------------------------------------------
# Add column for cumulative sum of each category
# This is for ggplot's labeling's position
# ---------------------------------------------------------------------

# transform() : 연산결과를 다른 변수에 저장
mg <- ddply(mg,
            .(seg),
            transform,
            pos = cumsum(pcnt))


# ---------------------------------------------------------------------
# Cumulative Percentage Plot
# ---------------------------------------------------------------------

# Cumultive part's color
fill <- c("#ffa8a8", "#91af77")

# axis.line : x-axis, y-axis line

# grid.major : X line and y line in graph
# grid.minor : X line and y line in graph (dense line)
# Option : element_line(colour = "black") / element_line(color='red') / element_blank()

ggplot(data=mg, aes(x=seg, y=pcnt, fill=sex, label=pcnt)+
 geom_bar(aes(y=pcnt, x=seg, fill=sex), data=mg, stat="identity")+
 geom_text(data=mg,
           aes(x=seg, y=pos, label=paste0(round(pcnt*100),"%")),
           colour="black",
           family="Tahoma",
           position=position_stack(vjust=0.5),
           size=4)+
 theme(legend.position="bottom",
       legend.direction="horizontal",
       legend.title=element_blank())+
 labs(x="SEG", y="Percentage")+
 ggtitle("Compare Percentage (%)")+
 scale_fill_manual(values=fill)+
 theme(axis.line = element_line(size=1, colour="black"),
       panel.grid.major = element_line(colour="#d3d3d3"),
       panel.grid.minor = element_blank(),
       panel.border = element_blank(),
       panel.background = element_blank())+
 theme(plot.title = element_text(size=14, family="Tahoma", face="bold"),
       text=element_text(family="Tahoma"),
       axis.text.x = element_text(colour="black", size=10),    # x label
       axis.text.y = element_text(colour="black", size=10))+   # y label
       
