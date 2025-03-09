

call_api <- function(service = c("siren", "siret"), value = NULL, notify = TRUE){
  
  # -- check argument
  service <- match.arg(service)
  
  # -- init url & check
  root_url <- Sys.getenv("API_URL")
  if(root_url == ''){
    message("Error: environment variable API_URL is not defined")
    return(NULL)}
  
  # -- prepare target url
  target_url <- paste(root_url, service, sep = "/")
  target_url <- paste(target_url, value, sep = "/")
  # target_url <- paste0(target_url, "?q=nomUniteLegale:'PERET'")
  cat("Ready to call URL", target_url, "\n")
  
  # -- call API
  tryCatch({
    
    # -- call
    response <- RCurl::getURL(target_url,
                              httpheader = c(Accept = "application/json", 
                                             'X-INSEE-Api-Key-Integration' = Sys.getenv("API_KEY")))
    
    # -- check response size
    cat(">> Done, response size =", object.size(response) ,"\n")
    
    # -- parse to R object
    response <- jsonlite::fromJSON(response)
    
  },
  
  # -- error 
  error = function(e) e,
  
  # -- return
  finally = {
    
    # -- check
    if(exists("response")){
      
      cat("Response status =", response$header$statut, "\n")
      
      # -- check status
      if(response$header$statut == 200)
        response
      
      else {
        
        cat("Message =", response$header$message, "\n")
        
        if(notify)
          switch(as.character(response$header$statut),
                 "404" = showNotification(response$header$message))
        
        return(NULL)}
      
    } else NULL
    
  })
  
}
