OCR <- function(u,a){

  readxl::read_xlsx(u,sheet="Rate") %>%
    filter(Measurement==6,Group!='Background') %>%
    select(.,Well,OCR) %>% 
    anti_join(.,
              filter(a,remove) %>% 
                select(Well)
    ) 
}