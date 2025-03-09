

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- search input form
search_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  layout_columns(
    
    radioButtons(inputId = ns("search_type"),
                 label = "Rechercher par :",
                 choices = c("SIREN" = "siren", "SIRET" = "siret", "Nom / dénomination" = "name", "Commune & activité" = "city")),
  
    uiOutput(ns("search_form")),
    
    actionButton(inputId = ns("search"),
                 label = "Rechercher"))
  
}


# -- search result
searh_result_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  DT::DTOutput(ns("result"))
  
}


# -- search health
search_health_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  uiOutput(ns("service_health"))
  
}

