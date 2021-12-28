library(xlsx)
library(zip)
library(dplyr)
setwd("C:\\Users\\danie\\Downloads")

url<-"https://www.westlotto.com/wlinfo/WL_InfoService?gruppe=ErgebnisDownload&client=nlth&jahr_von=2019&jahr_bis=2022&spielart=EJ&format=excel"
destination<-"EJ_ab_2019.xls.zip"

download.file(url, destination, mode="wb")

unzip("EJ_ab_2019.xls.zip")

Ziehungen2019<-read.xlsx("EJ_ab_2019.xls",1)
Ziehungen2020<-read.xlsx("EJ_ab_2019.xls",2)
Ziehungen2021<-read.xlsx("EJ_ab_2019.xls",3)

Ziehungen <- rbind(Ziehungen2019, Ziehungen2020, Ziehungen2021)

Ziehungen<-unique(Ziehungen)

names(Ziehungen)<-c("Datum", "Z1", "Z2", "Z3", "Z4", "Z5", "EZ1", "EZ2",
                    "Spieleinsatz", "AnzKl1", "QuoteKl1", "AnzKl2", "QuoteKl2"
                    , "AnzKl3", "QuoteKl3", "AnzKl4", "QuoteKl4", "AnzKl5", "QuoteKl5"
                    , "AnzKl6", "QuoteKl6", "AnzKl7", "QuoteKl7", "AnzKl8", "QuoteKl8"
                    , "AnzKl9", "QuoteKl9", "AnzKl10", "QuoteKl10", "AnzKl11", "QuoteKl11"
                    , "AnzKl12", "QuoteKl12")


Ziehungen<-Ziehungen[!(Ziehungen$Datum=="Spieleinsätze und Quoten in EUR" | Ziehungen$Datum=="Alle Angaben ohne Gewähr"),]

rownames(Ziehungen) <- NULL

Ziehungen<-data.frame(cbind(Ziehungen$Datum, Ziehungen$Z1, Ziehungen$Z2, Ziehungen$Z3, Ziehungen$Z4, Ziehungen$Z5, Ziehungen$EZ1, Ziehungen$EZ2, Ziehungen$QuoteKl1,
            Ziehungen$QuoteKl2, Ziehungen$QuoteKl3, Ziehungen$QuoteKl4, Ziehungen$QuoteKl5, Ziehungen$QuoteKl6, Ziehungen$QuoteKl7, Ziehungen$QuoteKl8, 
            Ziehungen$QuoteKl9, Ziehungen$QuoteKl10, Ziehungen$QuoteKl11, Ziehungen$QuoteKl12))

names(Ziehungen)<-c("Datum","z1","z2","z3","z4","z5","EZ1","EZ2","QuoteKl1","QuoteKl2","QuoteKl3","QuoteKl4","QuoteKl5","QuoteKl6","QuoteKl7","QuoteKl8","QuoteKl9","QuoteKl10","QuoteKl11","QuoteKl12")



Schein_1<- list(c(8,15,24,35,44), c(1,6))
Schein_2<-list(c(4,8,16,18,21), c(4,8))
Schein_3<-list(c(13,23,27,43,49), c(3,7))
Schein_4<-list(c(3,6,25,39,46), c(2,5))
Schein_5<-list(c(2,4,5,16,28), c(4,7))
Schein_6<-list(c(5,33,34,39,48), c(3,7))
Schein_7<-list(c(2,12,38,39,48), c(1,5))
Schein_8<-list(c(7,14,35,38,47), c(3,7))
Schein_9<-list(c(16,23,26,34,36), c(2,5))
Schein_10<-list(c(4,7,9,26,48), c(7,8))
Schein_11<-list(c(2,33,37,38,40), c(3,5))
Schein_12<-list(c(1,16,22,26,42), c(5,6))
Schein_13<-list(c(2,9,15,21,45), c(2,6))

Schein<-list(Schein_1, Schein_2, Schein_3, Schein_4, Schein_5, Schein_6, Schein_7, Schein_8, Schein_9, Schein_10, Schein_11, Schein_12, Schein_13)


Kl<-data.frame()

Kl[1,1]<-"5 2"
Kl[2,1]<-"5 1"
Kl[3,1]<-"5 0"
Kl[4,1]<-"4 2"
Kl[5,1]<-"4 1"
Kl[6,1]<-"4 0"
Kl[7,1]<-"3 2"
Kl[8,1]<-"2 2"
Kl[9,1]<-"3 1"
Kl[10,1]<-"3 0"
Kl[11,1]<-"1 2"
Kl[12,1]<-"2 1"


Kl[,2]<-1:12

names(Kl)<-c("Klasse", "Rang")


n<-dim(Ziehungen)[1]


for(i in 1:n){
  
    Ziehungsdatum = Ziehungen[i,1]
    
    temp<-Ziehungen[Ziehungen$Datum==Ziehungsdatum,c(2:8)]
    GZ = temp[1:5]
    EZ = temp[6:7]
    
    Ergebnis<-data.frame()
    
    for(k in 1:length(Schein)){
      a<-length(intersect(as.numeric(GZ), Schein[[k]][[1]]))
      b<-length(intersect(as.numeric(EZ), Schein[[k]][[2]]))
      Ergebnis[k,1]<-paste(a, b)
      }
    
    
    Ergebnis<-Ergebnis %>% count(V1)
    
    names(Ergebnis)<-c("Klasse", "Anzahl")
    

    
    Ergebnis2<- merge(Ergebnis, Kl,by="Klasse")
    
    if(dim(Ergebnis2)[1]>0){
    
    Gewinn=0
    
    for(j in 1:(dim(Ergebnis2)[1])){
      
      Gewinn<-Gewinn + (as.numeric(gsub(",", ".", Ziehungen[Ziehungen$Datum==Ziehungsdatum, Ergebnis2[j,3]+8]))*as.numeric(Ergebnis2[j,2]))
      
    }
    
    Ziehungen[i,21]<-Gewinn
    }
    
    if(dim(Ergebnis2)[1]==0){Gewinn=0}
    
}

names(Ziehungen)<-c("Datum","z1","z2","z3","z4","z5","EZ1","EZ2","QuoteKl1","QuoteKl2","QuoteKl3","QuoteKl4","QuoteKl5","QuoteKl6","QuoteKl7","QuoteKl8","QuoteKl9","QuoteKl10","QuoteKl11","QuoteKl12", "Gewinn")

