shinyUI(pageWithSidebar(
  headerPanel("Word Cloud from Twitter News Feeds"),

  sidebarPanel(

    selectInput("tsource", label = h4("Select Tweet Source"), 
                choices = list("All Tweets" = 1, 
                               "CNN Tweets" = 2,
                               "Fox News Tweets" = 3), selected = 2),
    
    dateRangeInput("dates", 
                          start="2015-10-15", 
                          end="2015-10-20", width='100%',
                          min="2015-10-16", max="2015-10-25",
                          label = h4("Date range")),
    sliderInput("maxw", 
                label=h4("Maximum number of words"), 
                value = 150,
                min = 50, 
                max = 300),

        numericInput("minf", 
                 label = h4("Minimum word frequency"), 
                 value = 4,min=1,max=10),
    
    helpText("Note: Please select a date between 2015-10-16", 
             "and 2015-10-26. The word cloud will be refreshed",
             "accordingly. This is a corpus of 914 tweets",
             "from CNN and Fox News on this period.")
    ),

    mainPanel(
        tabsetPanel(type = "tabs", 
                    tabPanel("Word cloud", plotOutput('TCloud')), 
                    tabPanel("Help", h4("Online documentation"),
                             p("This application is based on 914 Tweets from",strong("CNN and Foxnews")),
                             p("collected from 10-16-2015 to 10-25-2015. These tweets were collected"),
                             p("using the package TwitteR. The Tweets are stored in a RDS file."),
                             br(),
                             p("Using the application is very simple:"),
                             p("- select the tweet source"),
                             p("- select the date period"),
                             p("- select the minimum word frequency"),
                             p("- select the maximum number of words in the cloud"),
                             br(),
                             p("The word cloud will refresh automatically.")
                             
                                                        
                                                        ) )

  )
))
