x <- c(1,2,3,4,5)
y<-c(3,5)

y %in% x

mtcars
summary(mtcars)
head(mtcars)
str(mtcars)

apply(mtcars,2,table)

mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs, labels = c("V-shaped", "straight"))
mtcars$am <- factor(mtcars$am, labels = c("automatic", "manual"))
mtcars$carb <- as.factor(mtcars$carb)
mtcars$gear <- as.factor(mtcars$gear)
summary(mtcars)

plot(mtcars$mpg, mtcars$disp)

plot(mtcars$mpg, mtcars$disp, col = "blue", 
     main="Scatterplot of the miles per gallon vs displacement", 
     xlab = "Miles per gallon (MPG)",
     ylab = "Displacement")

hist(mtcars$mpg)
hist(mtcars$mpg, 3)

hist(mtcars$mpg, 20, main="Histogram of Miles per Gallon (MPG)",
     xlab = "Miles per Gallon",
     ylab = "Quantity")

table(mtcars$cyl)
barplot(table(mtcars$cyl))

barplot(table(mtcars$cyl),
        col = "red",
        xlab = "Cylinders",
        ylab = "Frequency")

boxplot(mpg ~ cyl, data = mtcars)

install.packages("ggplot2")
library(ggplot2)

ggplot(data = mtcars)+
  geom_point(aes(x = mpg, y = disp))

ggplot(data = mtcars, aes(x=mpg, y=disp))+ geom_point()
  
ggplot(mtcars)+
  geom_histogram(aes(mpg))

ggplot(mtcars)+
  geom_histogram(aes(mpg), fill = "blue")

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl))

ggplot(data = mtcars)+
  geom_boxplot(mapping = aes(x= cyl, y= mpg))

ggplot(data = mtcars)+
  geom_boxplot(aes(x= cyl, y= mpg))

ggplot(data = mtcars)+
  geom_point(aes(x = mpg, y = disp), color = "blue")

ggplot(data = mtcars)+
  geom_point(aes(x = mpg, y = disp, color = cyl))

ggplot(data = mtcars)+
  geom_point( aes(x = mpg, y = disp, color = hp))

ggplot(data = mtcars)+
  geom_point(aes(x = mpg, y = disp),size = 10)

ggplot(data = mtcars)+
  geom_point(aes(x = mpg, y = disp, size = hp))

ggplot(data = mtcars)+
  geom_point( mapping = aes(x = mpg, y = disp), alpha = 0.3)

ggplot(data = mtcars)+
  geom_point(mapping = aes(x = mpg, y = disp, alpha = hp))

ggplot(data = mtcars)+
  geom_point(mapping = aes(x = mpg, y = disp), shape = 25)

ggplot(data = mtcars)+
  geom_point(mapping = aes(x = mpg, y = disp, shape = cyl))

ggplot(data = mtcars)+
  geom_point(mapping = aes(x = mpg, y = disp)) + 
  facet_wrap(~ cyl, nrow = 1)

ggplot(data = mtcars)+
  geom_point(mapping = aes(x = mpg, y = disp)) + 
  facet_wrap(am~ cyl, nrow = 2)

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl))

ggplot(data = mtcars)+
  geom_col(aes(x = as.factor(cyl), y=mpg))

library(dplyr)

ggplot(data =mtcars %>% group_by(cyl) %>% summarise(mean_mpg = mean(mpg)))+
  geom_col(aes(x = (as.factor(cyl)), y= mean_mpg))+
  ylab("Mean mpg")+
  xlab("Number of Cylinders")

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl, color = cyl))

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl, fill = cyl))

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl, y = ..prop.., group = 1))

ggplot(data = mtcars)+
  geom_bar(mapping = aes(x = cyl, fill = cyl)) +
  ggtitle("Barplot for the number of cylinders") +
  xlab("Number of cylinders") +
  ylab("frequency") +
  theme_minimal()

pairs(mtcars[,c(1,3:7)])

cor(mtcars[,c(1,3:7)])

heatmap(cor(mtcars[,c(1,3:7)]))

cor_mtcars <- cor(mtcars[,c(1,3:7)])

cor_df <- data.frame(rep(colnames(cor_mtcars),each=length(colnames(cor_mtcars))),
                     rep(colnames(cor_mtcars),length(colnames(cor_mtcars))),
                     as.vector(cor_mtcars))

colnames(cor_df) <- c("X1","X2","Corr")
cor_df

ggplot(data = cor_df, aes(x=X1, y=X2, fill=Corr)) +
  geom_tile(color = "white") + 
  scale_fill_gradient2(low = "blue", high = "red" ,mid = "white", 
                       midpoint = 0 ,limit = c(-1,1))


pima <- read.csv("pima.csv")
str(pima)
head(pima)
summary(pima)

pima$AgeGroups <- cut(pima$Age,c(20,40,60,81))
table(pima$AgeGroups)

barplot(table(pima$AgeGroups))

ggplot(data=pima) +
  geom_bar(aes(x=AgeGroups, fill=AgeGroups))

ggplot(data=pima) +
  geom_bar(mapping = aes(x=AgeGroups, fill = AgeGroups))
  theme_minimal()
  
barplot(table(pima$Diabetes, pima$AgeGroups),
        legend.text = T)

ggplot(data=pima) +
  geom_bar(mapping = aes(x=AgeGroups, fill = Diabetes))

ggplot(pima, aes(BMI))+ 
  geom_histogram(binwidth = 5, fill = "blue")+
  theme_bw()

ggplot(pima, aes(BMI))+ 
  geom_histogram(binwidth = 10, fill = "green")+
  theme_bw()

ggplot(pima, aes(BMI))+ 
  geom_histogram(binwidth = 10, fill = "red")+
  theme_bw()+
  facet_grid(~ Diabetes)

ggplot(pima, aes(NTP, fill= Diabetes))+ 
  geom_histogram(binwidth = 3)+
  theme_bw()+
  facet_grid(~ AgeGroups)

boxplot(pima$NTP, xlab = "Number of times getting pregnant")

boxplot(NTP ~ AgeGroups, data = pima)

ggplot(data = pima)+
  geom_boxplot(mapping = aes(x= AgeGroups, y= NTP))+
  facet_grid(~ Diabetes)

plot(pima$PGC,pima$DBP)

ggplot(pima)+
  geom_point(aes(x=PGC, y=DBP))

ggplot(pima)+
  geom_point(aes(x=PGC, y=DBP, col = Diabetes))

pairs(pima[,1:8], col = as.factor(pima$Diabetes))

cor_pima <- cor(pima[,1:8])
cor_pima

colnames_pima <- colnames(cor_pima)

cor_pima_data <- data.frame(rep(colnames_pima,each=length(colnames_pima)),
                            rep(colnames_pima,length(colnames_pima)),
                            as.vector(cor_pima))

colnames(cor_pima_data) <- c("X1","X2","Corr")
cor_pima_data[1:12,]

ggplot(data = cor_pima_data, aes(x=X1, y=X2, fill=Corr)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red" ,mid = "white", 
                       midpoint = 0,limit = c(-1,1))