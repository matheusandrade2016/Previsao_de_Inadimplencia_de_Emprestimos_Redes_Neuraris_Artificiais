# Instalando e carregando nossas bibliotecas

# Pacote para redes neurais
# install.packages('h2o')

library(caTools)
library(h2o)
library(caret)
library(pROC)

# Carregando nossa base de dados 
base <-  read.csv('credit_data.csv')

# # Apagando minha coluna ClientID, pois anao ira no nosso algoritmo

base$clientid = NULL

# Transformando nossa variavel para o formanto factor para nosso algortimo

# Atualizando meus valores com a media das idades pois temos valores
# negativos em nossos dados na coluna idade

base$age <-  ifelse(base$age < 0, 40.92, base$age)


# Atualizando a média para valores Ausentes que temos na nossa coluna idade

base$age <-  ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)


# Padronizando nossos dados para deixarmos na mesma escala
base[, 1:3] <-  scale(base[, 1:3])

# Criando nossa semente aleatoria 
set.seed(1)

# Criando minha varavel classe "resposta" ou seja nossa divisão

# 1500 --> para treinar
# 500 --> para testar

divisao <-  sample.split(base$default, SplitRatio = 0.75)
divisao

# Criando minha base de treinamento
base_treinamento <-  subset(base, divisao == TRUE) 

# Criando minha base de dados de teste
base_teste = subset(base, divisao == FALSE) 

##########################################################################

# Algoritimo das Redes Neurais

# Fazendo a Conexão com o Servidor para melhorar nossa perfomace por isso o uso
# dessa biblioteca

# nthreads --> O numero de CPUs que iremos ultilizar

# nthreads é uma abreviação de "number of threads", ou seja, o número de threads 
# (fios de execução) que um processo pode usar.

# Quando você define nthreads = -1 no h2o.init(), você está basicamente dizendo ao H2O 
# para usar todos os núcleos disponíveis do seu processador

h2o.init(nthreads = -1)


# Criando meu Classificador de redes neurais

# y--> Nome do nosso atributo classe

# training_frame --> que será nossa base de dados de treinamento

# as.h2o --> para transformar nossa base no formato da biblioteca

# activation --> função de ativação das redes neurais "Rectifier" sendo a mais ultilizada

# hidden --> quantas camadas escondidas iremos ultilizar c("formato de vetor, onde tera 100 neuronios na camada oculta")

# epochs --> quantas vezes iremos fazer os ajustes dos pesos


classificador <-  h2o.deeplearning(y = 'default',
                                 training_frame = as.h2o(base_treinamento),
                                 activation = 'Rectifier',
                                 hidden = c(100, 100), # melhor com 2 camada oculta
                                 epochs = 1000)


# Criando minha variavel previsões

# as.h2o --> para transformar nossa base de dados para o formato da Biblioteca

previsoes <-  h2o.predict(classificador, newdata = as.h2o(base_teste[-4]))

# Fazendo uma conversão para melhorar nossa vizualização dos dados 
previsoes <-  (previsoes > 0.5)
previsoes

# Precisamos Transformar nossa variavel em um Vetor 
previsoes <- as.vector(previsoes)
previsoes

# Criando nossa matriz de Confusão
matriz_confusao <-  table(base_teste[, 4], previsoes)
matriz_confusao

# Verifciando nossa acuracia
confusionMatrix(matriz_confusao)

# Criando nosso codigo com a validação cruzada 

# nfolds = 5 -->  Isso significa que seus dados serão divididos em 5 partes, 
# e o modelo será treinado e avaliado 5 vezes, utilizando cada parte como 
# conjunto de teste uma vez.


classificador_cv <- h2o.deeplearning(
  y = 'default',
  training_frame = as.h2o(base_treinamento),
  activation = 'Rectifier',
  hidden = c(100, 50),
  epochs = 1000,
  nfolds = 5,
  rate = 0.05,
  momentum_start = 0.09,
  input_dropout_ratio =  0.2
  )


# Criando minha previsoes

previsoes_cv <- predict(classificador_cv, as.h2o(base_teste[-4]))
previsoes_cv

# Convertendo nossas previsoes para os valores ficarem em 0 e 1 

previsoes_cv <- (previsoes_cv > 0.5)
previsoes_cv

# Transformando em vetor nossas previsoes

previsoes_cv <- as.vector(previsoes_cv)
previsoes_cv

# Ciando nossa Matriz de confusão

matriz_confusao_cv <- table(base_teste[, 4], previsoes_cv)
matriz_confusao_cv

# Veriricando nossa Matriz de confusão com outras metricas
confusionMatrix(matriz_confusao_cv)






