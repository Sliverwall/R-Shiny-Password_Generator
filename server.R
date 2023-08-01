#----------SERVER----------------
server <- function(input, output, session) {
  
  rawData <- reactive({
    
    # Reactive object for imported CSV
  blankdf <- get_Blank_CSV()
  
  
    if(!is.null(input$file_upload)){
    read.csv(input$file_upload$datapath)
    } else {
      blankdf
    }
    
  })
  
  output$rawData_table <- renderDT({
    
    # Generate table for imported CSV
    get_Datatable_W(rawData(), 5)
    
  })
  
  password_source <- reactive({
    
    # Use selected combo boxes to form string with all possible characters
    combo_boxes <- input$combo_boxes
    
    set_PasswordChars(combo_boxes)
    
  })

  ### Check password output
  
  password_made <- reactive({
    
    # Check if no combo_boxes selected
    if(password_source() != ""){
    
    initalize_var <- input$refreshButton # link var to button to force gen_Password() to reinitialize
    num_char <- input$numofchar
    
    # Convert the string to a character vector (individual characters)
    vector_password <- base::strsplit(password_source(), "")[[1]]
    
    # Generate sample from sourced chars given n chars
    string_list <- gen_Password(vector_password, num_char, initalize_var)
    
    
    # Convert list of final chars to string
    result <- base::paste(string_list, collapse = "")
    
    # return result
    return(result)
    
    } else {
      # return password123 in case no parameters are set
      "password123"
    }
  })
  
  
  # Set observe statements finding unique column names within imported csv file
  
  website_col_name <- reactive({
    colnames(rawData())
  })
  
  observe({
    updateSelectInput(session, inputId = "website_col", choices = c("Website", website_col_name()))
  })
  
  username_col_name <- reactive({
    colnames(rawData())
  })
  
  observe({
    updateSelectInput(session, inputId = "username_col", choices = c("Username", username_col_name()))
  })
  
  comments_col_name <- reactive({
    colnames(rawData())
  })
  
  observe({
    updateSelectInput(session, inputId = "comment_col", choices = c("Comments", comments_col_name()))
  })
  
  password_col_name <- reactive({
    colnames(rawData())
  })
  
  observe({
    updateSelectInput(session, inputId = "password_col", choices = c("Password", password_col_name()))
  })

  
  
  # Set observer to send generated password to update text output
  observe({
  updateTextInput(session, "password_cite", value = password_made())
  })
    

  # Define commit_info as a reactive object
  commit_info <- reactive({
    get_Github_Commits(owner, repo, github_token)
  })
  
  # Render commit information in a DT table
  output$commit_output <- renderDT({
    info <- commit_info()
      if (is.null(info) || length(info) == 0) {
        return(NULL)
      } else {
        df <- data.frame(
          id = sapply(info, function(x) x$id),
          title = sapply(info, function(x) {
            words <- strsplit(x$title, " ")[[1]]
            paste(words[1:2], collapse = " ")  # First 2 words as title
          }),
          description = sapply(info, function(x) {
            words <- strsplit(x$description, " ")[[1]]
            paste(words[3:length(words)], collapse = " ")  # 3rd word and beyond as description
          }),
          author = sapply(info, function(x) x$author)
        )
        return(get_Datatable_W(df, 50))
      }
    })
  

}
