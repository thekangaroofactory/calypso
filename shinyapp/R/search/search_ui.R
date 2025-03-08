

# ------------------------------------------------------------------------------
# Module UI function
# ------------------------------------------------------------------------------

# -- function
search_ui <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- return
  tagList(
    
    radioButtons(inputId = ns("search_type"),
                 label = "Rechercher par :",
                 choices = c("SIREN", "SIRET", "Autre")),
  
    uiOutput(ns("search_form")),
    
    actionButton(inputId = ns("search"),
                 label = "Rechercher"))
  
}
