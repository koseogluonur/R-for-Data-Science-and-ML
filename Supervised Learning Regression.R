#Linear Regression

library(ggplot2)

ggplot(mtcars) + aes(x=hp, y = mpg) + 
  geom_point() +
  ggtitle("Relation between horse power and miles per galloon") + 
  theme_bw()

model <- lm(mpg ~ hp, data = mtcars)
model

summary(model)

mtcars$pred <- predict(model) ## If you don't add a second argument that specifies the data,
                              ## it will make predictions based on the same data like training data.
library(ggplot2)
ggplot(mtcars) + aes(x=hp, y = mpg) + 
  geom_point() +
  geom_abline(intercept =  30.09886, slope = -0.06823, color = "red") +
  ggtitle("Relation between horse power and miles per galloon") + 
  theme_bw()

#Let's look if our model has a good fit by looking at true and predicted values

library(ggplot2)
library(ggplot2)
ggplot(mtcars) + aes(x=pred, y = mpg) + 
  geom_point() +
  geom_abline(color = "darkblue") +
  ggtitle("True values vs Predictions") + 
  theme_bw()

#Let's look if our model has a good fit by looking at the residual plot.
#First define the variable residual in our dataframe.

mtcars$residuals <- mtcars$mpg - mtcars$pred
mtcars$residuals

library(ggplot2)
ggplot(mtcars) + aes(x=pred, y = residuals) + 
  geom_point() +
  geom_hline(yintercept = 0, color = "darkblue") +
  ggtitle("Residuals vs Predictions") + 
  theme_bw()

#Let's find RMSE for the model we constructed.
sqrt(mean(mtcars$residuals^2))
sd(mtcars$mpg)

#Let's calculate the R2 for our model.

RSS <- sum((mtcars$mpg - mtcars$pred)^2)
SS_tot <- sum((mtcars$mpg - mean(mtcars$mpg))^2)

1- RSS/SS_tot

summary(model)
summary(model)$r.squared

correlation <- cor(mtcars$mpg,mtcars$pred)

correlation

correlation^2

model_mpg <- lm(mpg ~ hp + wt, data = mtcars)
summary(model_mpg)

sqrt(mean(model_mpg$residuals^2)) ## rmse of this model is much smaller than the model

model_mpg_interaction <- lm(mpg ~ hp + wt + hp:wt, data = mtcars) 
summary(model_mpg_interaction)
or
model_mpg_interaction <- lm(mpg ~ hp + wt + I(hp*wt), data = mtcars)
summary(model_mpg_interaction)

sqrt(mean(model_mpg_interaction$residuals^2))

#Sometimes the distribution of the outcome variable deviates from the normal distribution a lot with long tail values.
#This distribution is called log-normal data.It means that, a log transformation should be made before modeling.

log_model <- lm(log(mpg) ~ hp, data = mtcars)
summary(log_model)

mtcars$log_pred <- exp(predict(log_model))
head(mtcars)

summary(model)

sqrt(mean(model$residuals^2))
sqrt(mean(log_model$residuals^2))

sd(log(mtcars$mpg))

#Try to fit different models into the outcome.
model_sq <- lm(mpg ~ I(hp^2), data = mtcars)
summary(model_sq)

model_cubic <- lm(mpg ~ I(hp^3), data = mtcars)
summary(model_cubic)

model_exp <- lm(mpg ~ exp(hp), data = mtcars)
summary(model_exp)

model_log <- lm(mpg ~ log(hp), data = mtcars)
summary(model_log)


model
sqrt(mean(model$residuals^2))
summary(model)$r.squared

model_sq
sqrt(mean(model_sq$residuals^2))
summary(model_sq)$r.squared

model_cubic
sqrt(mean(model_cubic$residuals^2))
summary(model_cubic)$r.squared

model_exp
sqrt(mean(model_exp$residuals^2))
summary(model_exp)$r.squared

model_log
sqrt(mean(model_log$residuals^2))
summary(model_log)$r.squared


#Poisson and quasipoisson regression

load("bikes.rdata")
str(bikesAugust)

mean(bikesAugust$cnt)
var(bikesAugust$cnt)

#Variance of response variable is much higher than mean.
#Quasipoisson model should be preferred.

model_quasi <- glm(cnt ~ hr + holiday + workingday + 
                     weathersit + temp + atemp + 
                     hum + windspeed, data = bikesAugust, 
                   family = quasipoisson)

#Let's make predictions and calculate RMSE and Pseudo R2.
#Pseudo R2 is an alternative measure analogous to R2 in poisson regression.

bikesAugust$predictions <- predict(model_quasi, type = "response")
pseudoR2 <- 1- model_quasi$deviance/model_quasi$null.deviance
pseudoR2

bikesAugust$residuals <- bikesAugust$cnt - bikesAugust$predictions
sqrt(mean(bikesAugust$residuals^2))

sd(bikesAugust$cnt)

#Generalized additive models (GAM) to learn non-linear transformations
install.packages("nlme")
library(mgcv)

model_gam <- gam(mpg ~ s(hp), data = mtcars)
model_gam

summary(model_gam)
plot(model_gam)

#Random forests
#Random forests is a generalized version of the decision trees.

install.packages("ranger")
library(ranger)
model_rf <- ranger(mpg ~ hp, data =mtcars,
                   num.trees = 500,
                   respect.unordered.factors = "order")

sqrt(mean((model_rf$predictions - mtcars$mpg)^2))
model_rf$r.squared
model_rf

