#' Convert habitat codes
#'
#' @description
#'
#' Convert (crosswalk) habitat codes from, and to, the following habitat
#' classification systems:
#'
#' - EUNIS habitat classification: `"EUNIS_2012"`, `"EUNIS_M_2019"`, `"EUNIS_M_2022"` and `"EUNIS_T_2021"`. See [eunis_habitats] for these habitat codes, names and descriptions.
#' - European Red List of Habitats: `"RL"`.
#' - Habitats Directive Annex I: `"Annex_I"`.
#'
#' Note that not all pairwise combinations are available. The possibilities are
#' those originally provided in EUNIS raw data.
#'
#' @param code A character vector of habitat codes. These values should be existing codes in the classification system indicated in the `from` parameter.
#' @param from The source classification system. Should be one of:
#'   `"EUNIS_2012"`, `"EUNIS_M_2019"`, `"EUNIS_M_2022"`, `"EUNIS_T_2021"`,
#'   `"RL"` or `"Annex_I"`.
#' @param to The target classification system. Also, one of the options
#'   indicated in `from` parameter description.
#' @param unnest Whether to unnest the "to" column in the output. Note that if
#'   you do unnest then the number of rows in the output will be (potentially)
#'   greater than the number of habitat codes provided in the parameter `code`,
#'   meaning that the one-to-many crosswalks will be on one row each.
#'
#' @return A [tibble][tibble::tibble-package] of two variables with the from and
#'   to codes, respectively. The actual column names will vary according to the
#'   specific crosswalk queried, see Examples.
#'
#' @examples
#' # From EUNIS 2012 to EUNIS Marine 2022
#' crosswalk(
#'   code = c("A3.4", "A3.5"),
#'   from = "EUNIS_2012",
#'   to = "EUNIS_M_2022",
#'   unnest = TRUE
#' )
#'
#' # From EUNIS Marine 2019 to EUNIS 2012
#' crosswalk(
#' code = c("MH152", "MH2331"),
#' from = "EUNIS_M_2019",
#' to = "EUNIS_2012",
#' unnest = TRUE
#' )
#'
#' # From EUNIS Marine 2022 to Red List
#' crosswalk(
#' code = c("MH152", "MH2331", "MA146", "MD55"),
#' from = "EUNIS_M_2022",
#' to = "RL",
#' unnest = TRUE
#' )
#'
#' # From EUNIS Marine 2019 to Annex I
#' crosswalk(
#' code = c("M", "MA1", "MA11", "MA12"),
#' from = "EUNIS_M_2019",
#' to = "Annex_I", unnest = TRUE
#' )
#'
#' # From Annex I to EUNIS Marine 2019
#' crosswalk(
#' code = c("8330", "1160"),
#' from = "Annex_I",
#' to = "EUNIS_M_2019", unnest = TRUE
#' )
#'
#' # From EUNIS Terrestrial 2021 to Annex I
#' crosswalk(
#' code = c("U51", "U72", "Q25"),
#' from = "EUNIS_T_2021",
#' to = "Annex_I", unnest = TRUE
#' )
#'
#' # From Annex I to EUNIS Terrestrial 2021
#' crosswalk(
#'   code = c("91E0", "92A0", "9030"),
#'   from = "Annex_I",
#'   to = "EUNIS_T_2021", unnest = TRUE
#'   )
#'
#' @export
crosswalk <-
  function(code,
           from,
           to,
           unnest = FALSE) {

    # available crosswalks
    query = tibble::tibble(from = from, to = to)

  if (!has_row(crosswalks_tbl[c("from", "to")], query))
    stop("The crosswalk from ", from, " to ", to, " is not available.")

  crosswalk_cond <- crosswalks_tbl$from == from & crosswalks_tbl$to == to
  crosswalk <- crosswalks_tbl[crosswalk_cond, "crosswalk", drop = TRUE][[1]]

  conversions <-
    if (missing(code)) {
      crosswalk
    } else {
      code_df <- data.frame(code)
      colnames(code_df) <- colnames(crosswalk)[1]
      tbl <- tibble::as_tibble(merge(
        x = code_df,
        y = crosswalk,
        by = 1L,
        all.x = TRUE
      ))
      # Ensure the same order as provided in `code`
      tbl[order(code), ]
    }

  if (unnest) {
    conversions <- as.list(conversions)
    conversions[[1]] <- rep(conversions[[1]], lengths(conversions[[2]]))
    conversions[[2]] <- unlist(conversions[[2]])
    conversions <- tibble::as_tibble(conversions)
    # If no matches were found, the second column might be of logical NAs
    # this ensures it will be character_NA_
    conversions[[2]] <- as.character(conversions[[2]])
  }

  conversions
  }


