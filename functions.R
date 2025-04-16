my_filter <- function(data) {
  Sys.sleep(600)
  dplyr::filter(data, am == 1)
}
