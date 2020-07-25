#ST 558 - HW 14 Part II
#Zachary Vaskalis
#07/18/2020 

library(shiny)
library(dplyr)
library(ggplot2)
library(stringr)

shinyServer(function(input, output, session) {
   
	getData <- reactive({
		newData <- msleep %>% filter(vore == input$vore)
	})
	
	#observe if sleepREM is checked
	observe({if(input$sleepREM==TRUE){updateSliderInput(session, "size", min = 3)}
	  else {updateSliderInput(session, "size", min = 1)}
	  })
	
  #create plot
  output$sleepPlot <- renderPlot({
  	#get filtered data
  	newData <- getData()
  	
  	#create and update plot based on user selections
  	g <- ggplot(newData, aes(x = bodywt, y = sleep_total))
  	
  
  	  if(input$conservation==TRUE & input$sleepREM==TRUE){
  	    g + geom_point(size = input$size, aes(col = conservation, alpha = sleep_rem))
  	  }else if (input$conservation==TRUE & input$sleepREM==FALSE){
  	    g + geom_point(size = input$size, aes(col = conservation)) 
  	    }else {
  	      g + geom_point(size = input$size)
  	    }
  
  	  
  })
  #create text info
  output$info <- renderText({
  	#get filtered data
  	newData <- getData()
  	
  	paste("The average body weight for order", input$vore, "is",
  	      round(mean(newData$bodywt, na.rm = TRUE), 2),
  	      "and the average total sleep time is",
  	      round(mean(newData$sleep_total, na.rm = TRUE), 2), sep = " ")
  })
  
  output$voreSelected <- renderUI({
    text <- paste0("Investigation of ",str_to_sentence(input$vore), "vore Mammal Sleep Data")
    h1(text)
    })
    
  #create output of observations    
  output$table <- renderTable({
		getData()
  })
  
})
