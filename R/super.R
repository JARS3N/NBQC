SUPER <- function(u){
  OL(u) %>% 
    left_join(.,OCR(u,.)) %>% 
    left_join(.,GAIN(u,pHtarget(u)))
}