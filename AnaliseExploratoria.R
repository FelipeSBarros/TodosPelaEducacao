library(tidyverse)
library(tidytext)
library(ggwordcloud)
library(widyr)
library(igraph)
library(ggraph)
library(lubridate)

# Carregando so dados
source("./LoadData.R")

# carregando stopowords do pacote tidytext
stopword.pt <- stopwordslangs %>% filter(lang == "pt" & p >= 0.95) %>% select(word)

# analise geral -----
# Tweets ~ tempo
df_Edu  %>%
  ts_plot("hours")+
  labs(
    title = "Quantidade de tweets por hora")
#ggsave(filename = "./graficos/QuantidadeTweetHora", device = "png")

#Hashtags mas usadas
df_Edu %>% 
  unnest_tokens(input = "hashtags", output = "Hashtags") %>% 
  count(Hashtags, sort = TRUE) %>% 
  filter(!is.na(Hashtags)) %>% 
  top_n(60) %>% 
  ggplot(aes(label = Hashtags, size = n, color = n)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  scale_color_gradient(low = "red", high = "darkred") + 
  theme_minimal() 

# wordcloud mencoes
df_Edu %>% 
  unnest_tokens(input = "mentions_screen_name", output = "Mentions") %>% 
  count(Mentions, sort = TRUE) %>% 
  filter(!is.na(Mentions)) %>% 
  top_n(60) %>% 
  ggplot(aes(label = Mentions, size = n, color = n)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 15) +
  scale_color_gradient(low = "red", high = "darkred") + 
  theme_minimal()

# palavras mas usadas
df_Edu %>% 
  unnest_tokens(input = "text", output = "word") %>% 
  anti_join(stopword.pt) %>% 
  count(word, sort = TRUE) %>% 
  #filter(! word %in% c("t.co", "https", "30mpelaeducacao", "educação", "tsunami30m", "30m", "30mpelaeducação")) %>% 
  top_n(60) %>% 
  ggplot(aes(label = word, size = n, color = n)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 14) +
  scale_color_gradient(low = "red", high = "darkred") + 
  theme_minimal()


# Grafo
Merged <- df_Edu %>% 
  unnest_tokens(input = "mentions_screen_name", output = "Mentions") %>% 
  filter(!is.na(Mentions)) %>% 
  unnest_tokens(input = "hashtags", output = "Hashtags") %>% 
  gather("origin", "MentionsMerged", Mentions, Hashtags) %>% 
  filter(!is.na(MentionsMerged))

Merged %>%
  pairwise_count(MentionsMerged, status_id, sort = TRUE, upper = FALSE) %>%
  filter(n>500) %>% 
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n
  ), end_cap = circle(.07, 'inches'), edge_colour = "cyan4") +
  geom_node_point(size = 2) +
  geom_node_text(aes(label = name), repel = TRUE,  vjust = 1, hjust = 1) +
  theme_void()

#  Plotand em mapa
par(mar = c(0, 0, 0, 0)) # reduzindo margens da figura
## plot limite Brasil
maps::map(regions = "Brazil", lwd = 1)
maps::map(database = 'world', lwd = .3, add=T)
## plot lat and lng no mapa
with(df_Edu, points(lng, lat, pch = 20, cex = .75, col = "red"))
