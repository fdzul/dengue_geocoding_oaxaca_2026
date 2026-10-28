
rm(list = ls())

# Step 1. recuperar el nombre del archivo como lo guardamos en el paso 1.
infile <- "dengue_2026_02_19"

# Step 2. subimos los casos nuevos  ###
# esta base son los casos de la ultima semana 
load(paste("3.geocoded_data/","geo_" ,infile, ".RData", sep = ""))

data <- data[stringr::str_which(data$formatted_address,  " Mexico"),]


# Step 3. save the results ####
# guarda la base de datos acumulada actualizada

save(data, 
     file = "4.RData/dengue_morelos_2026.RData")





