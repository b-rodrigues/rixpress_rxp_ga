my_filter <- function(data) {
  Sys.sleep(60)
  dplyr::filter(data, am == 1)
}
