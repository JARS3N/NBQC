meta <- function(u){
  # strata & order are pulled from the file name by searching for (start,mid,end) followed by any sequence of digits
  # Lot is pulled from the file name looking for Lot-[any sequence of digits]
  tibble(
    file = basename(u)
  ) %>%  mutate(
    Lot = gsub("[A-Z,a-z,_,-]+","",regpull(u,"Lot-[0-9]+")),
    info = regpull(u,"(start|mid|end)[0-9]+"),
    strata = factor(tolower(gsub("[0-9]", "", info)),levels = c("start","mid","end")),
    ord = as.numeric(gsub("[A-Z,a-z]", "", info)),
    info = NULL
  ) 
}
