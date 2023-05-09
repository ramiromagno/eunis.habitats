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
source(file.path(path, "eunis_to_annex_i_crosswalks.R"))

# Exported data set `eunis_habitats`
usethis::use_data(eunis_habitats, overwrite = TRUE)

crosswalks_tbl <-
  tibble::tribble(
    ~ from, ~ to, ~ crosswalk,
    "EUNIS_2012",  "EUNIS_M_2019", eunis_2012_to_eunis_m_2019,
    "EUNIS_M_2019","EUNIS_2012",  eunis_m_2019_to_eunis_2012,
    "EUNIS_2012",  "EUNIS_M_2022", eunis_2012_to_eunis_m_2022,
    "EUNIS_M_2022","EUNIS_2012",  eunis_m_2022_to_eunis_2012,
    "EUNIS_2012",  "EUNIS_T_2021", eunis_2012_to_eunis_t_2021,
    "EUNIS_T_2021","EUNIS_2012",  eunis_t_2021_to_eunis_2012,

    "RL", "EUNIS_M_2019", rl_to_eunis_m_2019,
    "EUNIS_M_2019", "RL", eunis_m_2019_to_rl,
    "RL", "EUNIS_M_2022",rl_to_eunis_m_2022,
    "EUNIS_M_2022", "RL",eunis_m_2022_to_rl,
    "RL", "EUNIS_T_2021", rl_to_eunis_t_2021,
    "EUNIS_T_2021", "RL",eunis_t_2021_to_rl,

    "Annex_I", "EUNIS_M_2019", annex_i_to_eunis_m_2019,
    "EUNIS_M_2019", "Annex_I", eunis_m_2019_to_annex_i,
    "Annex_I", "EUNIS_M_2022", annex_i_to_eunis_m_2022,
    "EUNIS_M_2022", "Annex_I", eunis_m_2022_to_annex_i,
    "Annex_I", "EUNIS_T_2021", annex_i_to_eunis_t_2021,
    "EUNIS_T_2021", "Annex_I", eunis_t_2021_to_annex_i
  )

# Save internal data sets (crosswalks).
# These data sets are meant to be used by the
# function `crosswalk()`.
usethis::use_data(
  crosswalks_tbl,
  internal = TRUE,
  overwrite = TRUE
)


