################################################################################
################################################################################
######### Conceitos básicos de ecologia da paisagem: teórico e prático #########
################################################################################
################################################################################
#Podemos utilizar o R para realizar operações básicas de som +,
#subtração -, multiplicação *, divisão / e exponenciação ^.
2+2
2*2
2/2
2-2
3^2

#Também podemos salvar os resultados dentro de um objeto, por exemplo:
#vamos elevar 3 ao quadrado e salvar dentro de objeto chamado A.
A<- 3^2

#Note que o R não mostra o resultado, então temos que pedir para
#o R nos mostrar o resultado da operação. 
#Outra coisa importante é que o R diferencia A de a, o R interpreta
#letras maiúsclas diferentemente de letras minúsculas.
A
a

#Também podemos salvar letras e palavras dentro de um objeto, 
#mas para isso devemos colocar a letra ou a palavra em aspas.
b<- "Hoje"
c<- "Eu"
d<- "Vou aprender R"

b
c
d

###############
### Funções ###
###############

#O R possui diversas funções que podemos utilizar para realizar 
#diferentes operações. O uso de uma função é feito escrevendo o 
#nome da função e entre parêntese os argumentos da função ex:
#funcao(argumentos). Caso precise passar mais de um argumento 
#para função, os argumentos são separados por vírgula.

log(10) # calculando o logarítimo natural de 10.

#Tirando dúvida sobre o uso de uma função.
?log

#Agora podemos calcular o logarítmo de 10 na base 2. 
#Note que temos dois argumentos separados por vírgula.
log(10,2)

#Temos também a função sqrt que retorna a raíz quadrada.
sqrt(360)

#A função round serve para indicar quantas cassas decimais 
#queremos visualizar. Nela passamos um valor ou uma variável 
#que guarda um valor, e indicamos quantas casa decimais 
#queremos. Aqui iremos guardar o resultado da raíz quadrada 
#de 360 dentro de um obejto chamado raiz, e pedir para o R 
#devover o resultado com apenas duas casas decimais.
raiz<- sqrt(360)
round(raiz,2)

#Podemos também utilizar uma função que indica a classe da
#nossa variável.
a<- 10
class(a)

b<- "Eu vou aprender R"
class(b)

# Podemos trasformar dados em classes diferentes.
f1<- c("Trat","Trat", "Contole", "controle")
f2<- factor(c("Trat","Trat", "Contole", "controle"))
f3<- factor(c(1,2,3,4))

class(f1)
class(f2)
class(f3)

########################################
### Estrutura e manipulação de dados ###
########################################
#1. Vetor: é uma sequência de valores que podem ser númericos
#caracteres ou lógicos;

#2. Matrizes: é um objeto com duas dimensões, ou seja, possui 
#linhas e colunas, as matrizes só podem armazenar variáveis 
#de um tipo lógicas, númericas e caracteres. 

#3. Dataframe: assim como as matrizes, também é um objeto de 
#duas dimensões, mas seu diferencial é que ela pode 
#armazenar variáveis de diferentes tipo.

#4 Listas: é um objeto que armazena outras estruturas de 
#dados, podem armazenar vetores, matrizes e dataframes.

## Vetores e operações com vetores

#Vamos começar então pelo estrutura de dados mais simples,
#os vetores. Podemos criar um vetor que armazena diferentes 
#valores.
idade<- c(18,25,30,28,10,15,60,55)
idade

#Como fizemos acima, trambém podemos armazenar letras e 
#palavras em um vetor.
letras<- c("a", "b", "c", "d", "e")
letras

#Podemos mesclar letras e palavras.
palavras2<- c("Edgar", "Curso", "de", "R")
palavras2

#Uma função muito importante se chama length, ela nos retorna
#quantos elementos tem dentro do vetor, ou seja,o tamanho do vetor.
length(idade)

#Nós podemos querer saber a soma das idades dentro do vetor, 
#para isso existe a função sum.
idade
sum(idade)

#Para saber a média das idades usamos a função mean, como não é 
#"elegante" apresentar uma média sem uma medida de dispersão, 
#iremos também calcular o desvio padrão.
mean(idade)
sd(idade)

#Para saber os valores mínimos e máximos podemos utilizar 
#as funções min e max respectivamente.
min(idade)
max(idade)

#É possível fazer outras operações com vetores, abaixo 
#iremos somar 10 a cada valor do vetor.
idade+10

#Da mesma forma que foi possível somar, também é possível
#fazer qual quer uma das operações básicas.
#Podemos também fazer uma operação entre dois vetores de 
#mesmo tamanho.
idade<- c(18,25,30,28,10,15,60,55) 
reducao<-c(2,4,6,8,10,12,14,16)
idade-reducao

### Idenxação de vetores ###
#Agora vamos ver como retirar valores específicos de dentro
#de vetor. Pra acessar uma possição dentro do vetor, não 
#utilizamos colchetes e o número da posição que queremos 
#retirar o valor. Por exemplo, eu quero retirar o 5° 
#elemento de dentro do vetor.
idade[5]

#Retirando valores em duas posições diferentes.
idade[c(1,8)]

#Podemos criar um ou outro vetor que é um subconjunto do 
#vetor idade.
idade2<- idade[c(2,4,6,8)]

### Matrizes ###
#As matrizes são estrutura de dados com duas dimensões, 
#ela possuem linhas e colunas e armazenam dados de apenas 
#um tipo (ex. numérico, character...).
matrix(nrow= 3, ncol= 3)

#Agora vamos criar um matriz com a mesma dimensão, mas 
#preenchida com o número 0.
matrix(data= 0,nrow= 3, ncol= 3)

