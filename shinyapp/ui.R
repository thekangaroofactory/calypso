
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define UI
page_navbar(
  
  # -- footer
  fillable = FALSE,
  footer = p(style = "font-size:9pt;margin-top:20px;", "© 2025 Philippe Peret"),
  
  # -- header / css
  # header = tags$link(rel = "stylesheet", type = "text/css", href = "./css/style.css"),
  
  # -- theme
  theme = bs_theme(
    bg = "grey-90",
    fg = "black",
    primary = "orange",
    secondary = "#ececec",
    base_font = font_google("Quicksand")),
  
  # -- title
  title = "App Title",
  
  # -- Observations
  nav_panel(title = "Nav",
            class = "p-5",
            
            # -- content
            p("Something goes here")),
  
  
  # -- About
  nav_panel(title = "Nav",
            class = "p-5",
            
            # -- content
            p("Something goes here"))
  
)
