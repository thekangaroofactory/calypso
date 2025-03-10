

build_uri <- function(service = c("informations", "siren", "siret"), 
                      number = NULL, lastname = NULL, firstname = NULL, company = NULL){
  
  cat("Building target URI \n")
  
  # -- check argument
  service <- match.arg(service)
  
  # -- init url & check
  root_url <- Sys.getenv("API_URL")
  if(root_url == ''){
    message("Error: environment variable API_URL is not defined")
    return(NULL)}
  
  # -- prepare url
  x <- paste(root_url, service, sep = "/")
  
  
  # ----------------------------------------------------------------------------
  # Case informations
  # ----------------------------------------------------------------------------
  
  if(service == "informations")
    return(x)
  
  # ----------------------------------------------------------------------------
  # Case siren / siret by number
  # ----------------------------------------------------------------------------
  
  if(!is.null(number))
    return(paste(x, number, sep = "/"))
  
  
  # ----------------------------------------------------------------------------
  # Case siren / siret by lastname (+ firstname)
  # ----------------------------------------------------------------------------
  
  if(!is.null(lastname) && lastname != ""){
    
    # -- lastname
    x <- paste0(x, "?q=periode(nomUniteLegale:", lastname, ")")
    
    # -- firstname
    if(!is.null(firstname) && firstname != ""){
      x <- paste0(x, " AND prenom1UniteLegale:", firstname)
      x <- URLencode(x)
    }
    
    return(x)

  }
  
  
  # ----------------------------------------------------------------------------
  # Case siren / siret by business name
  # ----------------------------------------------------------------------------

  if(!is.null(company) && company != ""){
  
    x <- paste0(x, "?q=periode(denominationUniteLegale:", company, ")")
    return(x)
    
  }
  
  
  # ----------------------------------------------------------------------------
  # Default (no match with above cases)
  # ----------------------------------------------------------------------------
  
  NULL
  
}

# 
# url <- 'https://api.insee.fr/api-sirene/3.11/siren?q=periode(nomUniteLegale:PERET) AND prenom1UniteLegale:PHILIPPE'
# url <- URLencode(url)
# 
# 
# denominationUniteLegale pour les personnes morales
# nomUniteLegale pour les personnes physiques
# 
