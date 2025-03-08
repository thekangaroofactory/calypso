

# -- attach dependencies
library(shiny)
library(bslib)


# -- Init & source code
for(nm in list.files("R", pattern = ".R", full.names = T, recursive = T))
  source(nm)
rm(nm)
