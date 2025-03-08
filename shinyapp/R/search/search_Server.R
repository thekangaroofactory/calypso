

# ------------------------------------------------------------------------------
# Module Server logic
# ------------------------------------------------------------------------------

search_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # --------------------------------------------------------------------------
    # Parameters
    # --------------------------------------------------------------------------
    
    # -- trace
    MODULE <- paste0("[", id, "]")
    cat(MODULE, "Starting module server... \n")
    
    # -- namespace
    ns <- session$ns
    
    
    # --------------------------------------------------------------------------
    # Input form
    # --------------------------------------------------------------------------
    
    output$search_form <- renderUI(
      
        if(input$search_type %in% c("SIREN", "SIRET"))
          textInput(inputId = ns("number"),
                    label = paste("Numero", ifelse(input$search_type == "SIREN", "(9 chiffres)", "(14 chiffres)")))
        
        else
          tagList(
            textInput(inputId = ns("lastname"),
                      label = "Name"),
            textInput(inputId = ns("firstname"),
                      label = "First name"))
        
        ) |> bindEvent(input$search_type)
    
    
    
    observeEvent(input$search, {
      
      # -- check
      req(input$siren)
      cat("New value siren =", input$siren, "\n")
      
      response <- call_api(service = "siren", value = input$siren)
        
    })
    
    
  })
}
