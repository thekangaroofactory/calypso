

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- search health
search_health_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  uiOutput(ns("service_health"))
  
}


# -- search input form
search_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  tagList(
    layout_columns(
      
      # -- first column
      radioButtons(inputId = ns("search_type"),
                   label = "Rechercher par :",
                   #choices = c("SIREN" = "siren", "SIRET" = "siret", "Nom / prénom" = "name", "Dénomination" = "company")
                   choices = c("SIREN" = "siren", "SIRET" = "siret", "Nom / prénom" = "name")),
      
      # -- second column
      tagList(
        uiOutput(ns("search_form")),
        uiOutput(ns("validation")))),
    
    actionButton(inputId = ns("search"),
                 label = "Rechercher"))
  
}


# -- search result
searh_result_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  uiOutput(ns("search_result"))
  
}

