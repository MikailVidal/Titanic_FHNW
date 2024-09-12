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


# Verteilung der Todesopfer und überlebenden nach Alter
ggplot(passengers, aes(x = Age, fill = factor(Survived))) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(x = "Alter", y = "Anzahl") +
  scale_fill_manual(values = c("#A70709", "green"), labels = c("Nicht Überlebt", "Überlebt"))

# Warscheindlichkeit für Tod bei 25 Jährigen
filtered_data <- subset(passengers, Age == 25)
ggplot(filtered_data, aes(x = Age, fill = factor(Survived))) +
  geom_histogram(binwidth = 1, position = "dodge") +
  labs(x = "Alter", y = "Anzahl") +
  scale_fill_manual(values = c("#A70709", "green"), labels = c("Nicht Überlebt", "Überlebt"))



# Analyse ob Daten der Passagier Tickets ähndlichkeiten haben -> alle sitzen in der gleichen Klasse 
passengers$Ticket <- as.character(passengers$Ticket)

ticket_list <- c("19928", "19950", "PC 17755", "110152", "19929")

ticket_numbers <- subset(passengers, Ticket %in% ticket_list)
print(ticket_numbers)


