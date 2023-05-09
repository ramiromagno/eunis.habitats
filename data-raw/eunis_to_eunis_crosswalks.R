# Do not run this script directly!
# Run make.R instead that sources this one.

# Depends on the following variables generated in data-raw/eunis_habitat.R that
# need to be loaded in the global environment for this script to run:
# - eunis_m_2019
# - eunis_m_2022
# - eunis_t_2021

#
# EUNIS to EUNIS crosswalks
#
library(eunis.habitats)
library(tidyverse)

# EUNIS Marine 2019 to EUNIS 2012 and back
eunis_m_2019_to_eunis_2012 <-
  eunis_m_2019 |>
  dplyr::select("code", "EUNIS 2012 code") |>
  dplyr::rename(eunis_m_2019_code = code,
                eunis_2012_code = `EUNIS 2012 code`) |>
  dplyr::mutate(eunis_2012_code = gsub("\\s+", "", eunis_2012_code)) |>
  dplyr::mutate(eunis_2012_code = strsplit2(eunis_2012_code, ";")) |>
  tidyr::drop_na(1L)

eunis_2012_to_eunis_m_2019 <-
  eunis_m_2019_to_eunis_2012 |>
  tidyr::unnest("eunis_2012_code") |>
  dplyr::group_by(eunis_2012_code) |>
  dplyr::summarise(eunis_m_2019_code = list(eunis_m_2019_code)) |>
  tidyr::drop_na(1L)

# EUNIS Marine 2022 to EUNIS 2012 and back
eunis_m_2022_to_eunis_2012 <-
  eunis_m_2022 |>
  dplyr::select("code", "EUNIS 2012 code") |>
  dplyr::rename(eunis_m_2022_code = code,
                eunis_2012_code = `EUNIS 2012 code`) |>
  dplyr::mutate(eunis_2012_code = gsub("\\s+", "", eunis_2012_code)) |>
  dplyr::mutate(eunis_2012_code = strsplit2(eunis_2012_code, ";")) |>
  tidyr::drop_na(1L)

eunis_2012_to_eunis_m_2022 <-
  eunis_m_2022_to_eunis_2012 |>
  tidyr::unnest("eunis_2012_code") |>
  dplyr::group_by(eunis_2012_code) |>
  dplyr::summarise(eunis_m_2022_code = list(eunis_m_2022_code)) |>
  tidyr::drop_na(1L)

# EUNIS Terrestrial 2021 to EUNIS 2012 and back
eunis_t_2021_to_eunis_2012 <-
  eunis_t_2021 |>
  dplyr::select("code", "EUNIS 2012 code") |>
  dplyr::rename(eunis_t_2021_code = code,
                eunis_2012_code = `EUNIS 2012 code`) |>
  dplyr::mutate(eunis_2012_code = gsub("\\s+", "", eunis_2012_code)) |>
  dplyr::mutate(eunis_2012_code = strsplit2(eunis_2012_code, ";")) |>
  tidyr::drop_na(1L)

eunis_2012_to_eunis_t_2021 <-
  eunis_t_2021_to_eunis_2012 |>
  tidyr::unnest("eunis_2012_code") |>
  dplyr::group_by(eunis_2012_code) |>
  dplyr::summarise(eunis_t_2021_code = list(eunis_t_2021_code)) |>
  tidyr::drop_na(1L)


