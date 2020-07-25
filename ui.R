#ST 558 - HW 14 Part II
#Zachary Vaskalis
#07/18/2020 

library(ggplot2)
 
shinyUI(fluidPage(
  
  # Application title
  uiOutput("voreSelected"),
  titlePanel(""),
  
  # Sidebar with options for the data set
  sidebarLayout(
    sidebarPanel(
      h3("Select the mammal's biological order:"),
      selectizeInput("vore", "Vore", selected = "omni", choices = levels(as.factor(msleep$vore))),
      br(),
      sliderInput("size", "Size of Points on Graph",
                  min = 1, max = 10, value = 5, step = 1),
      checkboxInput("conservation", h4("Color Code Conservation Status", style = "color:red;")),
      # Only show this panel if conservation is checked
      conditionalPanel(
        condition = "input.conservation",
        checkboxInput("sleepREM", h5("Also change symbol based on REM sleep?", style = "color:black;"))
        ),
      ),
    
    # Show outputs
    mainPanel(
      plotOutput("sleepPlot"),
      textOutput("info"),
      tableOutput("table")
      )
  )
))
