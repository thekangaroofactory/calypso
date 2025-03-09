# 
# 
# bar <- RCurl::getURL(url,
#               httpheader = c(Accept = "application/json", 
#                              'X-INSEE-Api-Key-Integration' = Sys.getenv("API_KEY")))
# 
# bar <- jsonlite::fromJSON(bar)
# 
# 
# url <- 'https://api.insee.fr/api-sirene/3.11/siren?q=periode(nomUniteLegale:PERET) AND prenom1UniteLegale:PHILIPPE'
# url <- URLencode(url)
# 
# 
# denominationUniteLegale pour les personnes morales
# nomUniteLegale pour les personnes physiques
# 
