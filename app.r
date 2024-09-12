library(tidyverse)
library(tidymodels)
library(ggmosaic)
library(ggalluvial)
library(rpart)
library(rpart.plot)
library(dplyr)

# Add Titanic Passengers Data Set
passengers <- read.csv("Mini-Challenge_Titanic.csv", sep = ";")

# Mutate and sort data

# Sum Siblings, Parents, Children and Spouses for a total of family members
passengers <- passengers %>% mutate(FamilyMembers = passengers$SibSp + passengers$Parch)
# Add an age class for children, teenagers, young adults, adults and seniors depending on the age
passengers <- passengers %>% mutate(AgeCategory = case_when(passengers$Age <= 12 ~ "Child",
                                                            passengers$Age <= 19 ~ "Teenager",
                                                            passengers$Age <= 29 ~ "Young Adult",
                                                            passengers$Age <= 49 ~ "Adult",
                                                            is.numeric(passengers$Age) ~ "Senior",
                                                            TRUE ~ "Unknown",))
# Assign the passengers an age of 1 if the value is lower than 1 but older than 0
passengers$Age[passengers$Age > 0 & passengers$Age < 1] <- 1

# Delete entries where the age is under 0 or the amount of family members surpasses 20
passengers <- passengers %>% filter(!(Age < 0 | FamilyMembers > 20))

ggplot(passengers, aes(x = Age, fill = factor(Survived))) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(x = "Alter", y = "Anzahl") 