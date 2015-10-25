install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")

library("twitteR");
library("wordcloud");
library("tm");
library(RColorBrewer);


stweets <- function(tsource, twt ) 
{
  #save text
  ttext <- as.data.frame(sapply(cnn.tweets, function(x) x$getText()),stringsAsFactors=FALSE);
  tdate <- as.data.frame(sapply(cnn.tweets, function(x) as.String(x$getCreated()) ));
  colnames(ttext) <- c("text");
  colnames(tdate) <- c("date");
  tdate$date <- as.Date(tdate$date);
  tw <- cbind(tdate,ttext);  
  tw$text <- iconv(tw$text,to="utf-8-mac", sub="");
  tw$tsource <- tsource;
  return(tw);
}


#Tweets analysis on brands
setup_twitter_oauth( < > Put access keys here >....);

cnn.tweets = searchTwitter('from:cnn', n=2500);
foxnews.tweets = searchTwitter('from:cnn', n=2500);

cnntw <- stweets("cnn",cnn.tweets);
foxnewstw <- stweets("foxnews",foxnews.tweets);

tw <- rbind(cnntw,foxnewstw);

###################

saveRDS(tw, "tw.rds")



