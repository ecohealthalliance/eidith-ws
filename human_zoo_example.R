# Example from slide 16

library(eidith)
library(tidyverse)

human <- ed2_human()

human_zoo <- ed2_human_zoo()

#check out the help file to see different fields
?ed2_metadata

human.reduced <- select(human, participant_id, gender, age)

zoo.join <- right_join(human.reduced, human_zoo, by = "participant_id")

expanded <- zoo.join %>%
  mutate(cat_split = str_split(animals_work_with, "; ")) %>%
  unnest()

ggplot(data = expanded) +
  geom_bar(aes(x = cat_split)) +
  theme_minimal()

ggplot(data = expanded) +
  geom_bar(aes(x = cat_split, fill = gender)) +
  theme_minimal()

ggplot(data = expanded) +
  geom_bar(aes(x = cat_split, fill = age < 40)) +
  theme_minimal()


# good example of a helper function to be worked into eidith later

expand_column_long <- function(df, col_name){
  col_name <- enquo(col_name)
  new_df <- df %>%
    mutate(cat_split = str_split(!!(col_name), "; ")) %>%
    unnest()
  return(new_df)
}

# using the function will do the same thing!

expanded_copy <- expand_column_long(zoo.join, animals_work_with)

ggplot(data = expanded_copy) +
  geom_bar(aes(x = cat_split, fill = age < 40)) +
  theme_minimal()
