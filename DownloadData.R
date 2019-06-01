library(rtweet)

# Criando autenticação:
create_token(
  Sys.getenv("app"),
  Sys.getenv("consumer_key"),
  Sys.getenv("consumer_secret"),
  Sys.getenv("access_token"),
  Sys.getenv("access_secret"))

# buscando tweets a partir de hashtag
Edu <- search_tweets("#30MpelaEducacao", n = 108000, include_rts = TRUE, type = "popular", retryonratelimit = TRUE)
# convertendo dados espaciais em lat/long
Edu <- lat_lng(Edu)
# salvando CSV
write_as_csv(Edu, paste0("./dados/EduPopular_", Sys.Date(),".csv"))

rm(list=ls())
gc()
