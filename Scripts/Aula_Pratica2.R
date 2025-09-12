# Instalando um novo pacote
install.packages("corrplot")
install.packages("DHARMa")

# Carregando pacotes.
library(terra)
library(dplyr)
library(landscapemetrics)
library(sf)
library(lsma)
library(tidyr)
library(corrplot)
library(DHARMa)

# Definindo o diretório de trabalho
shp= "D:/HD/Cursos/Intro_EcoPais_INMA/Dados/shapefiles"
ras= "D:/HD/Cursos/Intro_EcoPais_INMA/Dados/rasters"
d_eco= "D:/HD/Cursos/Intro_EcoPais_INMA/Dados"

# Carregando os dados
pontos<- st_read(paste(shp,"ptos_campo_UTMZ22S.shp", sep ="/"))
paisagem<- rast(paste(ras,"Landcover_2024_Reclass.tif", sep ="/"))
dados<- read.csv(paste(d_eco,"Dados.csv", sep ="/"))
View(dados)

# Criando os buffers para cada paisagem 
buf<- c(500, 750,1000, 1250,1500,2000)
ls <- extract_landscapes(paisagem, pontos,buffers = buf)

# Visualizando
ls$rasters$p01
plot(ls$rasters$p01) # Todos os rasters do ponto 1.
plot(ls$rasters$p01$buf1250) # Raster do ponto 1 com buffer de 1250 m.

# Calculate metrics
metrics <- calculate_metrics(ls, level = "class", what = c("lsm_c_ai","lsm_c_pland","lsm_c_np",
                                          "lsm_l_lsi", "lsm_l_enn_mn", "lsm_l_ed"))
View(metrics)

## Organizando a matriz de métricas ##
unique(metrics$metric)# Visualizando o código de cada métrica.

ai_met<- metrics%>% filter(metric== "ai", class==3)%>% select(c("site","buffer","value"))
np_met<- metrics%>% filter(metric== "np", class==3)%>% select(c("site","buffer","value"))
pland_met<- metrics%>% filter(metric== "pland", class==3)%>% select(c("site","buffer","value"))
ed_met<- metrics%>% filter(metric== "ed")%>% select(c("site","buffer","value"))
lsi_met<- metrics%>% filter(metric== "lsi")%>% select(c("site","buffer","value"))
enn_met<- metrics%>% filter(metric== "enn_mn")%>% select(c("site","buffer","value"))

# Reorganizando as matrizes das métricas
ai_met<- pivot_wider(ai_met,names_from = buffer,values_from = value)
np_met<- pivot_wider(np_met,names_from = buffer,values_from = value)
pland_met<- pivot_wider(pland_met,names_from = buffer,values_from = value)
ed_met<- pivot_wider(ed_met,names_from = buffer,values_from = value)
lsi_met<- pivot_wider(lsi_met,names_from = buffer,values_from = value)
enn_met<- pivot_wider(enn_met,names_from = buffer,values_from = value)
View(ai_met); View(np_met)
View(pland_met); View(ed_met)
View(lsi_met); View(enn_met)

# Substituindo NA por 0
ai_met[is.na(ai_met)]<- 0
np_met[is.na(np_met)]<- 0
pland_met[is.na(pland_met)]<- 0
ed_met[is.na(ed_met)]<- 0
lsi_met[is.na(lsi_met)]<- 0
enn_met[is.na(enn_met)]<- 0

# adicionando duas colunas com os dados biológicos
ai_met<- data.frame(ai_met, dados[,-1])
np_met<- data.frame(np_met, dados[,-1])
pland_met<- data.frame(pland_met, dados[,-1])
ed_met<- data.frame(ed_met, dados[,-1])
lsi_met<- data.frame(lsi_met, dados[,-1])
enn_met<- data.frame(enn_met, dados[,-1])

# Ajustando os modelos de escala de efeito
n_colunas= colnames(ai_met[-c(1,8,9)])

mod_ai= multifit(mod = "lm",multief = n_colunas, data= ai_met,
              richness ~ multief, signif = F, criterion = "R2",
              xlab = "Radius (m)")
mod_np= multifit(mod = "lm",multief = n_colunas, data= np_met,
         richness ~ multief, signif = F, criterion = "R2",
         xlab = "Radius (m)")
mod_pland= multifit(mod = "lm",multief = n_colunas, data= pland_met,
                 richness ~ multief, signif = F, criterion = "R2",
                 xlab = "Radius (m)")
mod_ed= multifit(mod = "lm",multief = n_colunas, data= ed_met,
                 richness ~ multief, signif = F, criterion = "R2",
                 xlab = "Radius (m)")
mod_lsi= multifit(mod = "lm",multief = n_colunas, data= lsi_met,
                    richness ~ multief, signif = F, criterion = "R2",
                    xlab = "Radius (m)")
mod_enn= multifit(mod = "lm",multief = n_colunas, data= enn_met,
                 richness ~ multief, signif = F, criterion = "R2",
                 xlab = "Radius (m)")

# Mostrando os gráficos
mod_ai
mod_np
mod_pland
mod_ed
mod_lsi
mod_enn

# Visualizando a tabela de resultados
mod_ai$summary

# Montando minha matriz de análise de dados com as métricas
# nas escalas selecionadas.
ai<- ai_met$buf750
np<- np_met$buf1500
pland<- pland_met$buf2000
ed<- ed_met$buf750
lsi<- lsi_met$buf1250
enn<- enn_met$buf2000

# Juntando todas as métricas na escala selecionada com os 
#dados biológicos.
riq<- dados[,2]
dados_analise<- data.frame(ai,np,pland,ed,lsi,enn, riq)
View(dados_analise)

# Testando a multicolinearidade
correl= cor(dados_analise[,-7])
correl

# Criando um gáfico de correlação
corrplot(correl, method = "shade", addCoef.col = 'black', type= "lower")

# Testando a nossa hipótese
mod1= lm(riq~ai+np+pland+enn, data= dados_analise)

# Testando pressupostos
res<- simulateResiduals(mod1) # Primeiramente vamos simular os residuos
plot(res) # Testando normalidade e homocedasticidade nos resíduos.
testDispersion(res) # Restando overdispersal

# Conferindo o resultado do nosso teste estatístico
summary(mod1)
