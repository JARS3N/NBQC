upload_data <- function(u, con) {
  RMySQL::dbWriteTable(
    conn = con,
    name = "nb_plate_data",
    value =
      as.data.frame(
        mutate(
          u,
          fail_O2 = as.numeric(fail_O2),
          fail_pH = as.numeric(fail_pH),
          remove = as.numeric (remove)
        )
      ),
    append = T,
    row.names = F
  )
}