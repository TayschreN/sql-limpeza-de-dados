📊 SQL Data Cleaning — Layoffs 2022

📌 Visão Geral

Este projeto tem como objetivo realizar a limpeza, padronização e preparação de dados utilizando MySQL, a partir do dataset Layoffs 2022, disponível no Kaggle.

O foco do projeto foi aplicar boas práticas comuns em rotinas de Análise de Dados, BI e Engenharia de Dados.

🎯 Objetivos do Projeto

Identificar e remover duplicatas reais

Padronizar dados 

Tratar valores nulos

Converter tipos de dados

Preparar os dados para Análise Exploratória (EDA)

🗂️ Dataset

Nome: Layoffs 2022 (Kaggle)

Link: https://www.kaggle.com/datasets/swaptr/layoffs-2022

O dataset contém informações sobre demissões em empresas de tecnologia ao redor do mundo, incluindo:
Empresa

Localização, Indústria, Total de demissões, Percentual de funcionários demitidos, Data do evento, Estágio da empresa, País, Fundos captados

🛠️ Tecnologias Utilizadas

MySQL (WorkBench)

SQL 
🔎 Etapas do Projeto


1️⃣ Inspeção Inicial

Análise preliminar da estrutura e dos dados brutos para compreensão do dataset.

2️⃣ Criação da Tabela de Staging

Criação de uma tabela intermediária para preservar os dados originais e permitir transformações seguras.


3️⃣ Remoção de Duplicatas

Identificação de duplicatas reais utilizando ROW_NUMBER()

Criação de uma segunda tabela de staging

Remoção segura de registros duplicados


4️⃣ Padronização dos Dados

Conversão de valores vazios para NULL

Preenchimento de valores ausentes com base em registros semelhantes

Padronização de categorias (ex: Crypto)

Correção de inconsistências em nomes de países


5️⃣ Conversão de Tipos de Dados

Conversão da coluna de datas de texto para o tipo DATE


6️⃣ Tratamento de Valores Nulos

Remoção de registros sem informações relevantes para análise


7️⃣ Limpeza Final

Remoção de colunas auxiliares

Dataset final pronto para análise exploratória
