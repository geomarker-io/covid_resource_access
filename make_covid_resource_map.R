library(tidyverse)
library(sf)
library(tmap)

d <- readxl::read_excel('COVID_Mapping_Geocode.xlsx') %>%
  st_as_sf(coords = c('long', 'lat'), crs = 4326)

t1 <- d %>% filter(Tier == "Tier1")
t2 <- d %>% filter(Tier == "Tier2")
t3 <- d %>% filter(Tier == "Tier3")

tmap_mode("view")

tm_basemap('CartoDB.Positron') +
  tm_shape(t1, name = "Tier 1") +
  tm_dots(col = "Group",
          title = "Tier 1",
          size = 0.07,
          alpha = 0.7,
          palette = c("#8dd3c7", "#bc80bd"),
          popup.vars = c("Group", "Location", "Days", "Times", "Ages")) +
  tm_shape(t2, name = "Tier 2") +
  tm_dots(col = "Group",
             title = "Tier 2",
          size = 0.07,
          alpha = 0.7,
          labels = c("Fire Station", "Kroger",
                     "Non Profit", "Public Health"),
          palette = c("#fb8072", "#80b1d3",
                      "#fdb462", "#b3de69"),
          popup.vars = c("Group", "Location")) +
  tm_shape(t3, name = "Tier 3") +
  tm_dots(col = "Group",
             title = "Tier 3",
          size = 0.07,
          alpha = 0.7,
          labels = c("Rec Center"),
          palette = c("#ffffb3"),
          popup.vars = c("Group", "Location"))
