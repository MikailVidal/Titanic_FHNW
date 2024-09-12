library(tidyverse)
library(tidymodels)
library(ggmosaic)
library(ggalluvial)
library(rpart)
library(rpart.plot)


setwd("/Users/mikailvidal/Projects/r_tutorial")

passengers <- read.csv("minichallenge_titanic-1661852450_modified-1726068537.csv", sep = ";")


# Group and filter passengers by age and survival
print("Group by")
print(passengers %>% group_by(Age) %>% summarise(survived = sum(Survived), .groups = 'drop'), n = 90)

