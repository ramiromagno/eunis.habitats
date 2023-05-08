library(tidyverse)
library(readxl)

strsplit2 <- function(x, split, fixed = FALSE, perl = FALSE, useBytes = FALSE) {
  x_split <- strsplit(x = x, split = split, fixed = fixed, perl = perl, useBytes = useBytes)
  if(all(sapply(x_split, length) < 2)) x_split <- unlist(x_split)
  x_split
}

path <- here::here("data-raw/")

#
# `eunis_2012`
#
eunis_2012_file <- "EUNIS habitat classification 2007 - Revised descriptions 2012 amended 2019.xls"
eunis_2012_path <- file.path(path, "EUNIS habitat classification 2007 - Revised descriptions 2012 amended 2019.xls")
eunis_2012_raw <-
  readxl::read_xls(eunis_2012_path,
                   sheet = "descriptions",
                   range = readxl::cell_cols("A:G")) |>
  dplyr::rename(
    level = `Habitat level`,
    code = `EUNIS habitat code`,
    name = `EUNIS habitat name`,
    description = `NEW Description`,
    author = Author,
    date = Date,
    title = Title
  ) |>
  dplyr::mutate(level = as.integer(level)) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws))

eunis_2012 <- eunis_2012_raw


#
# `eunis_m_2019`
#
eunis_m_2019_file <- "EUNIS marine habitat classification 2019 including crosswalks.xlsx"
eunis_m_2019_path <- file.path(path, eunis_m_2019_file)
eunis_m_2019_raw <-
  dplyr::bind_rows(
    readxl::read_xlsx(eunis_m_2019_path, sheet = "Benthic habitats"),
    readxl::read_xlsx(eunis_m_2019_path, sheet = "Pelagic habitats"),
    readxl::read_xlsx(eunis_m_2019_path, sheet = "Ice associated"),
    .id = "group"
  )

eunis_m_2019_01 <-
  eunis_m_2019_raw |>
  dplyr::mutate(
    group = dplyr::case_when(
      group == "1" ~ "benthic",
      group == "2" ~ "pelagic",
      group == "3" ~ "ice"
    )
  )

eunis_m_2019_02 <-
  eunis_m_2019_01 |>
  dplyr::rename(
    level = Level,
    code = Code,
    name = Name,
    description = Description,
  ) |>
  dplyr::mutate(level = as.integer(level)) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws))

eunis_m_2019 <- eunis_m_2019_02


#
# `eunis_m_2022`
#
eunis_m_2022_file <- "EUNIS marine habitat classification 2022 including crosswalks.xlsx"
eunis_m_2022_path <- file.path(path, eunis_m_2022_file)
eunis_m_2022_raw <-
  dplyr::bind_rows(
    readxl::read_xlsx(eunis_m_2022_path, sheet = "Benthic habitats"),
    readxl::read_xlsx(eunis_m_2022_path, sheet = "Pelagic habitats"),
    readxl::read_xlsx(eunis_m_2022_path, sheet = "Ice associated"),
    .id = "group"
  ) |>
  dplyr::rename(Notes = `...23`)

eunis_m_2022_01 <-
  eunis_m_2022_raw |>
  dplyr::mutate(
    group = dplyr::case_when(
      group == "1" ~ "benthic",
      group == "2" ~ "pelagic",
      group == "3" ~ "ice"
    )
  )

eunis_m_2022_02 <-
  eunis_m_2022_01 |>
  dplyr::rename(
    level = Level,
    code = Code,
    name = Name,
    description = Description,
  ) |>
  dplyr::mutate(level = as.integer(level)) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws))

# Fix a mistake in the file "EUNIS marine habitat classification 2022 including crosswalks.xlsx"
# where in row 199, the columns F thru K seem to be shuffled. Here I make the obvious fixes.
eunis_m_2022_03 <-
  eunis_m_2022_02 |>
  dplyr::mutate(
    `EUNIS 2012 code` = if_else(code == "MA223T", "A2.531J", `EUNIS 2012 code`),
    `Source classification system code` = if_else(code == "MA223T", "A2.531J", `Source classification system code`),
    `Source classification system habitat name` = if_else(
      code == "MA223T",
      "Fenno-Scandian Calamagrostis stricta-sedge swards",
      `Source classification system habitat name`
    ),
    `Source classification system name` = if_else(
      code == "MA223T",
      "EUNIS Habitat Classification Version 2004",
      `Source classification system name`
    ),
    `Source classification citation` = if_else(code == "MA223T", "EUNIS 2004", `Source classification citation`),
    `EUNIS 2012 relation` = if_else(code == "MA223T", "=", `EUNIS 2012 relation`)
  )

eunis_m_2022 <- eunis_m_2022_03


#
# `eunis_t_2021`
#
eunis_t_2021_file <- "EUNIS terrestrial habitat classification 2021_1 including crosswalks.xlsx"
eunis_t_2021_path <- file.path(path, eunis_t_2021_file)
terrestrial_habitat_groups <- c("Coastal", "Grassland", "Heathland", "Forest", "Sparsely vegetated", "Man-made", "Wetlands")
eunis_t_2021_raw <-
  purrr::map(
    terrestrial_habitat_groups,
    ~ readxl::read_xlsx(path = eunis_t_2021_path, sheet = .x)
  ) |>
  purrr::list_rbind(names_to = "group")


eunis_t_2021_01 <-
  eunis_t_2021_raw |>
  dplyr::mutate(group = tolower(terrestrial_habitat_groups[group]))

eunis_t_2021_02 <-
  eunis_t_2021_01 |>
  dplyr::rename(
    level = Level,
    code = Code,
    name = Name,
    description = Description,
  ) |>
  dplyr::mutate(level = as.integer(level)) |>
  dplyr::mutate(dplyr::across(dplyr::where(is.character), trimws))

eunis_t_2021 <- eunis_t_2021_02


eunis_habitats <-
  dplyr::bind_rows(
    tibble::add_column(
      eunis_2012,
      classification = "EUNIS_2012",
      section = NA_character_,
      version = "2012",
      .before = 1L
    ),
    tibble::add_column(
      eunis_m_2019,
      classification = "EUNIS_M_2019",
      section = "marine",
      version = "2019",
      .before = 1L
    ),
    tibble::add_column(
      eunis_m_2022,
      classification = "EUNIS_M_2022",
      section = "marine",
      version = "2022",
      .before = 1L
    ),
    tibble::add_column(
      eunis_t_2021,
      classification = "EUNIS_T_2021",
      section = "terrestrial",
      version = "2021_1",
      .before = 1L
    )
  ) |>
  dplyr::select("classification", "section", "version", "group", "level", "code", "name", "description")

#
# Crosswalks
#

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

eunis_2012_to_eunis_t_2022 <-
  eunis_t_2021_to_eunis_2012 |>
  tidyr::unnest("eunis_2012_code") |>
  dplyr::group_by(eunis_2012_code) |>
  dplyr::summarise(eunis_t_2021_code = list(eunis_t_2021_code)) |>
  tidyr::drop_na(1L)

#
# Exported data sets: eunis_habitats
#
usethis::use_data(eunis_habitats, overwrite = TRUE)

# Internal data sets (crosswalks)
usethis::use_data(
  eunis_m_2019_to_eunis_2012,
  eunis_2012_to_eunis_m_2019,
  eunis_m_2022_to_eunis_2012,
  eunis_2012_to_eunis_m_2022,
  eunis_t_2021_to_eunis_2012,
  eunis_2012_to_eunis_t_2022,
  internal = TRUE,
  overwrite = TRUE
  )
