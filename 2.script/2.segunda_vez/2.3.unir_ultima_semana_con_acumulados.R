rm(list= ls())
# Step 1. recuperar el nombre del archivo como lo guardamos en el paso 1.
infile <- paste0("dengue_", Sys.Date())

# Step 2. subimos los casos nuevos  geocodificados ###
# esta base son los casos de la ultima semana 
load(paste("3.geocoded_data/","geo_" ,infile, ".RData", sep = ""))

y <- data[stringr::str_which(data$formatted_address,  " Mexico"),]

y <- y |>
    dplyr::select(-IDE_TEL,-TELFONO_TRABAJO, -COMPROMISO_ORGANOS)

# Step 3. subimos casos acumulados geocodificados ###
load("4.RData/dengue_mx_2026.RData")

data <- z #|>dplyr::select(-IDE_TEL,-TELFONO_TRABAJO,-COMPROMISO_ORGANOS)

# Step 4. unimos ambas bases (acumulado y la semana actual) ####

z <- rbind(data, # bases geocodifica ultima semana
           y # bases geocodificada de la semana actual 
           )


# Step 5. Cargar la base de datos de dengue de la semana actual ####
w <- sinave::read_snv(path = "1.data/semana_actual/DENGUE2_.txt",
                      spatial_resolution = "country",
                      #des_edo_res = "JALISCO",
                      status_caso = c(1, 2)) |>
    dplyr::select(VEC_ID)


# Step 6. eliminar los casos descartados ####
z <- z |>
    dplyr::mutate(FEC_INI_SIGNOS_SINT = as.integer(FEC_INI_SIGNOS_SINT)|> 
                      data.table::as.IDate()) |>
    dplyr::filter(VEC_ID %in% unique(w$VEC_ID)) |>
    dplyr::arrange(VEC_ID)


# Step 7. save the results ####
# guarda la base de datos acumulada actualizada
# hasta la semana actual
save(z, 
     file = "4.RData/dengue_mx_2026.RData")


#######
z <- z |>
    dplyr::mutate(x = long,
                  y = lat) |>
    sf::st_as_sf(coords = c("x", "y"),
                 crs =4326)


z <- z[rgeomex::AGEE_inegi19_mx, ]

# tabasco ####
library(sf)
tab <- rgeomex::AGEE_inegi19_mx |>
    dplyr::filter(CVE_ENT == "27")
mapview::mapview(tab)

z_tab <- z[tab, ] |>
    sf::st_drop_geometry()
save(z_tab, 
     file = "4.RData/denmex_2026_edo27.RData")


# Quintana Roo ####
library(sf)
qro <- rgeomex::AGEE_inegi19_mx |>
    dplyr::filter(CVE_ENT == "23")
mapview::mapview(qro)

z_qro <- z[qro, ] |>
    sf::st_drop_geometry()
save(z_qro, 
     file = "4.RData/denmex_2026_edo23.RData")


# Cuahuila ####
library(sf)
coa <- rgeomex::AGEE_inegi19_mx |>
    dplyr::filter(CVE_ENT == "05")
mapview::mapview(coa)

z_coa <- z[coa, ] |>
    sf::st_drop_geometry()
save(z_coa, 
     file = "4.RData/denmex_2026_edo05.RData")



# Guanajuato ####
#library(sf)
gto <- rgeomex::AGEE_inegi19_mx |>
    dplyr::filter(CVE_ENT == "11")
mapview::mapview(gto)

z_gto <- z[gto, ] |>
    sf::st_drop_geometry()

save(z_gto, 
     file = "4.RData/denmex_2026_edo11.RData")


class(z)
