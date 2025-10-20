################################################################################
# Assignment #2: Data Wrangling
################################################################################
#
# Austin Wells
# ajw272@miami.edu
# October 19, 2025
#
# Description
# Analysis of IATTC Dataset - Tuna and Billfish EPO longline catch and effort
# aggregated by year, month, flag (Country).
################################################################################

# Load Packages -----------------------------------------------------------

library(EVR628tools)
library(tidyverse)
library(janitor)

# Load Data ---------------------------------------------------------------

tuna_and_billfish <- read_csv("data/raw/PublicLLTunaBillfishMt.csv")|>
  rename(Country = Flag)

colnames(tuna_and_billfish)

# Building The Data for Use -----------------------------------------------
## Filter data to only represent fish of choice:
## (Albacore = ALB, Yellowfin = YFT, & Black Marlin = BLM)
## This analysis will include data from year 2000 and on.

target_tuna_and_billfish <- tuna_and_billfish |> 
  select(Year, Month, Country, ALBmt, YFTmt, BLMmt) |>
  filter(ALBmt > 0, YFTmt > 0, BLMmt > 0,
    Year >= 2000) |>
  group_by(Month, Country)

## Using Pivot Longer function so fish type (species) can be in 1 column.
target_fish_long <- target_tuna_and_billfish |>
  pivot_longer(cols = c(ALBmt, YFTmt, BLMmt),
  names_to = "Species",
  values_to = "Catch_mt")

## Reframing data to provide monthly Average Weight by species, country. month, and year.
avg_monthly_fish_wt <- target_fish_long |>
  group_by(Year, Month, Country, Species) |>
  summarise(avg_catch_mt = mean(Catch_mt, na.rm = TRUE))


