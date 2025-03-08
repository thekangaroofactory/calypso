
# ------------------------------------------------------------------------------
# This is the server logic of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define server logic
function(input, output, session) {
  
  # --------------------------------------
  # Init
  
  cat("Starting application server... \n")
  
  # -- check debug mode
  if(isTRUE(Sys.getenv("DEBUG")))
    cat("[i] ***** DEBUG mode is ON ***** \n")
  
  
  # --------------------------------------
  # Something_cool_goes_here
  
  search_Server(id = "search")
  
  
}
