library(xlsx)
library(zip)
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
