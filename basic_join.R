library(eidith)
library(tidyverse)

target.events <- c("BD-Benapole-Porabari-2016Aug29", "BD-Chandpur-Puran Bazar-2015Sep08")

events <- ed2_events(event_name %in% target.events) %>%
  select(country, site_name, event_name, human_density_impact)

animals <- ed2_animals() %>%
  select(animal_id, event_name, species_scientific_name)

subset.animals <- animals %>%
  filter(event_name %in% target.events)


little.join <- left_join(events, animals, by = "event_name")
