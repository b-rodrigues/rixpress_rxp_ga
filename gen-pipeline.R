library(rixpress)
library(igraph)

list(
  rxp_r_file(
    name = mtcars,
    path = 'data/mtcars.csv',
    read_function = \(x) (read.csv(file = x, sep = "|"))
  ),

  rxp_r(
    name = filtered_sleep_mtcars,
    expr = my_filter(mtcars),
    additional_files = "functions.R"
  ),

  rxp_r(
    name = mtcars_mpg,
    expr = dplyr::select(filtered_sleep_mtcars, mpg)
  )
) |>
  rixpress(project_path = ".", build = FALSE)

# Plot DAG for CI
dag_for_ci()
