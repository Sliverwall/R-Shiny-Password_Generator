#-------UI------------
# Define UI 
ui <- dashboardPage(
  dashboardHeader(
    title = "Password Generator",
    
    gitHub_Link("https://github.com/sliverwall","font-size: 28px; margin-left: 20px;")
  ),
  dashboardSidebar(  
    
    sidebarMenu(
      menuItem("Generate Password", tabName = "tab1",
               icon = icon("database"))
    ),
    
    get_Numofchar("tab1", "Number of Characters: "),
    get_Chartype("tab1", "Include: ", SELECT_CHAR_TYPE),
    get_Refresh("tab1")
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab1",
              h2("Welcome to the Landing Page!"),
    
    fluidRow(
      column(width = 7,
             box(
               title = "Import CSV to append new password",
               status = "info",
               solidHeader = TRUE,
               collapsible = TRUE,
               width = 12,
               fluidRow(
                 column(width = 4, 
                        fileInput("file_upload", "Choose a CSV file (.csv)"),
                       selectInput("website_col", "Website", choices = NULL),
                       selectInput("username_col", "Username", choices = NULL),
                       selectInput("comment_col", "Comments", choices = NULL),
                       selectInput("password_col", "Password", choices = NULL)
             )),
             fluidRow(
               column( width = 6,
                       offset = 4,
                       style = "margin-top: -400px;",
                       DT::dataTableOutput('rawData_table'))
             )
             
             ),
             box(
               title = "Specificy password use-case",
               status = "info",
               solidHeader = TRUE,
               collapsible = TRUE,
               width = 12,
               textInput("website_cite", "Website", value = ""),
               textInput("username_cite", "Username", value = ""),
               textInput("comment_cite", "Comments", value = ""),
             )
      ),
    )
      )
    ) 
  )
)

