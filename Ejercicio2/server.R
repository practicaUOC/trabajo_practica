#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(ggridges)
library(ggpubr)
library(plotly)
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
    
    observe({
        x <- input$df_elegido
        tipo.variables<-sapply(piosphere[[x]],class)
        v.numericas<-colnames(piosphere[[x]])[tipo.variables=="numeric"]
        shiny::updateCheckboxGroupInput(session, "col_elegidas_numericas",
                                        choices = colnames(piosphere[[x]][v.numericas]))
    })
    
    
    
     output$summary_numeric <-renderText({
         if(is.null(input$col_elegidas_numericas)|is.null(input$col_elegidas_factor)|is.null(input$df_elegido))
             return(NULL)
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
     
     output$histogram_habitat_continuas<-renderPlot({
         df<-piosphere$env
         variable<-input$variable_grafico
         df.plot<-data.frame(habitat=piosphere$habitat,Var=df[,variable])
         plot<- df.plot %>% ggplot(aes(x =Var , y = habitat, fill = factor(stat(quantile)))) +
                 stat_density_ridges(
                     geom = "density_ridges_gradient",
                     calc_ecdf = TRUE,
                     quantiles = c(0.025, 0.975)
                 ) +
                 scale_fill_manual(
                     name = "Probability", values = c("#FF0000A0", "#A0A0A0A0", "#0000FFA0"),
                     labels = c("(0, 0.025]", "(0.025, 0.975]", "(0.975, 1]")
                 )+xlab(variable)
             plot
             
         })
     
     output$summary_habitat<-renderText({
         df<-piosphere$env
         variable<-input$variable_grafico
         variable<-"logDist"
        
         
     })
     
     
     output$boxplot_habitat_continuas<-renderPlotly({
         df<-piosphere$env
         variable<-input$variable_grafico
         df.plot<-data.frame(habitat=piosphere$habitat,Var=df[,variable])
         plot<- df.plot %>% ggboxplot(x = "habitat", y = "Var",
                                      color = "habitat", palette =c("green4", "red4", "blue4","yellow4"),
                                      ylab = variable)+ 
             stat_compare_means(label.y = (max(df[,variable])+5))        
         ggplotly(plot,tooltip = "habitat")
     })
     
     
     output$scatter_plot<-renderPlotly({
         df<-piosphere$env
         variable1<-input$variable_1
         variable2<-input$variable_2
         df.plot<-data.frame(habitat=piosphere$habitat,Var1=df[,variable1],Var2=df[,variable2],Piosfera=rownames(df))
         plot<- plot_ly(data = df.plot,
                        x = ~Var1,
                        y = ~Var2,
                        color = ~habitat,
                        hoverinfo = 'text',
                        text = ~paste(Piosfera,
                                      '</br></br>', habitat))%>% layout(
                                          xaxis = list(title = variable1),
                                          yaxis = list(title = variable2, tickfont = list(size = 15))
                                      )
         
                        
         
       plot  
     })
    
}