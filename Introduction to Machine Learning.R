library(DT)

titanic <- read.csv("titanic.csv")

set.seed(100) # Ensure the results are same for everybody

titanic_shuffled <- titanic[sample(nrow(titanic)),] # shuffle the data
k <- 0.7 # training - test split ratio

training_data <- titanic_shuffled[1:round(k*nrow(titanic_shuffled)),] # select rows for training data
training_data
test_data <- titanic_shuffled[(round(k*nrow(titanic_shuffled))+1)
                              :nrow(titanic_shuffled),] # select rows for the test data
test_data
dim(training_data) # Look at the dimensions of the training data

dim(test_data)

head(training_data)

head(test_data)

#Code for splitting with cross validation is opitonla but we dont use thise method

#KNN Algorithm


library(class)

signs <- read.csv("knn_traffic_signs.csv")
str(signs)
head(signs)
table(signs$sample)

summary(signs)

table(signs$sign_type)

signs_train <- signs[signs$sample=="train",]
signs_test <- signs[signs$sample=="test",]

library(class)

signs_pred <- knn(train = signs_train[,-(1:3)],
                  test = signs_test[,-(1:3)],
                  cl = signs_train$sign_type)
head(signs_pred)

table_knn <- table("signs_actual" = signs_test[,3], signs_pred)
table_knn

sum(diag(table_knn))/sum(table_knn)
mean(signs_test[,3] == signs_pred)

signs_pred_k1 <- knn(train = signs_train[,-(1:3)], test = signs_test[,-(1:3)], cl = signs_train$sign_type)
mean(signs_test[,3] == signs_pred_k1)

signs_pred_k7 <- knn(train = signs_train[,-(1:3)], test = signs_test[,-(1:3)], cl = signs_train$sign_type, k=7)
mean(signs_test[,3] == signs_pred_k7)

signs_pred_k15 <- knn(train = signs_train[,-(1:3)], test = signs_test[,-(1:3)], cl = signs_train$sign_type, k=15)
mean(signs_test[,3] == signs_pred_k15)