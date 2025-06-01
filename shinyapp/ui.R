
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define UI
page_navbar(
  
  # -- footer
  #fillable = TRUE,
  footer = p(style = "font-size:9pt;margin-top:20px;margin-left:20px;color:#FFF;", "© 2025 Philippe Peret"),
  
  # -- header / css
  header = tags$link(rel = "stylesheet", type = "text/css", href = "./css/base.css"),
  
  # -- theme
  theme = bs_theme(
    primary = "#02587c",
    secondary = "#ececec",
    base_font = font_google("Quicksand")),
  
  # -- title
  title = "Calypso",
  
  # -- search
  nav_panel(title = "Rechercher",
            class = "p-5",
            
            layout_column_wrap(
              fill = FALSE,
              
              # -- card
              card(
                fill = FALSE,
                card_header("Présentation"),
                
                # -- content
                p("Calypso effectue des recherches dans le répertoire SIRENE."),
                p("Cette fonctionalité est basée sur l'appel en temps réel à", 
                  tags$a("l'API",
                         target = "_blank",
                         href = "https://www.data.gouv.fr/fr/dataservices/api-sirene-open-data/"),
                  "Sirene publiée par l'INSEE.", br(),
                  "La recherche est limitée à 20 résultats.")),
              
              search_health_ui("search")),
            
            card(
              fill = FALSE,
              card_header("Recherche"),
              search_ui("search")),
            
            searh_result_ui("search")),
  
  
  # -- explore
  # nav_panel(title = "Explorer",
  #           class = "p-5",
  #           
  #           # -- content
  #           p("Something goes here too")),
  
  
  # -- about
  nav_panel(title = "A propos",
            class = "p-5",
            
            card(
              fill = FALSE,
              card_header("A propos"),
              
              # -- content
              p("Calypso explore le répertoire SIRENE.", br(),
                "Toutes les données viennent de l'API mise à disposition par l'INSEE."),
              
              p("La réutilisation est publiée sur la platforme data.gouv.fr.", br(),
                tags$a("data.gouv.f", target = "_blank", href = "https://www.data.gouv.fr/fr/organizations/philippe-peret/reuses/"))),
            
            card(
              fill = FALSE,
              card_header("Contact"),
              div(icon("linkedin"), tags$a("LinkedIn", target = "_blank", href = "https://www.linkedin.com/in/philippeperet/"))))
  
)
