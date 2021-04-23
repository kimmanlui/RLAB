library(networkD3)

subNodes <- 
  read.table(stringsAsFactors = FALSE, header = TRUE, text = "
  nodeID nodeName            nodeGroup                nodeSize
  0  queuePoutOrders     OrderTaskRest            10
  1  completeOrderTaskForType       OrderTasks     10
  2  ActiveMQ                       ActiveMQ                 20
  3  configure                      CompleteOrderRoutes      10
  4  run                            CompleteOrderProcessor   10
  5  CompleteActOrderProcessor      CompleteOrderProcessor   5
  6  CompleteXYZOrderProcessor      CompleteOrderProcessor   5
  7  ActServiceFacade.completeACTServices            ActServiceFacade         5
  8  CnmService                     CnmService               10
  9  CnmWSClient                    CnmWSClient              10
  ")

subLinkList <-
  read.table(stringsAsFactors = FALSE, header = TRUE, text = "
  root  children  linkValue
  0     1         1
  1     2         2
  2     3         2
  3     4         1
  5     4         1
  6     4         1
  5     7         1
  7     8         1
  8     9         1
  ")
colorScale <- "d3.scaleOrdinal(d3.schemeCategory20);"
fn=forceNetwork(Links = subLinkList, Nodes = subNodes, 
                   Source = "root", Target = "children", 
                   Value = "linkValue", NodeID = "nodeName", 
                   Nodesize = "nodeSize", Group = "nodeGroup",
                   colourScale = JS(colorScale),
                charge = -500, opacity = 1, opacityNoHover = 1,
                   fontSize = 25,
                legend = TRUE, bounded = TRUE, 
                   fontFamily = "Calibri", 
                 linkColour = "black",
                   arrow=TRUE,
                   zoom = TRUE)



fn$x$nodes$hyperlink= 
paste0(
  'http://en.wikipedia.org/wiki/Special:Search?search=',
  subNodes$nodeName
)
fn$x$options$clickAction = 'window.open(d.hyperlink)'
fn <- htmlwidgets::prependContent(fn, htmltools::tags$h1("MVNO OE Main Workflow"))
saveNetwork(fn, "/Users/01698091/desktop/oe_main_flow.html", selfcontained = TRUE)

#class(fn)

