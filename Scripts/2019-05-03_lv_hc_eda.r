# EDA Script: Hancock & Lakeview Gross Income by ZIP

  # Date: 2019-05-03
  # R Version: 3.5.1
  # RStudio Version: 1.2.1335
  # OS: Windows 10
  # Repo: github.com/jamisoncrawford/wealth

# Install & Load Packages

if(!require("readr")){install.packages("readr")}
if(!require("dplyr")){install.packages("dplyr")}
if(!require("tigris")){install.packages("tigris")}
if(!require("scales")){install.packages("scales")}
if(!require("stringr")){install.packages("stringr")}
if(!require("ggplot2")){install.packages("ggplot2")}
if(!require("noncensus")){install.packages("noncensus")}
if(!require("kableExtra")){install.packages("kableExtra")}

library(readr)
library(dplyr)
library(tigris)
library(scales)
library(stringr)
library(ggplot2)
library(noncensus)
library(kableExtra)

# Set Working Directory & Read in Data

rm(list = ls())

setwd("~/Projects/Gross Income Forensics")

data(zip_codes)
data(counties)

url <- "https://raw.githubusercontent.com/jamisoncrawford/wealth/master/Tidy%20Data/hancock_lakeview_tidy.csv"
lvhc <- read_csv(file = url, 
                 col_types = "ccDcccddddccliii")

rm(url)

# Remove NA Values; Merge ZIP Codes with FIPS IDs; Dimension Reduction

counties <- counties %>%
  mutate(fips = paste0(state_fips, 
                       county_fips),                        # Paste FIPS IDs (State + County)
         fips = as.character(fips)) %>%
  select(county_name, fips) 

lvhc <- lvhc %>%
  filter(!is.na(zip),
         !is.na(gross),
         !is.na(project)) %>%                               # Remove NA values
  left_join(zip_codes, 
            by = "zip") %>%
  mutate(fips = as.character(fips)) %>%                     # Join FIPS IDs
  left_join(counties,
            by = "fips") %>%                                # Join counties by FIPS
  mutate(county = str_replace_all(string = county_name, 
                                  pattern = " County$", 
                                  replacement = "")) %>%    # Clean county names
  select(project:hours, gross, sex:race, city:state, 
         county, fips, longitude:latitude) %>%              # Select variables
  filter(!is.na(state))                                     # Remove 8 unidentified records
  
rm(zip_codes, counties)

# Separate, Store Lakeview & Hancock Objects

lv <- lvhc %>%
  filter(project == "Lakeview")

hc <- lvhc %>%
  filter(project == "Hancock")

# Summary Data: Hancock

hc_gross <- hc %>%
  group_by(county, state) %>%
  summarize(gross = sum(gross)) %>%       # Total gross by county
  ungroup() %>%
  arrange(desc(gross)) %>%
  mutate(perc_gross = gross / sum(gross)) # Percentage of total gross

hc_inds <- hc %>%
  group_by(name, zip, ssn, class, sex, race) %>%
  summarize(gross = sum(gross),
            county = unique(county),
            state = unique(state)) %>%    # Total gross by individual
  ungroup() %>%
  arrange(county, desc(gross))

hc_wrks <- hc_inds %>%
  group_by(county, state) %>%
  summarize(workers = n(),
            gross = sum(gross)) %>%
  ungroup() %>%
  arrange(desc(gross))                    # Total workers by county

hc_all <- hc_gross %>%
  left_join(hc_wrks,
            by = c("county", "state")) %>%
  select(-gross.y) %>%
  rename(gross = gross.x)                 # Merge workers and gross

hc_all <- hc_all %>%
  mutate(perc_workers = workers / sum(workers))

rm(hc_gross, hc_wrks)

# Visualization: Hancock

options(scipen = 999)                     # Disable scientific notation

ggplot(hc_all, 
       aes(x = reorder(county, gross), gross, 
           y = gross, 
           fill = state)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Total gross income by county, state",
       subtitle = "Hancock Airport Renovations",
       caption = "Source: Syracuse Regional Airport Authority",
       x = "County",
       y = "Total Gross (USD)",
       fill = "State") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

# Table

hc_all_tbl <- hc_all %>%
  mutate(gross = dollar(gross),
         perc_gross = percent(perc_gross),
         perc_workers = percent(perc_workers)) %>%
  rename(County = county,
         State = state,
         "Total Gross" = gross,
         "Gross (%)" = perc_gross,
         "Total Workers" = workers,
         "Workforce (%)" = perc_workers)

kable(hc_all_tbl) %>%
  kable_styling(bootstrap_options = c("striped", 
                                      "hover", 
                                      "responsive"),
                full_width = TRUE)
