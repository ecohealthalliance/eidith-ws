# Example from slide 13

library(eidith)
library(tidyverse)

events <- ed2_events()
animals <- ed2_animals()
specimens <- ed2_specimens()
tests <- ed2_tests()

total.joined <- left_join(events, animals, by = "event_name") %>%
  left_join(specimens, by = c("animal_id" = "animal_human_id")) %>%
  left_join(tests, by = "specimen_id")

?ed_metadata
?ed2_metadata

events_p1 <- ed_events()

tests.summary <- total.joined %>%
  group_by(country, test_requested) %>%
  summarize(number_of_tests = n()) %>%
  filter(!is.na(test_requested)) #filtering out all the NA's

ggplot(data = tests.summary) +
  geom_bar(aes(x = country, y = number_of_tests, fill = test_requested), stat = "identity") +
  theme_minimal()
