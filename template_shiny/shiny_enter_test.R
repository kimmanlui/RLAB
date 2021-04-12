library(shiny)

ui <- fluidPage(
  
  tags$head(includeScript("returnClick.js")),
  
  textInput("passwd", "", placeholder = "Enter text then hit return", width = "100%"),
  actionButton("login", "Go!"),
  verbatimTextOutput("textOutput")
  
)

server <- function(input, output, session) {
  
  output$textOutput <- renderText({
    
    input$login # take a dependency on the button click
    
    # isolate text input to only re-render when button is clicked
    isolate(input$passwd) 
  })
  
}

shinyApp(ui, server)