
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




find_CSV_Column <- function(input_file, input_id,  session_init, choice_int = ""){
  
  
  col_name <- reactive({
    colnames(input_file)
  })
  
  observe({
    updateSelectInput(session_init, inputId = input_id, choices = c(choice_int, col_name()))
  })
}

get_Blank_CSV <- function(){
  df <- data.frame(
    Website = character(),  # Empty character vector for Website
    Username = character(),  # Empty character vector for Username
    Comments = character(),  # Empty character vector for Comments
    Password = character(),  # Empty character vector for Password
    stringsAsFactors = FALSE  # Prevent string columns from being converted to factors
  )
  
  return(df)
  
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



#-------------Data Table Functions-----------
get_Datatable <- function(df, page_len){
DT::datatable(df, options = list(
  pageLength = page_len,
  rownames = FALSE,
  paging = TRUE,
  searching = TRUE,
  scrollX = TRUE,
  dom = 'Blfrtip',  # Add the buttons to the DOM
  buttons = list("copy"),  # Enable Copy button
  rowCallback = JS(  # Alternating row colors
    "function(row, data, index) {",
    "  if (index % 2 === 0) {",
    "    $('td', row).css('background-color', '#f2f2f2');",
    "  }",
    "}"
  )
))
}

get_Datatable_W <- function(df, page_len) {
  DT::datatable(df, extensions = 'Buttons', options = list(
    pageLength = page_len,
    rownames = FALSE,  # Remove the index column
    paging = TRUE,
    searching = TRUE,
    scrollX = TRUE,
    columnDefs = list(list(targets = 0, visible = FALSE)),  # Hide the first column
    # Add CSS styles to the table
    dom = 'Blfrtip',  # Add the buttons to the DOM
    buttons = list(
      'copy',  # Enable Copy button
      'csv',   # Enable Export to CSV button
      'excel', # Enable Export to Excel button
      'pdf'    # Enable Export to PDF button
    ),
    rowCallback = JS(  # Alternating row colors
      "function(row, data, index) {",
      "  if (index >= 0) {",
      "    $('td', row).css('background-color', '#FFFFFF');",
      "    $('td', row).css('text-align', 'center');  // Center align the row values",
      "  }",
      "}"
    ),
    # Add CSS styles to the table
    callback = JS(
      "$(document).ready(function() {",
      "  $('table.dataTable').css('border-collapse', 'collapse');",
      "  $('table.dataTable th, table.dataTable td').css('border', '1px solid black');",
      "  $('table.dataTable').css('border', '2px solid black');",
      "  $('table.dataTable th').css({",
      "    'background-color': '#FFFFFF',",  # Set column header background color
      "    'text-align': 'center'  // Center align the column header text",
      "  });",
      "});"
    )
  ))
}




#----------------API Functions-------------------
# Function to fetch GitHub commits and extract required information
get_Github_Commits <- function(owner, repo, token) {
  url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/commits")
  response <- httr::GET(url, httr::add_headers(Authorization = paste("Bearer", token)))
  commits <- httr::content(response)
  
  # Extract only the required information: unique ID, commit title, and description
  commit_info <- lapply(commits, function(commit) {
    list(
      id = commit$sha,
      title = commit$commit$message,  # Corrected field name for commit title
      description = commit$commit$message,  # Corrected field name for commit description
      author = commit$commit$author$name  # Author of the commit
    )
  })
  
  return(commit_info)
}










