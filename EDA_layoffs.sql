--Exploratory Data Analysis


SELECT* 
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
order by total_laid_off desc;

SELECT company,sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT max(`date`), min(`date`)
FROM layoffs_staging2;

SELECT industry,sum(total_laid_off)
FROM layoffs_staging2
group by industry
order by 2 desc;

SELECT* 
FROM layoffs_staging2;

SELECT country,sum(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc;

SELECT `date`,sum(total_laid_off)
FROM layoffs_staging2
group by `date`
order by 1 desc;


SELECT YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
group by YEAR(`date`)
order by 1 desc;

SELECT stage,sum(total_laid_off)
FROM layoffs_staging2
group by stage
order by 2 desc;

SELECT substring(`date`,6,2) AS `MONTH`,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`;

SELECT substring(`date`,1,7) AS `MONTH`,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 1 ASC;

SELECT substring(`date`,1,7) AS `MONTH`,sum(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS(
SELECT substring(`date`,1,7) AS `MONTH`,sum(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off,SUM(total_off) OVER(ORDER BY `MONTH`) AS Rolling__Total
FROM Rolling_Total;

SELECT company,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company,YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC
)
SELECT*
FROM Company_Year;

WITH Company_Year (company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
)
SELECT*, dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC)
FROM Company_Year
WHERE years IS NOT NULL;

WITH Company_Year (company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
)
SELECT*, dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

WITH Company_Year (company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
),
Company_Year_Rank AS(
SELECT*, dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking<= 5;

SELECT stage,ROUND(AVG(percentage_laid_off),2)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