#Podemos usar dois ou mais vetores para criar uma matriz.
m1<- c(1,2,3,4,5)
m2<- c(6,7,8,9,10)

cbind(m1,m2)# Unindo os vetores como colunas.
rbind(m1,m2)# Unindo os vetores como linhas.

#Retirando valores de uma matriz
m3<- c(11,12, 13, 14, 15)
mat1<- cbind(m1,m2,m3)
mat1

mat1[1,]#Retira os valores da primeira linha
mat1[,2]
mat1[4,1]

#Podemos retirar valores de mais de uma linha e coluna e 
#salvar em um novo objeto.
mat2<-mat1[c(1,3),c(1,2)]
mat2

### Data Frame ###
#Criando dados para um data frame
letras<- c("A", "B", "C","D", "E", "F")
valores<- runif(6)

#Criando data frame
df1<-data.frame(letras, valores)
df1

#Colunas
df2<-cbind.data.frame(letras, valores)
df2

#linhas
df3<-rbind.data.frame(letras, round(valores, 2))
View(df3)

#Retirando valores de um data frame.
df2[,1]# Retirando os valores da primeira coluna.
df2[3,]# retirando os valores da terceira linha

df1[,"letras"]# Posso retirar utilizando o nome da coluna.
df1$letras# Outra forma de retirar os valores de uma coluna.

################################################################################
##################### Estimativa das métricas de paisagem ######################
################################################################################

# Primeiramente é necessário instalar os pacotes que serão utilizados para
# a análise da paisagem
install.packages("terra")# instalar apenas um pacote.
install.packages(c("landscapemetrics", "dplyr", "tidyr","sf", "devtools"))# instalar vários pacotes de uma vez.
remotes::install_github("phuais/multilandr")
remotes::install_github("wilsonfrantine/lsma")

# Agora os pacotes devem ser corregados.
library(terra)
library(landscapemetrics)
library(sf)

# Definindo o diretório de trabalho
shp= "D:/HD/Cursos/Intro_EcoPais_INMA/Dados/shapefiles"
ras= "D:/HD/Cursos/Intro_EcoPais_INMA/Dados/rasters"

# Carregando os dados
pontos<- st_read(paste(shp,"ptos_campo_UTMZ22S.shp", sep ="/"))
pontos

paisagem<- rast(paste(ras,"Landcover_2023.tif", sep ="/"))
paisagem

# Visualizando os dados
View(pontos)# Visualizando a tabela de atributos.
pontos$geometry# Visualizando a coluna de geometria.

plot(paisagem)
plot(st_geometry(pontos), add = TRUE, col = "red", pch = 20)

# Selecionando pontos de interesse
pt5<- pontos$geometry[5]# Retirando o ponto 5
pt5

plot(paisagem)
plot(st_geometry(pt5), add = TRUE, col = "red", pch = 20)

pt246<- pontos$geometry[c(2,4,6)]
pt246

plot(paisagem)
plot(st_geometry(pt246), add = TRUE, col = "red", pch = 20)

# Gerando buffer no entorno dos pontos
bufs<- st_buffer(pontos, dist = 2000)

plot(paisagem)
plot(st_geometry(pontos), add = TRUE,col = "red", pch = 20)
plot(st_geometry(bufs), add = TRUE)

# Recortando as paisagem
mascara<- mask(paisagem, bufs)
recorte<- crop(mascara, bufs)

plot(recorte)
plot(st_geometry(pontos), add = TRUE,col = "red", pch = 20)
plot(st_geometry(bufs), add = TRUE)

# Recortando o raster para uma paisagem
pt5_buf<- st_buffer(pt5, dist = 3000)
pt5_masc<- mask(paisagem, vect(pt5_buf))
pt5_recort<- crop(pt5_masc, pt5_buf)

plot(pt5_recort)
plot(st_geometry(pt5), add = TRUE,col = "red", pch = 20)
plot(st_geometry(pt5_buf), add = TRUE)

### Reclassificando o raster ###
get_unique_values(paisagem)
m2 <- matrix(c(
  10,13,4,   
  29, 30,4,
  32, 33,4,
  3,4,3
), ncol=3, byrow=TRUE)

pai_reclass <- classify(paisagem, m2,others=NA)  # valores não listados viram NA
plot(pai_reclass)

writeRaster(pai_reclass,paste(ras,"Landcover_2023_Reclass.tif", sep ="/") )

### Estimativa de métricas da paisagem ###
# As funções básicas para estimativa das métricas de paisagens seguem uma lógica
# quanto a sua nomenclatura. 
View(list_lsm(level = c("patch")))
View(list_lsm(level = c("class")))
View(list_lsm(level = c("landscape")))

lsm_p_enn# Distância do fragmento para o vizinho mais próximo.
lsm_c_ai# Índice de agregação de cada classe. 
lsm_l_lsi# Índice de forma da paisagem.

dist_frag= lsm_p_enn(pt5_recort)
agreg= lsm_c_ai(pt5_recort)
iforma= lsm_l_lsi(pt5_recort)

dist_frag
agreg
iforma

# É possível calcular várias métricas de uma vez
mets_classe<- c("lsm_c_ai", "lsm_c_pland","lsm_c_np")
mets_classe2= calculate_lsm(pt5_recort, what = mets_classe)
View(mets_classe2)

mets_land<- c("lsm_l_lsi", "lsm_l_shdi","lsm_l_ed")
mets_land2= calculate_lsm(pt5_recort, what = mets_land )
View(mets_land2)
