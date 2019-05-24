library(rtweet)

# loading keys to use twitter API:
consumer_key <- Sys.getenv("consumer_key")
consumer_secret <- Sys.getenv("consumer_secret")
access_token <- Sys.getenv("access_token")
access_secret <- Sys.getenv("access_secret")
app <- Sys.getenv("app")
create_token(
  app,
  consumer_key,
  consumer_secret,
  access_token,
  access_secret)

# buscando tweets a partir de hashtag ou perfis
rt <- search_tweets("todospelaeducacao", n = 18000, include_rts = TRUE, type = "mixed", retryonratelimit = TRUE)
x <- ?lat_lng(rt)

par(mar = c(0, 0, 0, 0))
maps::map("world", lwd = .25)

## plot lat and lng points onto state map
with(x, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))
dev.off()


# Stream tweets
# random sample for 30 seconds (default)
streamtweets <- stream_tweets("")
## stream tweets from london for 60 seconds
streamtweets <- stream_tweets("todospelaeducacao", timeout = 60)
## stream london tweets for a week (60 secs x 60 mins * 24 hours *  7 days)
stream_tweets(
  "todospelaeducacao",
  timeout = 60 * 60 * 24,
  file_name = "tweetsaboutEducation.json",
  parse = FALSE
)

## read in the data as a tidy tbl data frame
streamtweets <- parse_stream("tweetsaboutEducation.json")

## read in JSON file
## world data set with with lat lng coords variables
x <- lat_lng(streamtweets)
