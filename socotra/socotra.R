library(raster)
library(sp)
library(MASS)
library(rgdal)
library(sf)

# Create a land cover change transition matrix automatically 
Land_Transition_Matrix <- function(Classification, Image_File_Path) {
  SEEA_Classes <- Classification
  Classes <- read.csv(SEEA_Classes)
  setwd(Image_File_Path)
  
  # SEEA Color codes
  SEEAMAT <- as.matrix(Classes, ncol = 3, byrow = TRUE)
  
  # Create Land Transition matrix
  
  r.list <- list.files(path = Image_File_Path, pattern = "tif$", full.names = TRUE)
  
  # Get the list of raster data frames
  Data_List <- list()
  
  # Reclassify the list of raster images
  for (i in r.list) {
    raster_I <- raster(i)
    as.data.frame(raster_I) %>% na.omit() -> D1
    names(D1) <- "ESA"
    result <- left_join(D1, Classes, by = "ESA")
    
    result <- result %>% dplyr::select("Classes")
    Data_List[[i]] <- result
  }
  
  data.frame(Data_List) -> AO
  names(AO) <- basename(r.list)
  
  result_list <- list()
  
  for (i in 1:ncol(AO)) {
    for (j in 1:ncol(AO)) {
      if (colnames(AO)[i] == colnames(AO)[j]) {
        break;
      }
      q <- table(data.frame(AO[j], AO[i]))
      result_list[[i]] <- (round(addmargins(q) * 304 * 304 * 1 / 1000000, digits = 1))
    }
  }
  
  result_list[1] <- NULL
  
  if (file.exists("matrix.csv")) {
    file.remove("matrix.csv")
  }
  
  # Write the result
  for (i in result_list) {
    write.table(i, file = "matrix.csv", append = TRUE, sep = ",", col.names = NA, row.names = TRUE, quote = FALSE)
  }
  
}




# Reclassify raster in R 
Reclaas_Raster<-function(Classes,SRC){
  
  Reclass<-Classes
  
  classes<-read.csv(Reclass)
  na.omit(classes[1:3])->classes
  
  SEEAMAT<-as.matrix( classes,ncol = 3,byrow = TRUE)
  Reclass<-paste0(SRC,"\\","reclass")
  Reclass_list<-list.files(Reclass)
  Reclass_list_File<-paste0(Reclass,'\\',Reclass_list)
  for(i in Reclass_list_File){
    if(file.exists(i)){
      file.remove(i)
    }
  }
  
  
  dir.create(Reclass)
  r.list <- list.files(path = SRC, "tif$")
  
  Image_files<-paste0(SRC,"\\",r.list)
  
  for( i in Image_files){
    r <- raster(i)
    landcoverreclass<-reclassify(r,SEEAMAT)
    print(landcoverreclass)
    writeRaster(landcoverreclass,paste0(Reclass,"\\",basename(i)))
    
  }
  
  
  
  
}

Reclaas_Raster(SRC='D:\\socotra\\Year 1993 and 2013',Classes="D:\\socotra\\SEEA_Classes.csv")


Land_Transition_Matrix(Classification = "D:\\socotra\\SEEA_Classification.csv", Image_File_Path = 'D:\\socotra')
