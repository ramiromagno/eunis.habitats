has_row <- function(df, row) {
  tail(duplicated(rbind(df, row)), 1) > 0
}
