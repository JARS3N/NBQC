pHtarget <-function(u){
  term<-"pH Target Emission"
  cal<-readxl::read_xlsx(u, sheet = "Calibration")
  cell<-which(cal==term,arr.ind = T) + c(0,1)
  as.numeric(cal[cell[1],cell[2]])
}