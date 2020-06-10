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
dataset2 <- setdiff(names(piosphere), c("traits","habitat"))
pageWithSidebar(
    headerPanel('Exploración'),
    sidebarPanel(width = 4,
    conditionalPanel(condition="input.tabselected==1",
                     selectInput(inputId = 'df_elegido', 
                      label = 'Dataset a explorar', 
                      choices = dataset),
                    checkboxGroupInput(inputId = 'col_elegidas_numericas',
                      label = "Variables continuas a analizar:",choices = ""),
                    selectInput(inputId = 'col_elegidas_factor',
                      label = "Variables categóricas:",choices = "")),
    conditionalPanel(condition="input.tabselected==2",
                       radioButtons(inputId="variable_grafico","Variable a graficar ", choices = colnames(piosphere$env))),
    conditionalPanel(condition="input.tabselected==3",
                     selectInput(inputId = 'variable_1',
                                 label = "Variable 1",choices =colnames(piosphere$env),multiple = F),
                     selectInput(inputId= 'variable_2',
                                 label = "Variable 2",choices =colnames(piosphere$env),multiple = F))),
    mainPanel(
        tabsetPanel(id = "tabselected",
        tabPanel("Descriptivos",  value = 1,
        h4("Tabla de Descriptivos de las variables continuas seleccionadas"),
        tableOutput("summary_numeric"),
        h4("Barplot de la variable categórica seleccionada"),
        plotOutput("plot")),
        tabPanel("Medioambiente por tipo",value = 2,
        h4("Descriptivo por tipo de habitat"),         
        tableOutput("summary_habitat"),
        h4("Histograma por tipo de habitat"),    
        plotOutput("histogram_habitat_continuas"),
        h4("Boxplot interactivo por tipo de habitat"),    
        plotlyOutput("boxplot_habitat_continuas")
      
      ),
      tabPanel("Correlación entre variables medioambientales",value = 3,
               h4("Coeficiente de correlación entre las variables seleccionadas"),    
               tableOutput("correlaciones"),
               h4("Scatter plot entre las variables seleccionadas"),    
               plotlyOutput("scatter_plot")
      ))
    )
)