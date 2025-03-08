
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
            p("Calypso explore le répertoire SIRENE."),
            
            search_ui("search")),
  
  
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
