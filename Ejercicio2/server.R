#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

function(input, output, session) {
    
    # Combine the selected variables into a new data frame
    # selectedData <- reactive({
    #     iris[, c(input$xcol, input$ycol)]
    # })
    # 
    # clusters <- reactive({
    #     kmeans(selectedData(), input$clusters)
    # })
    # 
    # output$plot1 <- renderPlot({
    #     palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
    #               "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    #     
    #     par(mar = c(5.1, 4.1, 0, 1))
    #     plot(selectedData(),
    #          col = clusters()$cluster,
    #          pch = 20, cex = 3)
    #     points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    # })
   
    observe({
        x <- input$df_elegido
        tipo.variables<-sapply(piosphere[[x]],class)
        v.numericas<-colnames(piosphere[[x]])[tipo.variables=="numeric"]
        shiny::updateCheckboxGroupInput(session, "col_elegidas_numericas",
                          choices = colnames(piosphere[[x]][v.numericas]))
    })
    
    observe({
        x <- input$df_elegido
        tipo.variables<-sapply(piosphere[[x]],class)
        v.factor<-colnames(piosphere[[x]])[tipo.variables=="factor"]
        shiny::updateSelectInput(session, "col_elegidas_factor",
                                        choices = colnames(piosphere[[x]][v.factor]))
    })
    
    
     output$summary_numeric <-renderText({
        df<-input$df_elegido
        cols<-input$col_elegidas_numericas
        psych::describe(x = piosphere[[df]][cols]) %>% 
        kableExtra::kable(format='html',
                          digits=4) %>% 
        kableExtra::kable_styling()
        })
     
     output$plot <- renderPlot({
         df<-input$df_elegido
         variable<-input$col_elegidas_factor
         tb<-table(piosphere[[df]][,variable]) %>% data.frame()
         colnames(tb)<-c(variable,"Freq")
         ggplot(data=tb, aes(x=get(variable), y=Freq)) +
             geom_bar(stat="identity", fill="steelblue")+
             theme_minimal()+xlab(variable)
     })
     
}