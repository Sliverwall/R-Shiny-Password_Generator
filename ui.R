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
    get_Chartype("tab1", "Select Combo Boxes: ", SELECT_CHAR_TYPE),
    get_Refresh("tab1")
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab1",
              h2("Welcome to the Landing Page!"),
    
    fluidRow(
      column(6, verbatimTextOutput("check_password"))
    )
      )
    )
    
    
  )
)

