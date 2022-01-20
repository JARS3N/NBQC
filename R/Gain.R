GAIN <- function(u, target) {
  tibble(Measurement = c(3, 6), M = c('pre', 'post')) %>%
    left_join(.,
              readxl::read_xlsx(u, sheet = "Raw")) %>%
    rename(counts = `pH Corrected Em.`) %>%
    group_by(Well,M) %>%
    filter(Tick==max(Tick)) %>% 
    select(Well,  counts , M) %>%
    group_by(Well) %>% 
    tidyr::spread(.,M,counts) %>% 
    mutate(
      delta = pre - post,
      gain = delta / 800,
      norm_gain = (target / pre) * gain
    )
}