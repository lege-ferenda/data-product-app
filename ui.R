library(shiny)
shinyUI(fluidPage(
  titlePanel("European Union 2020 Targets"),

sidebarLayout(
    sidebarPanel(
      selectInput("rd", 
                  label = "Select the dataset:",
                  choices = list("Employmnet Rate" = "df1", "Research" = "df2")), 
                 
      selectInput("country",
                  label = "Select EU Country", 
                  choices = list("Austria" = "AT","Belgium" = "BE" , "Boulgaria" = "BG",
                                 "Cyprous" = "CY",
                                 "Czech Republic" = "CZ","Germany" = "DE","Denmark" = "DK",
                                 "Estonia" = "EE","Greece" = "EL","Spain" = "ES",
                                 "Finland" = "FI","France" = "FR", "Croatia" = "HR",
                                 "Hungary" = "HU", "Ireland" = "IE", "Italy" = "IT",
                                 "Lithuania" = "LT","Luxembourg" = "LU" ,"Latvia" = "LV",
                                 "Malta" = "MT", "Netherlands" = "NL", "Poland" = "PL",
                                 "Portugal" = "PT", "Romania" = "RO", "Sweden" = "SE",
                                 "Slovenia" = "SI", "Slovakia" = "SK", "European Union" = "EU28")),
      
      submitButton(text="Plot")
      ),

mainPanel(
  tabsetPanel(
    tabPanel("Plot",plotOutput("euPlot")),
    tabPanel("Documentation",verbatimTextOutput("doc"))
)
  )

                  
)
  
)
)

    



  
