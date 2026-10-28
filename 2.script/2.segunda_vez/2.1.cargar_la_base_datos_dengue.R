rm(list = ls())

# Step 1. Load the accumulated dengue dataset ####
# Paso 1. Cargar la base de datos de dengue acumulados ####
# esta base ya se geocodificó
x <- sinave::read_snv(path = "1.data/semana_pasada/DENGUE2_.txt",
                      spatial_resolution = "country",
                      #des_edo_res = "JALISCO",
                      status_caso = c(1, 2))


# Step 2. load dengue dataset the current week ####
# Paso 2. Cargar la base de datos de dengue de la semana actual ####
# En esta base se encuentra los casos nuevos no geocodificados
# que salieron en la semana.

y <- sinave::read_snv(path = "1.data/semana_actual/DENGUE2_.txt",
                      spatial_resolution = "country",
                      #des_edo_res = "JALISCO",
                      status_caso = c(1, 2))

# Step 3. extract the ids not geocoded ###
# Step 3. Extraer los casos nuevos no geocodificados
z <- y |>
    dplyr::filter(!VEC_ID %in% unique(x$VEC_ID)) |>
    dplyr::arrange(VEC_ID)


# Step 4. Save the results ####
# Step 4. Guardar el resultado

# de preferencia guardar con 
# nombre del estado y clave
# fecha del día que se bajo el archivo del sinave

write.csv(z,
          file = paste0("dengue_", Sys.Date(), ".csv"))
