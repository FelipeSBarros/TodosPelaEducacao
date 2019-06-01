library(data.table)
library(tidyverse)
library(lubridate)
library(rtweet)

# TodosPelaEducacao
TweetsList <- list.files("./dados", full.names = TRUE, pattern = "Edu")
df_Edu <- lapply(TweetsList, read_twitter_csv)
df_Edu <- rbindlist(df_Edu, fill = TRUE)

# Remover duplicated
df_Edu <- df_Edu %>%  
  distinct(status_id, .keep_all = TRUE)

rm(TweetsList)
gc()