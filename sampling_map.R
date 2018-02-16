#############################
## Basic sampling map in R ##
##     Nassima Bouzid      ##
##      15 Feb 2018        ##
#############################


##########################################
############ Load packages ###############
library(maps)
library(maptools)
##**Must have XQuartz installed on Mac OSX+

##########################################
######## Read in locality data ###########
locality_data <- read.csv("~/Path/to/.csv", 
                          header=TRUE)

##########################################
#### Open plotting device; set params ####
quartz(width=7, height=9) #Opens a window for plotting
opt <- par(mar=rep(0, 4), 
           oma=c(0,0,0,0), 
           omi=c(0,0,0,0), 
           mai=rep(0, 4))

##########################################
####### Plot base map/other layers #######
##Base map
base_map <- map('world',
                xlim=c(-125,-111), #longitudinal extent
                ylim=c(31.5,49), #latitudinal extent
                col="gray95", 
                fill=T,
                lwd=2, 
                xaxt='n', 
                yaxt='n', 
                xaxs="i", 
                yaxs="i")
## Range polygon
range.poly <- readShapePoly("/Path/to/IUCN/shapefile/.shp", 
                            proj4string=CRS("+proj=longlat"))
plot(range.poly, 
     add=TRUE, 
     col=adjustcolor("#003262", alpha=0.4), 
     border=adjustcolor("#003262", alpha=0.3))
##Get range polygons from IUCN
##http://www.iucnredlist.org/technical-documents/spatial-data

##########################################
######## Add features to the map #########
##Lat/long tick marks
map.axes(cex.axis=0.8)
##Points
points(x=locality_data$Longitude, 
       y=locality_data$Latitude, 
       cex=1, 
       pch=21, 
       lwd=0.01, 
       col=adjustcolor("#FDB515", alpha=0.4), 
       bg=adjustcolor("#FDB515", alpha=0.5))
##Labels next to points
text(x=locality_data$Longitude, 
     y=locality_data$Latitude, 
     labels=locality_data$Population, 
     pos=4)

##########################################
###### Export from plotting device #######
quartz.save("~/Path/to/output/directory/.pdf", 
            type="pdf", #OR "png"
            dpi=300)
