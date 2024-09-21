# Previsao_de_Inadimplencia_de_Emprestimos_Redes_Neuraris_Artificiais

Previsão de Inadimplência de Empréstimos com Redes Neurais

**Introdução**

Este projeto visa desenvolver um modelo de classificação utilizando Redes Neurais Artificiais para prever a probabilidade de inadimplência de clientes de crédito. O objetivo é auxiliar instituições financeiras a tomar decisões mais assertivas na concessão de crédito.


**Metodologia**

**Pré-processamento:**

* Limpeza e tratamento de outliers.
* Padronização das features numéricas.
* Imputação de valores faltantes na idade utilizando a técnica de KNN.

**Modelagem:**

* Arquitetura: Rede neural feedforward com 2  camadas ocultas (100, 100 neurônios), função de ativação Rectifier.

* Hiperparâmetros: Taxa de aprendizado = 0.01, momentum = 0.9, dropout = 0.2.

* Otimizador: Adam.
    
* Validação cruzada: 5-fold cross-validation.

**Avaliação:**

* Métricas: Acurácia, precisão, recall, F1-score 

**Modelagem:**

**Algoritmo:** 

As Redes Neurais Artificiais foi o modelo  escolhido devido à sua capacidade de lidar com problemas de classificação.

* **Ajuste de hiperparâmetros:** 

**Resultados**

O modelo alcançou uma acurácia de 99.6%, base de testes. A matriz de confusão indicam um bom desempenho na classificação de exemplos positivos (inadimplentes).

![image](https://github.com/user-attachments/assets/1a50dbc0-d5f9-4a70-a01d-379cdfc6de15)

**Limitações**

**Dados fictícios:** 

Os resultados podem não ser generalizáveis para dados reais.

**Desbalanceamento de classes:** 

O dataset apresenta um desbalanceamento entre as classes, o que pode afetar a performance do modelo.

**Simplicidade do modelo:** 

O modelo utilizado é relativamente simples e pode ser aprimorado com técnicas mais avançadas.

**Requisitos**

**R:** Versão 4.0 ou superior.

**Bibliotecas:** 

caTools, h2o, caret, scikit-learn

**Autor:** 

Matheus Andrade Moreira
