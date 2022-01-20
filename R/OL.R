OL <- function(fl){
  readxl::read_xlsx(fl,sheet="Raw") %>% 
    filter(Measurement==3) %>% 
    filter(Tick==max(Tick)) %>% 
    select(Well,pH,O2=`O2 (mmHg)`) %>% 
    mutate(delta_O2 = abs(O2-151.69),
           delta_pH = abs(pH - 7.4),
           fail_O2 = delta_O2 > 20,
           fail_pH = delta_pH >.2,
           remove = (fail_O2+fail_pH)>0
    )
}