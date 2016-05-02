#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotrix)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$oid1 = renderPrint({
 
    if (input$radioType == '1'){
      ttestType <- "two.sample"
    }
    if (input$radioType == '2'){
      ttestType <- "one.sample"
    }
    if (input$radioType == '3'){
      ttestType <- "paired"
    }
    
    if (input$radioAlt == '1'){
      ttestDirection <- "two.sided"
    }
    if (input$radioAlt == '2'){
      ttestDirection <- "one.sided"
    }
  
    round(power.t.test(power = input$power, 
                 delta = input$delta, 
                 sd = input$sd, 
                 type = ttestType, 
                 alt = ttestDirection)$n , 0)
  
  
    })
  
  output$distPlot <- renderPlot({
    
    if (input$radioType == '1'){
      ttestType <- "two.sample"
    }
    if (input$radioType == '2'){
      ttestType <- "one.sample"
    }
    if (input$radioType == '3'){
      ttestType <- "paired"
    }
    
    if (input$radioAlt == '1'){
      ttestDirection <- "two.sided"
    }
    if (input$radioAlt == '2'){
      ttestDirection <- "one.sided"
    }
    
    numCalc <- power.t.test(power = input$power, 
                 delta = input$delta, 
                 sd = input$sd, 
                 type = ttestType, 
                 alt = ttestDirection)$n
    
    generatedPower <- data.frame(matrix(vector(), 
                                        10000, 
                                        2, 
                                        dimnames= list(c(), c("index", 
                                                              "powerCalc"))))
    
    calcSize <- 1
    generatedPower[1, 'index'] <- 1
    for (i in 2:100000) {
      generatedPower[i, 'powerCalc'] <- power.t.test(n = i, 
                                                     delta = input$delta, 
                                                     sd = input$sd, 
                                                     type = ttestType, 
                                                     alt = ttestDirection)$power
      generatedPower[i, 'index'] <- i
      if(generatedPower[i, 'powerCalc'] >= 0.99) {
        calcSize <- i
        break
      }
    }
    
    plot(generatedPower[, 'index'], 
         generatedPower[, 'powerCalc'], 
         col = "red",
         type = "l",
         lwd = 2,
         xlim = c(0, calcSize),
         xlab = "Sample size", 
         ylab = "Power")
    
    ablineclip(h = input$power, x1 = 0,x2 = numCalc,lty=3)
    ablineclip(v = numCalc, y1 = 0, y2 = input$power,lty=3) 
    
  })
  
})
