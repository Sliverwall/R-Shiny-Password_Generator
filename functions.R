
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

get_Refresh <- function(tab_name){
  
  sidebarMenu(
    id = tab_name,
    actionButton("refreshButton", label = "Refresh", class = "refresh-button")
  )
}





#------------Server Help Functions-------------

set_PasswordChars <- function(combo_boxes){
  
  # initialize blank password list
  
  password_string <- ""
  
  # Check the check boxes
  USE_UPPER <- search_Combo_Boxes(combo_boxes, "Uppercase")
  USE_LOWER <- search_Combo_Boxes(combo_boxes, "Lowercase")
  USE_DIGITS <- search_Combo_Boxes(combo_boxes, "Digits")
  USE_SYMBOL <- search_Combo_Boxes(combo_boxes, "Symbols (!@#$...)")
  
  
  # Append the corresponding character sets
  if (USE_UPPER) {
    password_string <- base::paste(password_string, UPPER_CASE_LETTERS)
  }
  
  if (USE_LOWER) {
    password_string <- base::paste(password_string, LOWER_CASE_LETTERS)
  }
  
  if (USE_DIGITS) {
    password_string <- base::paste(password_string, DIGITS)
  }
  
  if (USE_SYMBOL) {
    password_string <- base::paste(password_string, SYMBOL_CHAR)
  }
  
  # Remove empty strings
  password_string <- base::gsub(" ", "", password_string)
  
  return(password_string)
}




#------------Generate Password Functions---------


gen_Password <- function(password_para, numOfChar, initalize_var){
 
 result <- base::sample(password_para, size = numOfChar, replace = FALSE)
 
 return(result)
  
}


search_Combo_Boxes <- function(combo_boxes, search_con){
  
  result <- search_con %in% combo_boxes

  return(result)
  
}








