library(tidyverse)
library(tidymodels)
library(ggmosaic)
library(ggalluvial)
library(rpart)
library(rpart.plot)


setwd("/Users/mikailvidal/DataspellProjects/Titanic_FHNW")

passengers <- read.csv("Mini-Challenge_Titanic.csv", sep = ";")


# Group and filter passengers by age and survival
print("Group by")
print(passengers %>% group_by(Age) %>% summarise(survived = sum(Survived), .groups = 'drop'), n = 90)

passengers %>% summary()
