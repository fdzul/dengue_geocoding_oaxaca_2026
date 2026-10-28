rm(list= ls())
# Step 1. recuperar el nombre del archivo como lo guardamos en el paso 1.
infile <- paste0("dengue_", Sys.Date())


# Step 2. apply the vector addreses ####
addresses <- densnv::data_geocode(infile = infile,
                                  data = FALSE)
VEC_ID <- addresses$VEC_ID
addresses <- addresses$addresses

# Step 3. text manipulation ####
#stringr::str_subset(addresses, "Campeche")
#addresses <- stringr::str_replace_all(addresses,
#                                     pattern = "62744 CUAUTLA  MOR",
#                                     replacement = "CUAUTLA")
#addresses[364] <- "AVENIDA PRIVADA SANATA ANA MANZANA 32,  Fraccionamiento LA GUADALUPA  BENITO JUAREZ     77518, Quintana Roo,Mexico"
#addresses[60] <- "CALLE BARRANCA LOS REYES, Colonia LOS TRES REYES ,AXOCHIAPAN 62955, Morelos,Mexico"
#addresses[1121]  <- "CALLE  JACARANDAS 27, Colonia NUEVA ALEMANIA ,TEPIC, Nayarit,Mexico"

# Step 4. geocoding ####
densnv::geocode(addresses,
                infile = infile)

# Step 5. load the dengue geocoded & dengue dataset #####
z <- readRDS(paste(infile, "_temp_geocoded.rds",sep = "")) |>
    dplyr::distinct(index, .keep_all = TRUE) |>
    dplyr::mutate(VEC_ID = VEC_ID)


# Step 6. load the dengue dataset ####
data <- densnv::data_geocode(infile = infile, 
                             data = TRUE)


# Step 7. save the results #####
densnv::save_geocode(geocode = z,
                     data = data,
                     directory = "3.geocoded_data",
                     infile = infile)



