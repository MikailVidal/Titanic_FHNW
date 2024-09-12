library(tidyverse)
library(tidymodels)
library(ggmosaic)
library(ggalluvial)
library(rpart)
library(rpart.plot)



passengers <- read.csv("Mini-Challenge_Titanic.csv", sep = ";")


# Group and filter passengers by age and survival
print("Group by")
print(passengers %>% group_by(Age) %>% summarise(survived = sum(Survived), .groups = 'drop'), n = 90)

passengers %>% summary()
#ggplot(data = subset(passengers, Age>0), mapping = aes(x = Age)) +
 # geom_bar()




ggplot(passengers, aes(x = Age, fill = factor(Survived))) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(x = "Alter", y = "Anzahl") 