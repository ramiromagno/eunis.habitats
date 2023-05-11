has_row <- function(df, row) {
  utils::tail(duplicated(rbind(df, row)), 1) > 0
}