# eunis_to_eunis <-
#   function(code,
#            from = "EUNIS_2012",
#            to = "EUNIS_M_2022",
#            unnest = FALSE) {
#
#     # Classifications
#     cs <-
#       c('EUNIS_2012',
#         'EUNIS_M_2019',
#         'EUNIS_M_2022',
#         'EUNIS_T_2021')
#
#     from <- match.arg(from, choices = cs)
#     to <- match.arg(to, choices = cs)
#
#     mapping <- NULL
#
#     if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_M_2019"))
#       mapping <- eunis_2012_to_eunis_m_2019
#
#     if (identical(from, "EUNIS_M_2019") && identical(to, "EUNIS_2012"))
#       mapping <- eunis_m_2019_to_eunis_2012
#
#     if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_M_2022"))
#       mapping <- eunis_2012_to_eunis_m_2022
#
#     if (identical(from, "EUNIS_M_2022") && identical(to, "EUNIS_2012"))
#       mapping <- eunis_m_2022_to_eunis_2012
#
#     if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_T_2021"))
#       mapping <- eunis_2012_to_eunis_t_2021
#
#     if (identical(from, "EUNIS_T_2021") && identical(to, "EUNIS_2012"))
#       mapping <- eunis_t_2021_to_eunis_2012
#
#     if (is.null(mapping))
#       stop("The crosswalk from ", from, " to ", to, " is not available.")
#
#     crosswalk <-
#       if (missing(code)) {
#         mapping
#       } else {
#         code_df <- data.frame(code)
#         colnames(code_df) <- colnames(mapping)[1]
#         merge(x = code_df,
#               y = mapping,
#               by = 1L,
#               all.x = TRUE)
#       }
#
#   if (unnest) {
#     crosswalk <- as.list(crosswalk)
#     crosswalk[[1]] <- rep(crosswalk[[1]], lengths(crosswalk[[2]]))
#     crosswalk[[2]] <- unlist(crosswalk[[2]])
#     crosswalk <- tibble::as_tibble(crosswalk)
#   }
#
#     crosswalk
# }
#
#
# eunis_to_rl <- function(code,
#                               from = "EUNIS_M_2022",
#                               to = "RL",
#                               unnest = FALSE) {
#
#   # Classifications
#   cs <-
#     c('EUNIS_M_2019',
#       'EUNIS_M_2022',
#       'EUNIS_T_2021',
#       'RL')
#
#   from <- match.arg(from, choices = cs)
#   to <- match.arg(to, choices = cs)
#
#   mapping <- NULL
#
#   if (identical(from, "RL") && identical(to, "EUNIS_M_2019"))
#     mapping <- rl_to_eunis_m_2019
#
#   if (identical(from, "EUNIS_M_2019") && identical(to, "RL"))
#     mapping <- eunis_m_2019_to_rl
#
#   if (identical(from, "RL") && identical(to, "EUNIS_M_2022"))
#     mapping <- rl_to_eunis_m_2022
#
#   if (identical(from, "EUNIS_M_2022") && identical(to, "RL"))
#     mapping <- eunis_m_2019_to_rl
#
#   if (identical(from, "RL") && identical(to, "EUNIS_T_2021"))
#     mapping <- rl_to_eunis_t_2021
#
#   if (identical(from, "EUNIS_T_2021") && identical(to, "RL"))
#     mapping <- eunis_t_2021_to_rl
#
#   if (is.null(mapping))
#     stop("The crosswalk from ", from, " to ", to, " is not available.")
#
#   crosswalk <-
#     if (missing(code)) {
#       mapping
#     } else {
#       code_df <- data.frame(code)
#       colnames(code_df) <- colnames(mapping)[1]
#       merge(x = code_df,
#             y = mapping,
#             by = 1L,
#             all.x = TRUE)
#     }
#
#   if (unnest) {
#     crosswalk <- as.list(crosswalk)
#     crosswalk[[1]] <- rep(crosswalk[[1]], lengths(crosswalk[[2]]))
#     crosswalk[[2]] <- unlist(crosswalk[[2]])
#     crosswalk <- tibble::as_tibble(crosswalk)
#   }
#
#   crosswalk
#
# }
#
# eunis_to_annex_i <- function(code,
#                               from = "EUNIS_M_2022",
#                               to = "Annex_I",
#                               unnest = FALSE) {
#
#   # Classifications
#   cs <-
#     c('EUNIS_M_2019',
#       'EUNIS_M_2022',
#       'EUNIS_T_2021',
#       'Annex_I')
#
#   from <- match.arg(from, choices = cs)
#   to <- match.arg(to, choices = cs)
#
#   mapping <- NULL
#
#   if (identical(from, "Annex_I") && identical(to, "EUNIS_M_2019"))
#     mapping <- rl_to_eunis_m_2019
#
#   if (identical(from, "EUNIS_M_2019") && identical(to, "Annex_I"))
#     mapping <- eunis_m_2019_to_rl
#
#   if (identical(from, "Annex_I") && identical(to, "EUNIS_M_2022"))
#     mapping <- rl_to_eunis_m_2022
#
#   if (identical(from, "EUNIS_M_2022") && identical(to, "Annex_I"))
#     mapping <- eunis_m_2019_to_rl
#
#   if (identical(from, "Annex_I") && identical(to, "EUNIS_T_2021"))
#     mapping <- rl_to_eunis_t_2021
#
#   if (identical(from, "EUNIS_T_2021") && identical(to, "Annex_I"))
#     mapping <- eunis_t_2021_to_rl
#
#   if (is.null(mapping))
#     stop("The crosswalk from ", from, " to ", to, " is not available.")
#
#   crosswalk <-
#     if (missing(code)) {
#       mapping
#     } else {
#       code_df <- data.frame(code)
#       colnames(code_df) <- colnames(mapping)[1]
#       merge(x = code_df,
#             y = mapping,
#             by = 1L,
#             all.x = TRUE)
#     }
#
#   if (unnest) {
#     crosswalk <- as.list(crosswalk)
#     crosswalk[[1]] <- rep(crosswalk[[1]], lengths(crosswalk[[2]]))
#     crosswalk[[2]] <- unlist(crosswalk[[2]])
#     crosswalk <- tibble::as_tibble(crosswalk)
#   }
#
#   crosswalk
#
# }
