
#-------------General Functions------------]





#-------------tag Functions--------------------

gitHub_Link <- function(github_url, px_position){
tags$li(
  a(href = github_url, 
    icon("github"), 
    style = px_position
  ), 
  class = "dropdown"
)
}


#-------------Side_Bar Widgets------------

get_Numofchar <- function(tab_name, widget_name){
sidebarMenu(
  id = tab_name,
  numericInput("numofchar", widget_name, value = 8, min = 1, max = 30, step = 1)
)
}


get_Chartype <- function(tab_name, widget_name, select_opt){
  sidebarMenu(
    id = tab_name,
    checkboxGroupInput("combo_boxes", widget_name ,select_opt)
  )
}


