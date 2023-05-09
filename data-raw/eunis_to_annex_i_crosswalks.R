# Do not run this script directly!
# Run make.R instead that sources this one.

#
# EUNIS to Annex I crosswalks
#

library(eunis.habitats)
library(tidyverse)
library(readxl)
path <- here::here("data-raw/")

#
# EUNIS Marine 2019 to Annex I
#
eunis_m_2019_to_annex_i_file <- "EUNIS marine habitat classification 2019 with crosswalks to Annex I in separate rows.xlsx"
eunis_m_2019_to_annex_i_path <- file.path(path, eunis_m_2019_to_annex_i_file)
eunis_m_2019_to_annex_i_raw <-
  readxl::read_xlsx(eunis_m_2019_to_annex_i_path,
                    sheet = "Benthic habitats") |>
  dplyr::select(`Code 2019`, `Annex I code`) |>
  dplyr::rename(
    eunis_m_2019_code = `Code 2019`,
    annex_i_code = `Annex I code`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::mutate(annex_i_code = dplyr::na_if(annex_i_code, "x")) |>
  dplyr::group_by(eunis_m_2019_code) |>
  dplyr::summarise(annex_i_code = list(annex_i_code)) |>
  tidyr::drop_na(1L)

eunis_m_2019_to_annex_i <- eunis_m_2019_to_annex_i_raw

annex_i_to_eunis_m_2019 <-
  eunis_m_2019_to_annex_i |>
  tidyr::unnest("annex_i_code") |>
  dplyr::group_by(annex_i_code) |>
  dplyr::summarise(eunis_m_2019_code = list(eunis_m_2019_code)) |>
  tidyr::drop_na(1L)

#
# EUNIS Marine 2022 to Annex I
#
eunis_m_2022_to_annex_i_file <- "EUNIS marine habitat classification 2022 with crosswalks to Annex I in separate rows.xlsx"
eunis_m_2022_to_annex_i_path <- file.path(path, eunis_m_2022_to_annex_i_file)
eunis_m_2022_to_annex_i_raw <-
  readxl::read_xlsx(eunis_m_2022_to_annex_i_path,
                    sheet = "Benthic habitats") |>
  dplyr::select(`Code 2019`, `Annex I code`) |>
  dplyr::rename(
    eunis_m_2022_code = `Code 2019`,
    annex_i_code = `Annex I code`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::mutate(annex_i_code = dplyr::na_if(annex_i_code, "x")) |>
  dplyr::group_by(eunis_m_2022_code) |>
  dplyr::summarise(annex_i_code = list(annex_i_code)) |>
  tidyr::drop_na(1L)

eunis_m_2022_to_annex_i <- eunis_m_2022_to_annex_i_raw

annex_i_to_eunis_m_2022 <-
  eunis_m_2022_to_annex_i |>
  tidyr::unnest("annex_i_code") |>
  dplyr::group_by(annex_i_code) |>
  dplyr::summarise(eunis_m_2022_code = list(eunis_m_2022_code)) |>
  tidyr::drop_na(1L)

#
# EUNIS Terrestrial 2021 to Annex I
#
eunis_t_2021_to_annex_i_file <- "EUNIS terrestrial habitat classification 2021_1 with crosswalks to Annex I in separate rows.xlsx"
eunis_t_2021_to_annex_i_path <- file.path(path, eunis_t_2021_to_annex_i_file)
terrestrial_habitat_groups <- c("Coastal", "Grassland", "Heathland", "Forest", "Sparsely vegetated", "Man-made", "Wetlands")
terrestrial_habitat_groups2 <- c("Coastal", "Grasslands", "Heathland", "Forests", "Sparsely vegetated", "vegetated man-made", "Wetlands")
eunis_t_2021_to_annex_i_raw <-
  purrr::map(
    terrestrial_habitat_groups2,
    ~ readxl::read_xlsx(path = eunis_t_2021_to_annex_i_path, sheet = .x)
  ) |>
  purrr::list_rbind(names_to = "group")

eunis_t_2021_to_annex_i_01 <-
  eunis_t_2021_to_annex_i_raw |>
  # Yes, below is `terrestrial_habitat_groups` not `terrestrial_habitat_groups2`
  # for consistency with previous files. EUNIS' people do not seem to very
  # meticulous here...
  dplyr::mutate(group = tolower(terrestrial_habitat_groups[group]))

eunis_t_2021_to_annex_i_02 <-
  eunis_t_2021_to_annex_i_01 |>
  dplyr::select(`revised EUNIS Code`, `Annex I code`) |>
  dplyr::rename(
    eunis_t_2021_code = `revised EUNIS Code`,
    annex_i_code = `Annex I code`
  ) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws)) |>
  dplyr::mutate(annex_i_code = dplyr::na_if(annex_i_code, "x")) |>
  dplyr::group_by(eunis_t_2021_code) |>
  dplyr::summarise(annex_i_code = list(annex_i_code)) |>
  tidyr::drop_na(1L)

eunis_t_2021_to_annex_i <- eunis_t_2021_to_annex_i_02

annex_i_to_eunis_t_2021 <-
  eunis_t_2021_to_annex_i |>
  tidyr::unnest("annex_i_code") |>
  dplyr::group_by(annex_i_code) |>
  dplyr::summarise(eunis_t_2021_code = list(eunis_t_2021_code)) |>
  tidyr::drop_na(1L)
