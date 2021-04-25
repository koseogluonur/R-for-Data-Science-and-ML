#sUPERVISED LEARNING/CLASSIFICATION MODELS

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
pred <- knn(training_data, testing_data, training_labels) #General Formula

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
head(signs_train$sign_type)
head(signs_test$sign_type)

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


#LOGISTIC REGRESSION ALGORITHM

m <- glm(y ~ x1 + x2 + x3, data = my_dataset, family = "binomial")
prob <- predict(m, test_dataset, type = "response")
pred <- ifelse(prob > 0.50, 1, 0)             #General Formula

donors <- read.csv("donors.csv")
dim(donors)

str(donors)

table(donors$donated)

#Seperate data with training and test data

set.seed(100) # Ensure the results are same for everybody

donors_shuffled <- donors[sample(nrow(donors)),] # shuffle the data
k <- 0.7 # training - test split ratio

training_data <- donors_shuffled[1:round(k*nrow(donors_shuffled)),] # select rows for training data

test_data <- donors_shuffled[(round(k*nrow(donors_shuffled))+1)
                             :nrow(donors_shuffled),] # select rows for the test data


donors_logreg_model <- glm(donated ~ bad_address + interest_religion + interest_veterans, data = training_data, family = "binomial")
prob <- predict(donors_logreg_model, test_data, type = "response")
pred <- ifelse(prob > 0.0504, 1, 0)  #0.0504 orani bagis yapanlar ve yapmayanlarin orani seklinde bulunur.(1/0)

donors_logreg_model
summary(donors_logreg_model)

head(prob)

table_logistic_regression <- table("actual" =test_data$donated, pred)

sum(diag(table_logistic_regression))/sum(table_logistic_regression)
mean(test_data$donated == pred)

#Let's construct another model to look for the relation between wealth_rating and donated.

donors_logreg_model <- glm(donated ~ wealth_rating, data = training_data, family = "binomial")
prob <- predict(donors_logreg_model, test_data, type = "response")
pred <- ifelse(prob > 0.0504, 1, 0)

table("actual" =test_data$donated, pred)
mean(test_data$donated == pred)
summary(donors_logreg_model)

#Actually wealth_rating seems categorical. 
#Let's see if changing this variable to categorical variable affects the performance of the model.

table(donors$wealth_rating)

training_data$wealth_rating <- factor(training_data$wealth_rating, levels = 0:3, labels = c("Unknown", "Low", "Medium", "High"))
test_data$wealth_rating <- factor(test_data$wealth_rating, levels = 0:3, labels = c("Unknown", "Low", "Medium", "High"))

donors_logreg_model <- glm(donated ~ wealth_rating, data = training_data, family = "binomial")
prob <- predict(donors_logreg_model, test_data, type = "response")
pred <- ifelse(prob > 0.0504, 1, 0)

table("actual" =test_data$donated, pred)

mean(test_data$donated == pred)

summary(donors_logreg_model)

#We observed that in Logistic Regression it does not matter if affected variable is categorical or not.
#In KNN it is important.
#Logistic regresyonda Bagimli degisken iki kategoride olmak zorunda yani 0 ve 1 gibi 50 ve 100 gibi vs



#DECISION TREES ALGORITHM

# building a simple rpart classification tree
install.packages("rpart")
library(rpart)
m <- rpart(outcome ~ loan_amount + credit_score, data = loans,
           method = "class")

# making predictions from an rpart tree
p <- predict(m, test_data, type = "class")  #General Formula

loans <- read.csv("loans.csv")

str(loans)

table(loans$outcome)

set.seed(100) # Ensure the results are same for everybody

loans_shuffled <- loans[sample(nrow(loans)),] # shuffle the data
k <- 0.7 # training - test split ratio

training_data <- loans_shuffled[1:round(k*nrow(loans_shuffled)),] # select rows for training data

test_data <- loans_shuffled[(round(k*nrow(loans_shuffled))+1)
                            :nrow(loans_shuffled),] # select rows for the test data

# Load the rpart package
library(rpart)

# Build a lending model predicting loan outcome versus loan amount and credit score
loan_model <- rpart(outcome ~ loan_amount + credit_score, data = training_data, method = "class", control = rpart.control(cp = 0))

# Make a prediction for someone with good credit
pred <- predict(loan_model, test_data, type = "class")

table("actual" = test_data$outcome, pred)

mean(test_data$outcome == pred)

sum(diag(table("actual" = test_data$outcome, pred)))/ sum(table("actual" = test_data$outcome, pred))

loan_model

#This is rather complicated we need to visualize the tree.
#The rpart.plot() package can be use to visualize a decision tree.

install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(loan_model)

# pre-pruning with rpart
library(rpart)
prune_control <- rpart.control(maxdepth = 30, minsplit = 20)
m <- rpart(outcome ~ credit_score + loan_amount, data = loans, method = "class", control = prune_control)
rpart.plot(m)

# post-pruning with rpart
m <- rpart(outcome ~ credit_score + loan_amount, data = loans, method = "class")

plotcp(m)
m_pruned <- prune(m, cp = 0.20)
m_pruned <- prune(m, cp = 0.033)
rpart.plot(m_pruned)


# Grow a tree with maxdepth of 6
loans_model <- rpart(outcome ~ ., data = training_data, 
                     method = "class", control = rpart.control(cp=0, maxdepth=6))

rpart.plot(loans_model)

# Make a class prediction on the test set
test_data$pred <- predict(loans_model, test_data, type = "class")

# Compute the accuracy of the simpler tree
mean(test_data$outcome==test_data$pred)


# Grow an overly complex tree
loans_model <- rpart(outcome ~ ., data = training_data, method = "class", control = rpart.control(cp = 0))


# Examine the complexity plot
plotcp(loans_model)

# Prune the tree
loan_model_pruned <- prune(loans_model, cp = 0.0014)

rpart.plot(loan_model_pruned)

# Compute the accuracy of the pruned tree
test_data$pred <- predict(loan_model_pruned, test_data, type = "class")
mean(test_data$pred == test_data$outcome)