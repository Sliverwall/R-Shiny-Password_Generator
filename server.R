#----------SERVER----------------
server <- function(input, output, session) {
  
  rawData <- reactive({
    
    # Reactive object for imported CSV
    
    req(input$file_upload)
    read.csv(input$file_upload$datapath)
    
  })
  
  output$rawData_table <- renderDT({
    
    # Generate table for imported CSV
    get_Datatable(rawData(), 10)
    
  })
  
  password_source <- reactive({
    
    # Use selected combo boxes to form string with all possible characters
    combo_boxes <- input$combo_boxes
    
    set_PasswordChars(combo_boxes)
    
  })

  ### Check password output
  
  output$check_password <- renderPrint({
    
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

    
  }

