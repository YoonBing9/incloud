
##########################Lyrics_MotionChart###########################

install.packages("googleVis")
library(googleVis)

a<-read.csv("C:/R_temp/lyricsTF.csv") 
a
M1<-gvisMotionChart(a,idvar="id", timevar="year", sizevar="comp")
plot(M1)
