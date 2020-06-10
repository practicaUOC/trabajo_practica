#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ade4)

dataset <- setdiff(names(piosphere), "habitat")
pageWithSidebar(
    headerPanel('Exploración'),
    sidebarPanel(width = 4,
        selectInput(inputId = 'df_elegido', 
                    label = 'Dataset a explorar', 
                    choices = dataset),
        checkboxGroupInput(inputId = 'col_elegidas_numericas',
                    label = "Variables continuas a analizar:",choices = ""
                    ),
        shiny::selectInput(inputId = 'col_elegidas_factor',
                           label = "Variables categóricas:",choices = ""
        )
        ),
    mainPanel(
        tabsetPanel(type = "tabs",
        tabPanel("Descriptivos",  
        tableOutput("summary_numeric"),
        plotOutput("plot")),
        tabPanel("Medioambiente por tipo"  
      ))
    )
)