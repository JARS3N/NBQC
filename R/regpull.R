regpull <- function(txt, regx,case=T) {
  unlist(regmatches(txt,
                    gregexpr(
                      pattern = regx,
                      txt,
                      ignore.case = case
                    )))
}