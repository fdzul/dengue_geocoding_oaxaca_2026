rm(list = ls())
# Step 1. Load the accumulated dengue dataset ####
# Paso 1. Cargar la base de datos de dengue acumulados ####
# 
z <- sinave::read_snv(path = "1.data/semana_actual/DENGUE2_.txt",
                      spatial_resolution = "state",
                      des_edo_res = "MORELOS",
                      status_caso = c(1, 2))

# Step 2. Save the results ####
# Step 2. Guardar el resultado

# de preferencia guardar con 
# nombre del estado y clave
# fecha del día que se bajo el archivo del sinave

write.csv(z, 
          file = "dengue_2026_02_19.csv")

