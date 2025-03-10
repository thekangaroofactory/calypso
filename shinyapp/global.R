

# -- attach dependencies
library(shiny)
library(bslib)


# -- environment
DEBUG <- as.logical(Sys.getenv("DEBUG"))


# -- Init & source code
for(nm in list.files("R", pattern = ".R", full.names = T, recursive = T))
  source(nm)
rm(nm)
