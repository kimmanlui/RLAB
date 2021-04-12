library(shiny)
library(shinydashboard)
library(DT)
library(shinyjs)
library(sodium)



title="Dashboard Demo"

UI_DASHBOARD=function() {
  basicPage(
    h2("Dashboard Tab Content"),
    br(), 
    actionButton("mybutton", "myButton", icon = icon("h-square"))
  )
}

click_DASHBOARD=function(input,output,session)
{
  print("mybutton clicked")
}

UI_HELP=function() {
  basicPage(h2("Help Tab Content"))
}

UI_FIRST=function() {
  fluidRow(
    box(width = 12, dataTableOutput('results'))
  )
}

UI_SECOND=function() {
  fluidRow(
    box(width = 12, dataTableOutput('results2'))
  )
}

masterMenu=function()
{
  sidebarMenu( id = "tabs",
    menuItem("Main Page", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("HELP"     , tabName = "help", icon = icon("th")),
    menuItem("Demo One" , tabName = "first", icon = icon("th")),
    menuItem("Demo Two" , tabName = "second", icon = icon("th"))
  )
}

masterUI=function()
{
  tabItems( 
    tabItem(tabName = "dashboard", UI_DASHBOARD() ),
    tabItem(tabName = "help"     , UI_HELP()      ),
    tabItem(tabName = "first"    , UI_FIRST()     ),
    tabItem(tabName = "second"   , UI_SECOND()    )
  )
}

masterEvent=function(input,output, session)
{
  observeEvent(input$mybutton, {  click_DASHBOARD()  }) 
  
  output$results <-  DT::renderDataTable({
    datatable(iris, options = list(autoWidth = TRUE,
                                   searching = FALSE))
  })
  
  output$results2 <-  DT::renderDataTable({
    datatable(mtcars, options = list(autoWidth = TRUE,
                                     searching = FALSE))
  })
}

########################################################

# Main login screen
loginpage <- div(id = "loginpage", style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
                 wellPanel(
                   
                   tags$h2("LOG IN", class = "text-center", style = "padding-top: 0;color:#333; font-weight:600;"),
                   textInput("userName", placeholder="Username", label = tagList(icon("user"), "Username")),
                   passwordInput("passwd", placeholder="Password", label = tagList(icon("unlock-alt"), "Password")),
                   br(),
                   div(
                     style = "text-align: center;",
                     actionButton("login", "SIGN IN", style = "color: white; background-color:#3c8dbc;
                                 padding: 10px 15px; width: 150px; cursor: pointer;
                                 font-size: 18px; font-weight: 600;"),
                     shinyjs::hidden(
                       div(id = "nomatch",
                           tags$p("Oops! Incorrect username or password!",
                                  style = "color: red; font-weight: 600; 
                                            padding-top: 5px;font-size:16px;", 
                                  class = "text-center"))),
                     br(),
                     br(),
                     tags$code("Username: kimman  Password: kimman"),
                     br()
                   ))
)


credentials = data.frame(
  username_id = c("kimman", "myuser1"),
  passod      = sapply(c("kimman", "mypass1"),password_store),
  permission  = c("basic", "advanced"), 
  stringsAsFactors = F
)

header <- dashboardHeader( title =title , uiOutput("logoutbtn"))

sidebar <- dashboardSidebar(uiOutput("sidebarpanel")) 
body <- dashboardBody(shinyjs::useShinyjs(), 
                      tags$head(includeScript("returnClick.js")),
                      uiOutput("body"))
ui<-dashboardPage(header, sidebar, body, skin = "blue")


server <- function(input, output, session) {
  
  login = FALSE
  #login = TRUE
  USER <- reactiveValues(login = login)
  
  observe({ 
    print(input$tabs)
    
    if (USER$login == FALSE) {
      if (!is.null(input$login)) {
        if (input$login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          if(length(which(credentials$username_id==Username))==1) { 
            pasmatch  <- credentials["passod"][which(credentials$username_id==Username),]
            pasverify <- password_verify(pasmatch, Password)
            if(pasverify) {
              USER$login <- TRUE
            } else {
              shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
              shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
            }
          } else {
            shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
            shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
          }
        } 
      }
    }    
  })
  
  output$logoutbtn <- renderUI({
    req(USER$login)
    tags$li(a(icon("fa fa-sign-out"), "Logout", 
              href="javascript:window.location.reload(true)"),
            class = "dropdown", 
            style = "background-color: #eee !important; border: 0;
                    font-weight: bold; margin:5px; padding: 10px;")
  })
  
  
  output$sidebarpanel <- renderUI({
    if (USER$login == TRUE ){ 
      masterMenu()
    }
  })

  
  
  output$body <- renderUI({
    if (USER$login == TRUE ) {
      masterUI()
    }
    else {
      loginpage
    }
  })
  
  
  masterEvent(input, output, session)
  

  
}

#this shows your working directory and the javascript should be placed there. 
print(getwd())  

app=shinyApp(ui,server)
runApp(app, host="0.0.0.0", port=8555)
