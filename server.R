#----------SERVER----------------
server <- function(input, output, session) {
  
  ### Check password output
  
  output$check_password <- renderPrint({

    input$combo_boxes
  })

    
  }

