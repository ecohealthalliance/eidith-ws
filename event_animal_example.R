# Example from slide 12

library(eidith)
library(tidyverse)

events <- ed2_events()
animals <- ed2_animals()

# if there's an animal without an event, it will be left out of this join
# if there's an event with no animals, all the fields from the Animal table will fill with NA's
ea.joined <- left_join(events, animals, by = "event_name")

ea.reduced <- select(ea.joined,event_name, country, animal_id, species_scientific_name)

ea.summary <- group_by(ea.reduced, country, species_scientific_name) %>%
  summarize(species_num = n())

ggplot(data = ea.summary) +
  geom_bar(aes(x = country)) +
  theme_minimal() + 
  labs(title = "Number of Species by Country")

ggplot(data = ea.summary) +
  geom_bar(aes(x = country, y = species_num), stat = "identity") +
  theme_minimal()

ggplot(data = ea.summary) +
  geom_bar(aes(x = country, y = species_num, fill = species_scientific_name), stat = "identity") +
  theme_minimal() +
  theme(legend.position = "none")
