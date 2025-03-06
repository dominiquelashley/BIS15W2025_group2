---
title: "bis15L_project"
author: "Itzel Gonzalez"
date: "2025-03-05"
output: html_document
---



## Load the Libraries  

``` r
library(tidyverse)
library(shiny)
library(shinydashboard)
require(janitor)
library(ggplot2)
```




``` r
ui <- dashboardPage(
  skin = "green",
  dashboardHeader(title = "Spotify Wrapped"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",
               tabName = "dashboard",
               icon = icon("home")),
      
      menuItem("Favorite Artists", 
               tabName = "artist", 
               icon = icon("user")),
      
      menuItem("Popular Songs", 
               tabName = "songs", 
               icon = icon("music")),
     
       menuItem("Song Attributes", 
               tabName = "attribute", 
               icon = icon("chart-simple")),
      
      menuItem("Attributes Over Time",
               tabName = "history",
               icon = icon("calendar-days"))
      
    )
    ),
  
  ## Body content
  dashboardBody(
    tabItems(
  
      ## First tab content    
      tabItem(tabName = "dashboard",
              h1("Spotify Wrapped: A Journey through Music Trends and Chart Insights"),
              h4("BIS15L Project: Group 2"),
              h4("Group Members: Itzel,")
          ),
      
      ## Second tab item 
      tabItem(tabName = "attribute",
              h2("Relationships between Song Attributes"),
              
              fluidPage(
                selectInput("x", 
              "Select X Variable",
              choices = c("danceability_percent", "valence_percent", "energy_percent", "acousticness_percent", "instrumentalness_percent", "liveness_percent", "speechiness_percent" ), 
              selected = "danceability_percent"),
              
  selectInput("y", 
              "Select Y Variable",
              choices = c("danceability_percent", "valence_percent", "energy_percent", "acousticness_percent", "instrumentalness_percent", "liveness_percent", "speechiness_percent" ),
              selected = "danceability_percent"),
  
  plotOutput("plot", width = "500px", height = "400px")
              )
      )
    ),
      tabItem(tabName = "history",
              h2("Song Attributes Over Time",
                 
                 fluidPage(
                   selectInput("attribute",
                               "Select Attribute:")
                 ))
      
    )
  )
)
    
server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  
  output$plot <- renderPlot({
    
    ggplot(data=spotify_data,
    aes_string(x=input$x, y=input$y))+
    geom_point(color = "#1ED760")+
    theme_light(base_size = 14)
  })
}

shinyApp(ui, server)
```


