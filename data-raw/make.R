#
# One script to rule them all!
#
# This script sources the following scripts (in this order):
#
#   1. data-raw/eunis_habitats.R
#   2. data-raw/eunis_to_eunis_crosswalks.R
#   3. data-raw/eunis_to_red_list_crosswalks.R
#   4. data-raw/eunis_to_annex_i_crosswalks.R
#

library(eunis.habitats)
library(tidyverse)
library(readxl)

path <- here::here("data-raw")
source(file.path(path, "eunis_habitats.R"))
source(file.path(path, "eunis_to_eunis_crosswalks.R"))
source(file.path(path, "eunis_to_red_list_crosswalks.R"))

# Exported data set `eunis_habitats`
usethis::use_data(eunis_habitats, overwrite = TRUE)

# Save internal data sets (crosswalks).
# These data sets are meant to be used by the
# function `crosswalk()`.
usethis::use_data(
  eunis_m_2019_to_eunis_2012, # From eunis_to_eunis_crosswalks.R
  eunis_2012_to_eunis_m_2019, # Idem.
  eunis_m_2022_to_eunis_2012, # Idem.
  eunis_2012_to_eunis_m_2022, # Idem.
  eunis_t_2021_to_eunis_2012, # Idem.
  eunis_2012_to_eunis_t_2021, # Idem.
  eunis_m_2019_to_rl, # From eunis_to_red_list_crosswalks.R
  rl_to_eunis_m_2019, # Idem.
  eunis_m_2022_to_rl, # Idem.
  rl_to_eunis_m_2022, # Idem.
  eunis_t_2021_to_rl, # Idem.
  rl_to_eunis_t_2021, # Idem.
  internal = TRUE,
  overwrite = TRUE
)


