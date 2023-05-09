# Do not run this script directly!
# Run make.R instead that sources this one.

#
# EUNIS to Red List crosswalks
#

library(eunis.habitats)
library(tidyverse)
library(readxl)
path <- here::here("data-raw/")

#
# EUNIS Marine 2019 to Red List (RL)
#
eunis_m_2019_to_rl_file <- "EUNIS marine habitat classification 2019 with crosswalks to Red List in separate rows.xlsx"
eunis_m_2019_to_rl_path <- file.path(path, eunis_m_2019_to_rl_file)
eunis_m_2019_to_rl_raw <-
  readxl::read_xlsx(eunis_m_2019_to_rl_path,
                    sheet = "EUNIS to RL") |>
  dplyr::select(Code, `Red List code`, `Red List code (for EEA publication)`) |>
  dplyr::rename(
    eunis_m_2019_code = Code,
    rl_code = `Red List code`,
    rl_eea_code = `Red List code (for EEA publication)`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::group_by(eunis_m_2019_code) |>
  dplyr::summarise(rl_code = list(rl_code), rl_eea_code = list(rl_eea_code)) |>
  tidyr::drop_na(1L)

eunis_m_2019_to_rl <- eunis_m_2019_to_rl_raw

rl_to_eunis_m_2019 <-
  eunis_m_2019_to_rl |>
  tidyr::unnest("rl_code") |>
  dplyr::group_by(rl_code) |>
  dplyr::summarise(eunis_m_2019_code = list(eunis_m_2019_code)) |>
  tidyr::drop_na(1L)

#
# EUNIS Marine 2022 to Red List (RL)
#
eunis_m_2022_to_rl_file <- "EUNIS marine habitat classification 2022 with crosswalks to Red List in separate rows.xlsx"
eunis_m_2022_to_rl_path <- file.path(path, eunis_m_2022_to_rl_file)
eunis_m_2022_to_rl_raw <-
  readxl::read_xlsx(eunis_m_2022_to_rl_path,
                    sheet = "EUNIS to RL") |>
  dplyr::select(Code, `Red List code`, `Red List code (for EEA publication)`) |>
  dplyr::rename(
    eunis_m_2022_code = Code,
    rl_code = `Red List code`,
    rl_eea_code = `Red List code (for EEA publication)`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::group_by(eunis_m_2022_code) |>
  dplyr::summarise(rl_code = list(rl_code), rl_eea_code = list(rl_eea_code)) |>
  tidyr::drop_na(1L)

eunis_m_2022_to_rl <- eunis_m_2022_to_rl_raw

rl_to_eunis_m_2022 <-
  eunis_m_2022_to_rl |>
  tidyr::unnest("rl_code") |>
  dplyr::group_by(rl_code) |>
  dplyr::summarise(eunis_m_2022_code = list(eunis_m_2022_code)) |>
  tidyr::drop_na(1L)

#
# EUNIS Terrestrial 2021 to Red List (RL)
#
eunis_t_2021_to_rl_file <- "EUNIS terrestrial habitat classification 2021_1 with crosswalks to Red List in separate rows.xlsx"
eunis_t_2021_to_rl_path <- file.path(path, eunis_t_2021_to_rl_file)
terrestrial_habitat_groups <- c("Coastal", "Grassland", "Heathland", "Forest", "Sparsely vegetated", "Man-made", "Wetlands")
terrestrial_habitat_groups2 <- c("Coastal", "Grasslands", "Heathland", "Forests", "Sparsely vegetated", "vegetated man-made", "Wetlands")
eunis_t_2021_to_rl_raw <-
  purrr::map(
    terrestrial_habitat_groups2,
    ~ readxl::read_xlsx(path = eunis_t_2021_to_rl_path, sheet = .x)
  ) |>
  purrr::list_rbind(names_to = "group")

eunis_t_2021_to_rl_01 <-
  eunis_t_2021_to_rl_raw |>
  # Yes, below is `terrestrial_habitat_groups` not `terrestrial_habitat_groups2`
  # for consistency with previous files. EUNIS' people do not seem to very
  # meticulous here...
  dplyr::mutate(group = tolower(terrestrial_habitat_groups[group]))

eunis_t_2021_to_rl_02 <-
  eunis_t_2021_to_rl_01 |>
  dplyr::select(`revised EUNIS Code`, `Red List code`) |>
  dplyr::rename(
    eunis_t_2021_code = `revised EUNIS Code`,
    rl_code = `Red List code`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::group_by(eunis_t_2021_code) |>
  dplyr::summarise(rl_code = list(rl_code)) |>
  tidyr::drop_na(1L)

eunis_t_2021_to_rl <- eunis_t_2021_to_rl_02

rl_to_eunis_t_2021 <-
  eunis_t_2021_to_rl |>
  tidyr::unnest("rl_code") |>
  dplyr::group_by(rl_code) |>
  dplyr::summarise(eunis_t_2021_code = list(eunis_t_2021_code)) |>
  tidyr::drop_na(1L)
