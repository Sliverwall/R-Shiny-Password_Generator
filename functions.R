
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





#------------Server Help Functions-------------



#------------Generate Password Functions---------


gen_Password <- function(numOfChar){
  
 password_para <- set_PasswordLimit()
 
 
 result <- base::sample(password_para, size = numOfChar, replace = TRUE)
 
 return(result)
  
}


set_PasswordLimit <- function(){
  
  password_limit <- base::paste0(UPPER_CASE_LETTERS,
                                 LOWER_CASE_LETTERS,
                                 DIGITS,
                                 SYMBOL_CHAR)
  return(password_limit)
}

search_Combo_Boxes <- function(combo_boxes){
  
  uppercase <- "Uppercase" %in% combo_boxes
  lowercase <- "Lowercase" %in% combo_boxes
  digits <- "Digits" %in% combo_boxes
  
  
  
}


SELECT_CHAR_TYPE <- c("Uppercase", "Lowercase", "Digits", "Symbols (!@#$...)")



