
library("wordcloud");
library("tm");
library(RColorBrewer);

tcloud <- function (tw, dstart,dstop,maxw,minf)
{
  twf <- tw[(tw$date >= dstart ) & ( tw$date <= dstop ) ,];
  
  tcorpus <- Corpus(VectorSource(twf$text));
  tcorpus <- tm_map(tcorpus, content_transformer(tolower));
  tcorpus <- tm_map(tcorpus, removeNumbers) ;
  tcorpus <- tm_map(tcorpus, removePunctuation);
  tcorpus <- tm_map(tcorpus, stripWhitespace);
  tcorpus <- tm_map(tcorpus, removeWords, stopwords("english")); 
  cl <- brewer.pal(8,"Dark2")
  w <- wordcloud(tcorpus,min.freq=minf,max.words=maxw, random.order=F, colors=cl)
}

tw <- readRDS('tw.rds');


shinyServer(
  function(input, output) {

    renderText({paste("Start date = ", dstart)});
    
          output$TCloud <- renderPlot({
          dstart <- input$dates[[1]];
          dstop <- input$dates[[2]];
          minf <- input$minf;
          maxw <- input$maxw;
          
          if (input$tsource == 1)  { twf <- tw   }
          if (input$tsource == 2)  { twf <- tw[tw$tsource=="cnn",];   }
          if (input$tsource == 3)  { twf <- tw[tw$tsource=="foxnews",]; }
          
          tcloud(twf,dstart,dstop,maxw,minf);

    })
  }
)