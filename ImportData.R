getwd()


pima_data <- read.table("pima.dat", header = TRUE, sep = " ")
head(pima_data)
str(pima_data)

pima_csv <- read.csv("pima.csv", header = TRUE, sep = ",")
head(pima_csv)

install.packages("xlsx", repos = "Turkey")

install.packages("xlsx")

library(xlsx)

pima_xls <- read.xlsx("pima.xls", sheetName = "pima", header = T)
head(pima_xls)

install.packages("xlsx", repos = "Turkey") # Install if not installed previously

library(xlsx)

pima_xls <- read.xlsx("pima.xls", sheetName = "pima", header = T)
head(pima_xls)