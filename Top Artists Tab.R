#Loading the Data
most_streamed<-read_csv("~/Desktop/BIS15W2025_group2/Spotify Most Streamed Songs.csv")
most_streamed %>% 
  clean_names()

#Filtered data frame for app
artist_app_data <-
  most_streamed %>% 
  mutate(streams=as.numeric(streams, na.rm=T)) %>%
  group_by(`artist(s)_name`) %>% 
  summarize(total_streams=sum(streams),
            total_charts=sum(in_spotify_charts),
            total_playlists=sum(in_spotify_playlists))

#App code
# Define UI
ui <- fluidPage(
  titlePanel("Top 10 Spotify Artists by Category"),
  
  selectInput("y", "Select Ranking Metric:",
              choices = c("Most Streams" = "total_streams",
                          "Most Songs on Charts" = "total_charts",
                          "Most Songs in Playlists" = "total_playlists"),
              selected="total_streams"),
  
  plotOutput("plot")
)


server <- function(input, output, session) {
  
  
  
  output$plot <- renderPlot({
    top_artists <- artist_app_data %>%
      arrange(desc(!!sym(input$y))) %>%  # Sort by selected metric
      head(10)
    
    
    ggplot(data=top_artists, 
           aes_string(x="`artist(s)_name`", y=input$y))+
      geom_col(fill = "#1DB954")+
      labs(x="Artist", y="Metric")+
      theme_classic()
  })
}

shinyApp(ui, server)
