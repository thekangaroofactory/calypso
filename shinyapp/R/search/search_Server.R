

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
    service_health <- call_api()
    
    output$service_health <- renderUI(
    
      if(service_health$header$statut == 200)
        p("Etat du service :", ifelse(service_health$etatService == "UP", "OK", "KO"), br(), 
          "Version :", service_health$versionService)
      else
        p("Etat du service : KO"))
    
    
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
      
      # -- city
      else
        tagList(
          textInput(inputId = ns("city"),
                    label = "Commune"),
          textInput(inputId = ns("activity"),
                    label = "Code activité (facultatif)"))) |> bindEvent(input$search_type)
    
    
    # -- observe button
    observeEvent(input$search, {
      
      # -- check inputs
      req(isTruthy(input$number) || isTruthy(input$lastname) || isTruthy(input$city))
      cat("New value siren =", input$number, "\n")
      
      # -- check values
      if(input$search_type == "siren"){
        if(nchar(input$number) == 9){
          if(!is.na(as.numeric(input$number)))
            response(call_api(service = "siren", value = input$number))
          else
            cat("SIREN number should only contain numeric characters \n")
        }
        else
          cat("SIREN number should be 9 digits \n")
        
      } else if(input$search_type == "siret"){
        if(nchar(input$number) == 14){
          if(!is.na(as.numeric(input$number)))
            response(call_api(service = "siret", value = input$number))
          else
            cat("SIRET number should only contain numeric characters \n")
        }
        else
          cat("SIRET number should be 14 digits \n")
        
      }
        
    })
    
    
    # -- observer reactiveVal
    output$result <- DT::renderDT({
      
      # -- get content
      x <- response()
      
      # -- build df to display
      if("uniteLegale" %in% names(x))
        
        data.frame(
          "siren" = x$uniteLegale$siren,
          "nom" = x$uniteLegale$periodesUniteLegale[x$uniteLegale$nombrePeriodesUniteLegale, "nomUniteLegale"],
          "prenom" = x$uniteLegale$prenom1UniteLegale,
          "creation" = x$uniteLegale$dateCreationUniteLegale,
          "mise à jour" = x$uniteLegale$dateDernierTraitementUniteLegale,
          "activité" = x$uniteLegale$periodesUniteLegale[x$uniteLegale$nombrePeriodesUniteLegale, "activitePrincipaleUniteLegale"])
      
      else if("etablissement" %in% names(x))
        
        data.frame(
          "siren" = x$etablissement$siren,
          "siret" = x$etablissement$siret,
          "nom" = x$etablissement$uniteLegale$nomUniteLegale,
          "prenom" = x$etablissement$uniteLegale$prenom1UniteLegale,
          "creation" = x$etablissement$dateCreationEtablissement,
          "mise à jour" = x$etablissement$dateDernierTraitementEtablissement,
          "activité" = x$etablissement$uniteLegale$activitePrincipaleUniteLegale)
      
    })
    
    
  })
}
