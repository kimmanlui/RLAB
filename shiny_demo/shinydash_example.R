library(shiny)
library(shinydashboard)

title="Example"

UI_DASHBOARD=function() {
  basicPage(
    h2("Dashboard tab content"),
    actionButton("mybutton", "myButton", icon = icon("h-square"))
  )
}

click_DASHBOARD=function(input,output,session)
{
  print("mybutton clicked")
}

UI_HELP=function() {
  basicPage(h2("Help tab content"))
}




ui <- dashboardPage(
  dashboardHeader(title = title),
  
  dashboardSidebar(
    sidebarMenu(id = "tabs", # note the id
                menuItem    ("Dashboard" , tabName = "dashboard", icon = icon("dashboard")),
                menuItem    ("HelpGroup" ,                        icon = icon("h-square"),
                                 menuItem('help',tabName = 'help',icon = icon('h-square'))
                            ),
                actionButton("itemButton", "itemButton"         ,  icon = icon("h-square"))
                             
    ),
    br(),
    actionButton("menuButton", "menuButton", icon = icon("h-square"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard", UI_DASHBOARD() ),
      tabItem(tabName = "help"     , UI_HELP() )
    )
  )
)

server <- function(input, output, session) {
  
  print(input)

  observe({ 
    print(input$tabs) 
  })
  
  observeEvent(input$menuButton, {
    print("menuButton clicked")
  })

  observeEvent(input$itemButton, {
    print("itemButton clicked")
  })
    
  observeEvent(input$mybutton, {
    click_DASHBOARD()
  })
}


app=shinyApp(ui,server)
runApp(app, host="0.0.0.0")
