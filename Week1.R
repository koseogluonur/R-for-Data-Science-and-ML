43+35

43-35

12*8

100/8

2^4 #power

100 %% 8

5<8

2+2==5

T==TRUE

F==FALSE

X=5
x=5
y=8
z=x+y

sqrt(16)
sqrt(c(1,4,9,16,25))

x<- c(6, 8, 10, 12, 14)
sum(x)

y<- c(6, 8, 10, 12, NA)
sum(y,na.rm = TRUE)

z <- c(T, T, F, F, F, T, T)
sum(z)


install.packages("DandEFA")

library(DandEFA)

help(package="DandEFA")

x <- c(10.4, 5.6, 3.1, 6.4, 21.7) # Numeric Vector
x
x <- c(10.4, 5.6, 3.1, 6.4, 21.7) # Numeric Vector
x

x <- c("boy","girl","boy","girl","boy","boy") # character vector
x

x <- c(TRUE,TRUE,FALSE,TRUE,TRUE,FALSE) # logical vector
x

c(10, 20, 26, T) # numeric and logical values

x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x[5]

ind <- c(1,3,5)
x[ind]

ind <- c(F,T,F,T,F)
x[ind]

x <- c(10.4, 5.6, 3.1, 6.4, 21.7) # Numeric Vector
ind <- (x > 7)
ind

x[ind]

x[x>7]

x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
y <- c(4, 7, 8, 2, 35)
ind <- (x > y)
ind

x[ind]

x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x[4] <- 7.3
x

x <- c(10.4, NA, 3.1, 6.4, NA)
is.na(x)
sum(is.na(x))

mean(x)
mean(x,na.rm = T)

mean(x[!is.na(x)])

satisfaction <- c(1, 3, 4, 2, 2, 3, 4, 2, 1, 2, 1, 1, 4, 3)
fsatisfaction <- factor(satisfaction, 
                        levels=1:5, 
                        labels = c("very poor", "poor", "average","good", "very good"))
fsatisfaction
