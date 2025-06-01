

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
    
    # -- reactive values
    response <- reactiveVal(NULL)
    
    
    # --------------------------------------------------------------------------
    # Init
    # --------------------------------------------------------------------------
    
    # -- check service status
    service_health <- call_api(uri = build_uri())
    
    # -- output
    output$service_health <- renderUI(
      
      card(
        card_header("API Sirene"),
        
        if(service_health$header$statut == 200)
          div("Etat du service :", if(service_health$etatService == "UP") icon("square-check") else icon("triangle-exclamation", style = "color: red"), br(), 
              "Version :", service_health$versionService)
        else
          p("Etat du service : KO")))
    
    
    # --------------------------------------------------------------------------
    # Input form
    # --------------------------------------------------------------------------
    
    # -- input form
    output$search_form <- renderUI(

      # -- siren / siret
      if(input$search_type %in% c("siren", "siret"))
        textInput(inputId = ns("number"),
                  label = paste("Numero", ifelse(input$search_type == "siren", "(9 chiffres)", "(14 chiffres)")))
      
      # -- name
      else if(input$search_type == "name")
        tagList(
          textInput(inputId = ns("lastname"),
                    label = "Nom"),
          textInput(inputId = ns("firstname"),
                    label = "Prénom (facultatif)"))
      
      else if(input$search_type == "company")
        textInput(inputId = ns("company_name"),
                  label = "Dénomination")) |> bindEvent(input$search_type)
    
    
    # -- observe button
    observeEvent(input$search, {
      
      # -- check inputs
      req(isTruthy(input$number) || isTruthy(input$lastname) || isTruthy(input$company_name))
      cat("New value siren =", input$number, "\n")
      
      # -- check values
      if(input$search_type == "siren"){
        if(nchar(input$number) == 9){
          if(!is.na(as.numeric(input$number)))
            response(call_api(uri = build_uri(service = "siren", number = input$number)))
          else
            cat("SIREN number should only contain numeric characters \n")
        }
        else
          cat("SIREN number should be 9 digits \n")
        
      } else if(input$search_type == "siret"){
        if(nchar(input$number) == 14){
          if(!is.na(as.numeric(input$number)))
            response(call_api(uri = build_uri(service = "siret", number = input$number)))
          else
            cat("SIRET number should only contain numeric characters \n")
        }
        else
          cat("SIRET number should be 14 digits \n")
        
      } else if(input$search_type == "name") {
        
        response(call_api(uri = build_uri(service = "siren", lastname = input$lastname, firstname = input$firstname)))

      } else if(input$search_type == "company") {
        
        response(call_api(uri = build_uri(service = "siren", company = input$company_name)))
        
      }
        
    })
    
    
    # -- Input validation
    output$validation <- renderUI(
      validate(
        if(input$search_type == "siren") need(nchar(input$number) == 9, 'Le numéro de SIREN doit contenir 9 chiffres!'),
        if(input$search_type == "siret") need(nchar(input$number) == 14, 'Le numéro de SIRET doit contenir 14 chiffres!')))
    
    
    # -- Search result
    output$search_result <- renderUI({

      cat("New response available, updating search result \n")

      # -- get response as a df      
      df_result <- dt_from_response(response())
      
      # -- build cards
      lapply(df_result$siren, function(x) search_result_card(df_result[df_result$siren == x, ]))
      
    })
    
  })
}
