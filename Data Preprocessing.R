data <- read.csv("earnings.csv")
head(data)

summary(data)

table(data$gender)
table(data$age)
table(data$earnings)

data$gender <- ifelse(data$gender==11,1,data$gender)

data$gender <- ifelse(data$gender==22,2,data$gender)
table(data$gender)

data$gender <- ifelse(data$gender==11,1,ifelse(data$gender==22,2,data$gender))

data$age <-ifelse(data$age<0,NA,data$age)
summary(data$age)

data$earnings <- ifelse(data$earnings<0,NA,data$earnings)
summary(data$earnings)

data$gender[data$gender == 11] <- 1
data$gender[data$gender == 22] <- 2
table(data$gender)

data$gender <- factor(data$gender,levels=1:2,
                      labels = c("male","female"))
table(data$gender)

data$age[data$age <= 0] <- NA
data$earnings[data$earnings <= 0] <- NA
table(data$age)
table(data$earnings)

summary(data)

data$earnings <- ifelse(is.na(data$earnings), mean(data$earnings, na.rm = TRUE), data$earnings)

table(data$age)

as.numeric(names(which.max(table(data$age))))

summary(data$earnings)

data$age <- ifelse(is.na(data$age), 29, data$age)

summary(data)

wave <- read.csv("siswave.csv",header=T, sep=",")
dim(wave)

head(wave)
str(wave)
summary(wave)

wave$rearn <- ifelse(wave$rearn<0 , NA, wave$rearn)
wave$tearn <- ifelse(wave$tearn<0 , NA, wave$tearn)
summary(wave)

wave$sex <- factor(wave$sex,levels=1:2,
                   labels = c("male","female"))
wave$race <- factor(wave$race,levels=1:4,
                    labels =c("white","black","hispanic","other"))
wave$immig <- factor(wave$immig,levels=0:1,
                     labels = c("citizen","not_citizen"))
wave$educ_r <- factor(wave$educ_r,levels=1:4,
                      labels = c("no_HS","HS","some_coll","college_grad"))
summary(wave)

wave <- wave[!is.na(wave$immig),]
wave <- wave[!is.na(wave$educ_r),]
wave <- wave[!is.na(wave$race),]
summary(wave)

male <- ifelse (wave$sex=="male", 1, 0)
over65 <- ifelse (wave$r_age>65, 1, 0)
white <- ifelse (wave$race == "white", 1, 0)

wave <- data.frame(wave, male, over65, white)
head(wave)

wave_naomit <- wave[!is.na(wave$rearn),] # training data
head(wave_naomit)

wave_nonena <- wave[is.na(wave$rearn),] # test data
head(wave_nonena)

lm.imp <- lm (rearn~ over65 + male + white,
              data=wave_naomit)
lm.imp

predicted_earnings <- predict(lm.imp,wave_nonena[,-1])
summary(predicted_earnings)

predicted_earnings[predicted_earnings<0] <- 0


wave$rearn[is.na(wave$rearn)] <- predicted_earnings
summary(wave)
