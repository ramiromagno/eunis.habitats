#'
#'@export
eunis_cross_walk <-
  function(code,
           from = "EUNIS_2012",
           to = "EUNIS_M_2022",
           unnest = FALSE) {

    # Classifications
    cs <-
      c('EUNIS_2012',
        'EUNIS_M_2019',
        'EUNIS_M_2022',
        'EUNIS_T_2021')

    from <- match.arg(from, choices = cs)
    to <- match.arg(to, choices = cs)

    mapping <- NULL

    if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_M_2019"))
      mapping <- eunis_2012_to_eunis_m_2019

    if (identical(from, "EUNIS_M_2019") && identical(to, "EUNIS_2012"))
      mapping <- eunis_m_2019_to_eunis_2012

    if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_M_2022"))
      mapping <- eunis_2012_to_eunis_m_2022

    if (identical(from, "EUNIS_M_2022") && identical(to, "EUNIS_2012"))
      mapping <- eunis_m_2022_to_eunis_2012

    if (identical(from, "EUNIS_2012") && identical(to, "EUNIS_T_2021"))
      mapping <- eunis_2012_to_eunis_t_2021

    if (identical(from, "EUNIS_T_2021") && identical(to, "EUNIS_2012"))
      mapping <- eunis_t_2021_to_eunis_2012

    if (is.null(mapping))
      stop("The crosswalk from ", from, " to ", to, " is not available.")

    crosswalk <-
      if (missing(code)) {
        mapping
      } else {
        code_df <- data.frame(code)
        colnames(code_df) <- colnames(mapping)[1]
        merge(x = code_df,
              y = mapping,
              by = 1L,
              all.x = TRUE)
      }

  if (unnest) {
    crosswalk <- as.list(crosswalk)
    crosswalk[[1]] <- rep(crosswalk[[1]], lengths(crosswalk[[2]]))
    crosswalk[[2]] <- unlist(crosswalk[[2]])
    crosswalk <- tibble::as_tibble(crosswalk)
  }

    crosswalk
}
