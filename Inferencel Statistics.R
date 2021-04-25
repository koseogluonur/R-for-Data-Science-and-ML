hsb2 <- read.csv("hsb2.csv",header=T,sep=";")
dim(hsb2)

str(hsb2)

hsb2$gender <- factor(hsb2$female, levels = c(0,1), labels = c("male", "female"))
hsb2$female <- NULL

hsb2$race <- factor(hsb2$race, levels = 1:4, 
                    labels = c("african american", "asian", "hispanic", "white"))


hsb2$ses <- factor(hsb2$ses, levels = 1:3, 
                   labels = c("low", "middle", "high"))


hsb2$schtyp <- factor(hsb2$schtyp, levels = 1:2, 
                      labels = c("public", "private"))

hsb2$prog <- factor(hsb2$prog, levels = 1:3, 
                    labels = c("general", "academic", "vocational"))

str(hsb2)

summary(hsb2)
mean(hsb2$read)
median(hsb2$read)
sd(hsb2$read)

apply(hsb2[,6:10], 2, mean)
apply(hsb2[,6:10], 2, median)
apply(hsb2[,6:10], 2, sd)

test_hsb2read <- t.test(hsb2$read,conf.level = 0.99)
names(test_hsb2read)

test_hsb2read$conf.int
test_hsb2read$p.value
test_hsb2read

mean(hsb2$read) - qnorm(1-0.01/2) * sd(hsb2$read)/sqrt(200-1)
mean(hsb2$read) + qnorm(1-0.01/2) * sd(hsb2$read)/sqrt(200-1)

#H0: Mean of reading score is 55 (X¯¯¯¯Read=52)
#H1: Mean of reading score is not 55 (X¯¯¯¯Read???52)

t.test(hsb2$read, mu = 52, alternative = "two.sided")
t.test(hsb2$read, mu = 55, alternative = "two.sided")

library(ggplot2)

ggplot(hsb2) +
  geom_boxplot(aes(gender, write))

ggplot(hsb2) +
  geom_boxplot(aes(gender, read))

library(gplots)

plotmeans(write ~ gender,data = hsb2)
plotmeans(read ~ gender,data = hsb2)

t.test(hsb2$read ~ hsb2$gender, alternative = "two.sided", var.equal = TRUE)
t.test(hsb2$write ~ hsb2$gender, alternative = "two.sided", var.equal = TRUE)

var.test(write~gender,data=hsb2)

t.test(hsb2$read ~ hsb2$gender, alternative = "two.sided", var.equal = FALSE)
t.test(hsb2$write ~ hsb2$gender, alternative = "two.sided", var.equal = FALSE)

shapiro.test(hsb2$read[hsb2$gender=="male"])
shapiro.test(hsb2$read[hsb2$gender=="female"])
shapiro.test(hsb2$write[hsb2$gender=="male"])
shapiro.test(hsb2$write[hsb2$gender=="female"])

layout(matrix(1:2,nrow=1))

qqnorm(hsb2$write, main = "Writing Score")
qqline(hsb2$write)

qqnorm(hsb2$read, main = "Reading Score")
qqline(hsb2$read)

wilcox.test(write~gender,data = hsb2)
wilcox.test(read~gender,data = hsb2)

table_gender_prog <- table(hsb2$gender, hsb2$prog)
table_gender_prog

chisq.test(table_gender_prog)

library(ggplot2)

ggplot(hsb2) +
  geom_bar(mapping = aes(gender, fill = prog))

library(ggplot2)

ggplot(hsb2) +
  geom_bar(mapping = aes(gender, fill = ses))

chisq.test(table(hsb2$ses, hsb2$prog))

ggplot(hsb2) +
  geom_bar(mapping = aes(ses, fill = prog))

model <- lm(math ~ prog, data = hsb2)

anova(model)

plotmeans(math~prog,data = hsb2)

ggplot(hsb2)+
  geom_boxplot(aes(prog, math))

library(multcomp)
summary(glht(model,linfct=mcp(prog="Tukey")))

shapiro.test(model$residuals)
bartlett.test(math ~ prog,data=hsb2)

kruskal.test(math ~ prog, data = hsb2)

library(FSA)
dunnTest(math ~ prog,data=hsb2)