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
    get_Button("tab1", "refreshButton", "Refresh"),
    get_Button("tab1","appendButton","Append Table"),
    get_Button("tab1","writeButton","Write CSV"),
    
    sidebarMenu(
      menuItem("Change Log", tabname = "tab2",
                icon = icon("github"),
      menuSubItem(tabName = "tab2", "Commits")))
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab1",
              h2(LANDING_PAGE_TITLE),
    
    fluidRow(
      column(width = 7,
             box(
               title = "Import CSV or Use Blank Template",
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
                       selectInput("password_col", "Password", choices = NULL),
                       textInput("fileNameSelect", "CSV File Name", value = ""),
                       textInput("filePathSelect", "CSV File Path", value = "")
             )),
             fluidRow(
               column( width = 6,
                       offset = 4,
                       style = "margin-top: -400px;",
                       shinycssloaders::withSpinner(DT::dataTableOutput('rawData_table')))
             )
             
             ),
             box(
               title = "Specificy password use-case",
               status = "info",
               solidHeader = TRUE,
               collapsible = TRUE,
               width = 7,
              fluidRow(
                  column(width = 4,
                     textInput("website_cite", "Website", value = ""),
                     textInput("username_cite", "Username", value = "")),
                  column(width = 5,
                         offset = 4,
                         style = "margin-top: -145px;",
                     textInput("comment_cite", "Comments", value = ""),
                     textInput("password_cite", "Password", value = "")
             )
              ))
      ),
    )
      ),
    
    tabItem(tabName = "tab2",
            fluidPage(
              # Other UI elements (if any) go here
              
              # Output to display commits
              DT::dataTableOutput("commit_output")
            ))
    ) 
  )
)

