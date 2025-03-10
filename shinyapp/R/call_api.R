

call_api <- function(uri, notify = TRUE){
  
  cat("Ready to call external API \n")
  if(DEBUG)
    cat("Target URI =", uri, "\n")
  
  # -- call API
  tryCatch({
    
    # -- call
    response <- RCurl::getURL(uri,
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
