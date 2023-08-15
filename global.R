#-------IMPORTS--------
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyFiles)
library(DT)
library(dplyr)
library(httr)
library(jsonlite)

#---------SOURCES------------

if(is.null(source("config.R"))){
  
} else {
  source("config.R")
}
source("constants.R")
source("functions.R")
source("ui.R")
source("server.R")
source("load_app.R")

