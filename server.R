library(shiny); library(dplyr); library(ggplot2)

## import datasets

# df1 <- read.csv("empRate.csv")
# 
# df2 <- read.csv("RandD.csv")


library(eurostat)  ## it really works!

#clean_eurostat_cache()

empRate <- get_eurostat("t2020_10", time_format = "raw")

rd <- get_eurostat("t2020_20", time_format = "raw")

## manipulating


#employment
empRate$geo <- as.character(empRate$geo)
empRate$time <- as.numeric(levels(empRate$time))[empRate$time]

df1 <- filter(empRate, sex == "T") %>% select(geo,time,values)
#rd

rd$geo <- as.character(rd$geo)
rd$time <- as.numeric(levels(rd$time))[rd$time]

df2 <- select(rd, geo, time, values)

## rename "target" to 2020 so it can be plotted

for (i in 1:length(df1$time)) {
  if (is.na(df1$time[i])) {
    df1$time[i] <- 2020
  }
}

## rename "target" to 2020 so it can be plotted

for (i in 1:length(df2$time)) {
  if (is.na(df2$time[i])) {
    df2$time[i] <- 2020
  }
}

##########3


shinyServer(function (input,output,session) {
    
   
  
    xdata <- reactive({

      res <- get(input$rd)
      res1 <- input$country
      
      filter(res,geo == res1)
    })
    
    output$euPlot <- renderPlot({
      g <- ggplot(xdata(), aes(time,values))
      
      g1 <- g + geom_point(color = 'purple', size = 4 , alpha = 1/2 ) + geom_smooth() +
        scale_x_continuous(breaks = round(seq(min(xdata()$time), max(xdata()$time), by = 2),1)) +
        geom_hline(yintercept =max(xdata()$values, na.rm = TRUE)) +
        labs(title = "EU 2020 Target to be implemented") +
        labs(x = "Year") +
        labs(y = "Percent %") 
      
      print(g1)
      
      
})
    output$doc <- renderPrint({
      includeMarkdown("doc2.Rmd")
    })
})
