set.seed(100) # to ensure the numbers are same for each of you
m <- rnorm(12,0,1)
m

str(m)

dim(m) <- c(3,4)
m


set.seed(100) # to ensure the numbers are same for each of you
m <- rnorm(12)
m

m  <- matrix(m, nrow = 3, ncol = 4, byrow = F)
m

m  <- matrix(m, nrow = 3, ncol = 4, byrow = T)
m

nrow(m)
ncol(m)
t(m)


colnames(m) <- c("A", "B", "C", "D")
m

rownames(m) <- c("Number1","Number2","Number3")
m

set.seed(100)

X1 <- rnorm(12)
X2 <- 1:12
m <- cbind(X1,X2)
m

rbind(X1,X2)

set.seed(100)
data_1 <- matrix(rnorm(12),nrow=3,ncol=4,byrow=T)
data_2 <- matrix(rnorm(16),nrow=4,ncol=4,byrow=F)
data_new <- rbind(data_1,data_2)
data_new

set.seed(100) # to ensure the numbers are same for each of you
m  <- matrix(rnorm(12), nrow = 3, ncol = 4, byrow = F)
m

m[1,]
m[,2]
m[-1,]

m[, -c(1,3)]

index_row <- 1:3
index_col <- c(1,3,4)

m[index_row,index_col]

m[1:3,c(1,3,4)]

set.seed(100)

m <- matrix(rnorm(21),nrow=7,ncol=3,byrow=T)
m

set_m <- rep(c(1,2),c(3,4))
set_m <- factor(set_m,levels = 1:2,
                labels = c("training","test"))
set_m

m
cbind(m,set_m)

m <- cbind(m,set_m)
m

colnames(m) <- c("X1","X2","X3","Set")
m

m[set_m =="training",]
m[set_m =="test",]


L1 <- list(name="Fred", wife="Mary", 
           no.children=2, 
           child.ages=c(4,7,9),
           is.tall = TRUE)
L1

L1[[3]]
L1[3]

L1[c(1,3)]

L1$is.tall

set.seed(100)
data_new <- matrix(rnorm(21),nrow=7,ncol=3,byrow=T)
data_new
set_data <- rep(c(1,2),c(3,4))

set_data <- factor(set_data,levels = 1:2,
                   labels = c("training","test"))
set_data

table_set <- table(set_data)
table_set

dim_data <- dim(data_new)
dim_data

data_info <- list(data = data_new, set = set_data,
                  set_info = table_set, dim = dim_data)

names(data_info)

data_info

data_info$dim

mean_weight <- c(179.3, 179.9, 180.5, 180.1, 180.3, 180.4)
mean_weight

Gender <- c("M", "M", "F", "F", "M", "M")
Gender

Gender <- factor(Gender,levels=c("M","F"))
Gender

cbind(mean_weight,Gender)
rbind(mean_weight,Gender)

d <- data.frame(mean_weight, Gender)
d

d <- list(mean_weight=mean_weight,Gender=Gender)
d

d <- as.data.frame(d)
d

d <- cbind(mean_weight,Gender)
d

d$mean_weight # output in vector format
d[["mean_weight"]] # output in vector format
d[,1] # output in vector format
d[,"mean_weight"] # output in vector format
d["mean_weight"] # output in dataframe format
d[1] # output in dataframe format
d[2]

d[c(1,4,5),] # Shows 1., 4. and 5. rows of the dataframe
d[1:3,"mean_weight"]
d[1:3,"mean_weight",drop=FALSE]

d
d$color <- NA
d$weight_two_times <- d$mean_weight*2
d


