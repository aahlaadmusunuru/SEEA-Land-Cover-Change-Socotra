Year1993<-"D:\\socotra\\1993.tif"
Year1997<-"D:\\socotra\\1997.tif"
Year2001<-"D:\\socotra\\2001.tif"
Year2005<-"D:\\socotra\\2005.tif"
Year2009<-"D:\\socotra\\2009.tif"
Year2013<-"D:\\socotra\\2013.tif"

Year1993_R<-raster(Year1993)
Year1997_R<-raster(Year1997)
Year2001_R<-raster(Year2001)
Year2005_R<-raster(Year2005)
Year2009_R<-raster(Year2009)
Year2013_R<-raster(Year2013)





data1<-data.frame(Year1993=values(Year1993_R),Year1997=values(Year1997_R))
data2<-data.frame(Year1997=values(Year1997_R),Year2001=values(Year2001_R))
data3<-data.frame(Year2001=values(Year2001_R),Year2005=values(Year2005_R))
data4<-data.frame(Year2005=values(Year2005_R),Year2009=values(Year2009_R))
data5<-data.frame(Year2009=values(Year2009_R),Year2013=values(Year2013_R))



round(addmargins(table(data1)))->Table1
round(addmargins(table(data2)))->Table2
round(addmargins(table(data3)))->Table3
round(addmargins(table(data4)))->Table4
round(addmargins(table(data5)))->Table5            
      
### Transetion_Matrix_list

list(Table1,Table2,Table3,Table4,Table5)->Change_matrix










      
