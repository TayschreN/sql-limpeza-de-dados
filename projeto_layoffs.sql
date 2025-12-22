/*
===========================================================
Projeto Limpeza de Dados em SQL - Layoffs 2022
Dataset: Layoffs 2022 (Kaggle)
Fonte: https://www.kaggle.com/datasets/swaptr/layoffs-2022
Ferramenta: MySQL
Objetivo:
	Limpar, padronizar e preparar os dados para análise
    exploratória (EDA), aplicando boas práticas de SQL.
===========================================================
*/
-- 1. INSPEÇÃO INICIAL DOS DADOS
SELECT *
FROM world_layoffs.layoffs;

-- 2. CRIAÇÃO DA TABELA DE TESTE
-- A tabela de staging preserva os dados brutos e permite realizar transformações sem risco ao dataset original.
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

INSERT INTO world_layoffs.layoffs_staging
SELECT * FROM world_layoffs.layoffs;

-- 3. REMOÇÃO DE DUPLICATAS
-- Identificação de duplicatas reais utilizando ROW_NUMBER() com base em todas as colunas relevantes.
CREATE TABLE world_layoffs.layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT,
    row_num INT
);

INSERT INTO world_layoffs.layoffs_staging2
SELECT
    company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off,
    `date`,
    stage,
    country,
    funds_raised_millions,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off,
                     percentage_laid_off, `date`, stage, country,
                     funds_raised_millions
    ) AS row_num
FROM world_layoffs.layoffs_staging;

-- Remoção das linhas duplicadas
DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;

-- 4. PADRONIZAÇÃO DOS DADOS
-- 4.1 Tratamento da coluna INDUSTRY, Converte valores vazios para NULL
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Preenchimento de valores nulos com base em registros da mesma empresa
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- 4.2 Padronização de categorias
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');


-- 4.3 Padronização da coluna COUNTRY, Remove ponto final em nomes de países
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- 5. CONVERSÃO DE DATAS
-- Conversão da coluna DATE de texto para tipo DATE
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 6. TRATAMENTO DE VALORES NULOS
-- Remoção de registros sem informações relevantes para análise (total_laid_off e percentage_laid_off nulos)
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- 7. LIMPEZA FINAL
-- Remoção da coluna auxiliar utilizada no controle de duplicatas
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- 8. RESULTADO FINAL
SELECT *
FROM world_layoffs.layoffs_staging2;