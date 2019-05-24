# #TodosPelaEducacao  

Repositório com os scripts usados para:  

1. Acessar, a partir do R, as publicações do Twitter relacionados ao tema;  
1. Processar e analisar tais dados;  
1.  

# Acessar os dados:  
Será usada a biblioteca `rtweet`.  
Será necessário ter conta como dev. no Twitter e a partir disso, criar uma app e solicitar chaves de acesso.  
As chaves usadas nesse exemplo não seráo fornecidas por motivos óbvios.  
As mesmas deverão estar armazenadas em um arquivo ".Renviron", da seguinte forma:  
```
consumer_key=H4l...937
consumer_secret=Cf...YMX
access_token=33...sbs
access_secret=6SR...uN3
app=Nome da app que vc cirou
```  

Dessa forma, quando o script *DownloadData.R* for executado tais códigos de acesso serão lidos e usados pela API do Twitter. O trecho que faz isso é:  

```
# loading keys to use twitter API:
consumer_key <- Sys.getenv("consumer_key")
consumer_secret <- Sys.getenv("consumer_secret")
access_token <- Sys.getenv("access_token")
access_secret <- Sys.getenv("access_secret")
app <- Sys.getenv("app")
```  

Sendo posteriormente usados para habilitar a API:
```
create_token(
  app,
  consumer_key,
  consumer_secret,
  access_token,
  access_secret)
```  
