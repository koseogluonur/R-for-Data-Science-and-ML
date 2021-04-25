x <- 3

if(x > 4){
  cat("x is bigger than 4")
} else {
  cat("x is smaller or equal than 4")
}

set.seed(100)

x <- rnorm(12)
x

for(i in 1:length(x))
{
  if(x[i] > 0){
    x[i] <- 1
  } else {
    x[i] <- 0
  }
}
x

set.seed(100)

x <- rnorm(12)
x

ifelse(x > 0, 1, 0)

square <- function(x)
{
  x_square <- x*x
  return(x_square)
}

square(3)

ifelse_new <- function(x, break_point, true_arg, false_arg)
{
  y <- x
  
  for (i in 1:length(x))
  {
    if(x[i] > break_point)
    {
      y[i] <- true_arg
    } else{
      y[i] <- false_arg
    }
  }
  return(y)
}

set.seed(100)
ifelse_new(rnorm(12), 0, 1, 0)

ifelse_new(seq(1:20), 12, 99, 999)

iris
head(iris)
head(iris,3)
tail(iris,3)
summary(iris)

str(iris)

mean(iris[,1])
mean(iris$Sepal.Length)

for(i in 1:4){
  print(mean(iris[,i]))
}

averages<-NULL

for(i in 1:4){
  averages[i] <- mean(iris[,i])
}
averages


apply(iris[,-5], 2, mean)

set.seed(100)
L1 <- list(sample(1:10,50,replace = TRUE), 
           rep(c(1,2),30), 
           rep(c("training","test"),each=20))
L1

lapply(L1,table)


head(iris[iris$Species =="setosa",])

mean(iris[iris$Species =="setosa",]$Sepal.Length)
mean(iris[iris$Species =="virginica",]$Sepal.Length)

pima <- read.csv("pima.csv", header = TRUE, sep = ",")
head(pima)
str(pima)
summary(pima)
