
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define UI
page_navbar(
  
  # -- footer
  fillable = TRUE,
  footer = p(style = "font-size:9pt;margin-top:20px;color:#FFF;", "© 2025 Philippe Peret"),
  
  # -- header / css
  header = tags$link(rel = "stylesheet", type = "text/css", href = "./css/base.css"),
  
  # -- theme
  theme = bs_theme(
    primary = "orange",
    secondary = "#ececec",
    base_font = font_google("Quicksand")),
  
  # -- title
  title = "Calypso",
  
  # -- search
  nav_panel(title = "Rechercher",
            class = "p-5",
            
            # -- content
            p("Calypso effectue des recherches dans le répertoire SIRENE."),
            p("Cette fonctionalité est basée sur l'appel en temps réel à l'API Sirene publiée par l'INSEE.", br(),
            "La recherche est limitée à 20 résultats. Plus d'information [ici]."),
            
            search_health_ui("search"),
            
            search_ui("search"),
            
            searh_result_ui("search")),
  
  
  # -- explore
  nav_panel(title = "Explorer",
            class = "p-5",
            
            # -- content
            p("Something goes here too")),
  
  
  # -- about
  nav_panel(title = "A propos",
            class = "p-5",
            
            # -- content
            p("Calypso explore le répertoire SIRENE."))
  
)
