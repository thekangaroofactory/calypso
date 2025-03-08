

call_api <- function(service = c("siren", "siret"), value = NULL){
  
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
  cat("Ready to download from", target_url, "\n")
  
  # -- call API
  tryCatch({
    
    # -- call
    response <- RCurl::getURL(target_url,
                              httpheader = c(Accept = "application/json", 
                                             'X-INSEE-Api-Key-Integration' = Sys.getenv("API_KEY")))
    
    # -- check response size
    cat("Download done, size =", object.size(response) ,"\n")
    
    # -- parse to R object
    response <- jsonlite::fromJSON(response)
    
  },
  
  # -- error 
  error = function(e) e,
  
  # -- return
  finally = ifelse(exists("response"), response, NULL))
  
}
