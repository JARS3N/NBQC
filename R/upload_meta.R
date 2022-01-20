upload_meta <- function(u, con) {
  RMySQL::dbWriteTable(
    conn = con,
    name = "nb_meta",
    value = as.data.frame(u),
    append = T,
    row.names = F
  )
}